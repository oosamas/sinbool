const fs = require('fs');
const https = require('https');

const CLIENT_ID = process.env.FIREBASE_CLIENT_ID;
const CLIENT_SECRET = process.env.FIREBASE_CLIENT_SECRET;

if (!CLIENT_ID || !CLIENT_SECRET) {
  console.error('Missing required environment variables:');
  console.error('  FIREBASE_CLIENT_ID');
  console.error('  FIREBASE_CLIENT_SECRET');
  process.exit(1);
}

const config = JSON.parse(fs.readFileSync(process.env.HOME + '/.config/configstore/firebase-tools.json', 'utf8'));
const params = new URLSearchParams();
params.append('grant_type', 'refresh_token');
params.append('refresh_token', config.tokens.refresh_token);
params.append('client_id', CLIENT_ID);
params.append('client_secret', CLIENT_SECRET);
const data = params.toString();
const req = https.request({hostname:'oauth2.googleapis.com',path:'/token',method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','Content-Length':Buffer.byteLength(data)}}, (res) => {
  let body = '';
  res.on('data', (chunk) => body += chunk);
  res.on('end', () => process.stdout.write(JSON.parse(body).access_token));
});
req.write(data);
req.end();

const fs = require('fs');
const https = require('https');
const config = JSON.parse(fs.readFileSync(process.env.HOME + '/.config/configstore/firebase-tools.json', 'utf8'));
const params = new URLSearchParams();
params.append('grant_type', 'refresh_token');
params.append('refresh_token', config.tokens.refresh_token);
params.append('client_id', '563584335869-fgrhgmd47bqnekij5i8b5pr03ho849e6.apps.googleusercontent.com');
params.append('client_secret', 'j9iVZfS8kkCEFUPaAeJV0sAi');
const data = params.toString();
const req = https.request({hostname:'oauth2.googleapis.com',path:'/token',method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','Content-Length':Buffer.byteLength(data)}}, (res) => {
  let body = '';
  res.on('data', (chunk) => body += chunk);
  res.on('end', () => process.stdout.write(JSON.parse(body).access_token));
});
req.write(data);
req.end();

#!/usr/bin/env node
// Upload generated audio files to Firebase Storage using GCS REST API
// Usage: node tools/upload_to_storage.js [language]

const fs = require('fs');
const path = require('path');
const https = require('https');

const CLIENT_ID = process.env.FIREBASE_CLIENT_ID;
const CLIENT_SECRET = process.env.FIREBASE_CLIENT_SECRET;

if (!CLIENT_ID || !CLIENT_SECRET) {
  console.error('Missing required environment variables:');
  console.error('  FIREBASE_CLIENT_ID');
  console.error('  FIREBASE_CLIENT_SECRET');
  process.exit(1);
}

const BUCKET = 'sinbool-6e4c3.firebasestorage.app';
const language = process.argv[2] || 'en';
const audioDir = path.join(__dirname, 'generated_audio', language);

function getFirebaseToken() {
  const configPath = path.join(process.env.HOME, '.config', 'configstore', 'firebase-tools.json');
  const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
  return config.tokens.refresh_token;
}

function refreshAccessToken(refreshToken) {
  return new Promise((resolve, reject) => {
    const params = new URLSearchParams();
    params.append('grant_type', 'refresh_token');
    params.append('refresh_token', refreshToken);
    params.append('client_id', CLIENT_ID);
    params.append('client_secret', CLIENT_SECRET);
    const data = params.toString();

    const req = https.request({
      hostname: 'oauth2.googleapis.com',
      path: '/token',
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Content-Length': Buffer.byteLength(data) },
    }, (res) => {
      let body = '';
      res.on('data', (c) => body += c);
      res.on('end', () => {
        if (res.statusCode === 200) resolve(JSON.parse(body).access_token);
        else reject(new Error('Token refresh failed: ' + body));
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

function uploadFile(accessToken, localPath, storageName) {
  return new Promise((resolve, reject) => {
    const fileData = fs.readFileSync(localPath);
    const encodedName = encodeURIComponent(storageName);

    const req = https.request({
      hostname: 'storage.googleapis.com',
      path: `/upload/storage/v1/b/${BUCKET}/o?uploadType=media&name=${encodedName}`,
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'audio/wav',
        'Content-Length': fileData.length,
      },
    }, (res) => {
      let body = '';
      res.on('data', (c) => body += c);
      res.on('end', () => {
        if (res.statusCode === 200) resolve(true);
        else reject(new Error(`${res.statusCode}: ${body}`));
      });
    });
    req.on('error', reject);
    req.write(fileData);
    req.end();
  });
}

async function main() {
  if (!fs.existsSync(audioDir)) {
    console.error('Directory not found: ' + audioDir);
    process.exit(1);
  }

  const files = fs.readdirSync(audioDir).filter(f => f.endsWith('.mp3'));
  console.log('Uploading ' + files.length + ' audio files for language: ' + language);
  console.log('Bucket: ' + BUCKET);
  console.log('');

  console.log('Authenticating...');
  const refreshToken = getFirebaseToken();
  const accessToken = await refreshAccessToken(refreshToken);
  console.log('Authenticated.\n');

  let uploaded = 0;
  let failed = 0;

  for (const file of files) {
    const localPath = path.join(audioDir, file);
    const storagePath = 'audio/' + language + '/' + file;
    const sizeKB = (fs.statSync(localPath).size / 1024).toFixed(1);

    try {
      await uploadFile(accessToken, localPath, storagePath);
      console.log('  OK ' + file + ' (' + sizeKB + ' KB)');
      uploaded++;
    } catch (err) {
      console.error('  FAIL ' + file + ': ' + err.message);
      failed++;
    }
  }

  console.log('\n=== Upload Complete ===');
  console.log('Uploaded: ' + uploaded);
  console.log('Failed: ' + failed);
}

main().catch(console.error);

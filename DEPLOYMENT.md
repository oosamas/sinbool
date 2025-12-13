# Sinbool App Deployment Guide

## Prerequisites

- Flutter SDK 3.10+
- Xcode 15+ (for iOS)
- Android Studio (for Android)
- Apple Developer Account ($99/year)
- Google Play Developer Account ($25 one-time)
- Firebase Account (free)

---

## Part 1: Firebase Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create a project"
3. Name it: `sinbool-app`
4. Enable Google Analytics (recommended)
5. Select or create an Analytics account

### Step 2: Install FlutterFire CLI

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli
```

### Step 3: Configure Firebase for Flutter

```bash
cd "/Users/osamas/Desktop/Sinbool App/sinbool"

# This will automatically configure all platforms
flutterfire configure --project=sinbool-app
```

This command will:
- Create Android app in Firebase
- Create iOS app in Firebase
- Generate `lib/firebase_options.dart`
- Download `google-services.json` (Android)
- Download `GoogleService-Info.plist` (iOS)

### Step 4: Enable Firebase Services

In Firebase Console, enable:

1. **Authentication** → Sign-in method → Anonymous (for children's app)
2. **Firestore Database** → Create database → Start in production mode
3. **Crashlytics** → Enable
4. **Analytics** → Already enabled

### Step 5: Firestore Security Rules

Go to Firestore → Rules and paste:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Chapters - read only
    match /chapters/{chapterId} {
      allow read: if true;
      allow write: if false;
    }

    // Lessons - read only
    match /lessons/{lessonId} {
      allow read: if true;
      allow write: if false;
    }

    // User progress - authenticated users only
    match /users/{userId}/progress/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Bookmarks - authenticated users only
    match /users/{userId}/bookmarks/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## Part 2: Android Deployment (Google Play Store)

### Step 1: Create Signing Key

```bash
cd "/Users/osamas/Desktop/Sinbool App/sinbool/android"

# Generate release keystore
keytool -genkey -v -keystore sinbool-release.keystore \
  -alias sinbool \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

**IMPORTANT**: Save the passwords securely! You'll need them forever.

### Step 2: Create key.properties

Create `android/key.properties`:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=sinbool
storeFile=sinbool-release.keystore
```

**IMPORTANT**: Add to `.gitignore`:
```
android/key.properties
android/*.keystore
```

### Step 3: Build Release APK/Bundle

```bash
cd "/Users/osamas/Desktop/Sinbool App/sinbool"

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release --flavor production

# Output: build/app/outputs/bundle/productionRelease/app-production-release.aab
```

### Step 4: Google Play Console Setup

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new app
3. Fill in app details:
   - App name: **Sinbool - Islamic Stories for Kids**
   - Default language: English
   - App category: Education
   - Free

### Step 5: Store Listing

**Short Description (80 chars):**
```
Beautiful Islamic stories from the Quran for children. Learn about prophets!
```

**Full Description (4000 chars):**
```
Sinbool brings the beautiful stories of the Quran to life for children!

FEATURES:
★ Stories of the Prophets - Learn about Prophet Adam, Nuh, Ibrahim, Musa, Isa, and Muhammad (peace be upon them all)
★ Audio Narration - Listen to stories with professional narration
★ Multiple Languages - Available in English, Arabic, Urdu, Indonesian, Spanish, and French
★ Offline Access - Download stories to read without internet
★ Progress Tracking - Track your child's learning journey
★ Parental Controls - Set time limits and manage content
★ Kid-Friendly Design - Beautiful illustrations and easy navigation
★ COPPA Compliant - Safe for children, no ads, no data collection

CHAPTERS INCLUDE:
• Stories of the Prophets
• Companions of the Prophet
• Islamic Values & Morals
• Miracles in the Quran
• Daily Duas & Prayers

Perfect for Muslim families who want to teach their children about Islam in an engaging, age-appropriate way.

Download Sinbool today and start your child's Islamic learning journey!
```

**Screenshots Required:**
- Phone: 2-8 screenshots (1080x1920 or 1920x1080)
- 7-inch tablet: Up to 8 screenshots
- 10-inch tablet: Up to 8 screenshots

### Step 6: Content Rating

Complete the content rating questionnaire:
- Violence: None
- Sexual content: None
- Language: None
- Controlled substances: None
- COPPA: **Yes, this app is directed at children**

### Step 7: App Privacy

- Data safety: Minimal data collection
- Kids section: Yes, designed for children
- Ads: No ads
- In-app purchases: No (or optional premium)

### Step 8: Release

1. Upload `.aab` file to Production track
2. Roll out to 100% of users
3. Submit for review (takes 1-7 days)

---

## Part 3: iOS Deployment (App Store)

### Step 1: Apple Developer Setup

1. Enroll at [Apple Developer Program](https://developer.apple.com/programs/)
2. Pay $99/year fee
3. Wait for approval (24-48 hours)

### Step 2: Create App ID & Certificates

In [Apple Developer Portal](https://developer.apple.com/account):

1. **Identifiers** → Create App ID
   - Bundle ID: `com.sinbool.sinbool`
   - Capabilities: Push Notifications (optional)

2. **Certificates** → Create Distribution Certificate

3. **Profiles** → Create App Store Distribution Profile

### Step 3: Xcode Configuration

```bash
cd "/Users/osamas/Desktop/Sinbool App/sinbool/ios"
open Runner.xcworkspace
```

In Xcode:
1. Select "Runner" target
2. Signing & Capabilities:
   - Team: Your Apple Developer Team
   - Bundle Identifier: `com.sinbool.sinbool`
   - Signing Certificate: Distribution

### Step 4: Build iOS Archive

```bash
cd "/Users/osamas/Desktop/Sinbool App/sinbool"

# Build iOS release
flutter build ipa --release

# Output: build/ios/ipa/sinbool.ipa
```

Or via Xcode:
1. Product → Archive
2. Distribute App → App Store Connect
3. Upload

### Step 5: App Store Connect Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. My Apps → New App
3. Fill in details:
   - Platform: iOS
   - Name: Sinbool - Islamic Stories for Kids
   - Primary Language: English
   - Bundle ID: com.sinbool.sinbool
   - SKU: sinbool-ios-001

### Step 6: App Information

**Category:** Education (Primary), Books (Secondary)

**Age Rating:** 4+ (Made for Kids)

**Privacy Policy URL:** Required - host on your website

### Step 7: Screenshots Required

| Device | Size | Required |
|--------|------|----------|
| iPhone 6.7" | 1290 x 2796 | Yes |
| iPhone 6.5" | 1284 x 2778 | Yes |
| iPhone 5.5" | 1242 x 2208 | Yes |
| iPad Pro 12.9" | 2048 x 2732 | If supporting iPad |

### Step 8: App Review Information

- Demo account: Not needed (no login required)
- Contact info: Your email and phone
- Notes: "This is a children's Islamic education app with stories from the Quran"

### Step 9: Submit for Review

1. Upload build from Xcode
2. Select build in App Store Connect
3. Submit for Review (takes 1-3 days)

---

## Part 4: Post-Launch Checklist

### Firebase Monitoring
- [ ] Monitor Crashlytics for crashes
- [ ] Check Analytics for user engagement
- [ ] Review Firestore usage

### App Store Optimization
- [ ] Respond to reviews
- [ ] Update screenshots for new features
- [ ] A/B test app icon and screenshots

### Updates
- [ ] Plan regular content updates
- [ ] Fix bugs reported by users
- [ ] Add new stories periodically

---

## Quick Commands Reference

```bash
# Firebase setup
flutterfire configure --project=sinbool-app

# Android release
flutter build appbundle --release --flavor production

# iOS release
flutter build ipa --release

# Run tests
flutter test

# Analyze code
flutter analyze
```

---

## Support

For issues:
- Flutter: https://flutter.dev/docs
- Firebase: https://firebase.google.com/docs
- Play Console: https://support.google.com/googleplay/android-developer
- App Store: https://developer.apple.com/support/

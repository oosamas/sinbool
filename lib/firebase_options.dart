import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default Firebase options for each platform.
///
/// To configure Firebase:
/// 1. Go to https://console.firebase.google.com
/// 2. Create a new project or select existing one
/// 3. Add Android app with package name: com.sinbool.sinbool
/// 4. Add iOS app with bundle ID: com.sinbool.sinbool
/// 5. Download and add the configuration files:
///    - Android: google-services.json to android/app/
///    - iOS: GoogleService-Info.plist to ios/Runner/
/// 6. Replace the placeholder values below with your Firebase config
///
/// Run: flutterfire configure (after installing FlutterFire CLI)
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // TODO: Replace with your Firebase Web config
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'sinbool-app',
    authDomain: 'sinbool-app.firebaseapp.com',
    storageBucket: 'sinbool-app.appspot.com',
  );

  // TODO: Replace with your Firebase Android config
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'sinbool-app',
    storageBucket: 'sinbool-app.appspot.com',
  );

  // TODO: Replace with your Firebase iOS config
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'sinbool-app',
    storageBucket: 'sinbool-app.appspot.com',
    iosBundleId: 'com.sinbool.sinbool',
  );

  // TODO: Replace with your Firebase macOS config
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'sinbool-app',
    storageBucket: 'sinbool-app.appspot.com',
    iosBundleId: 'com.sinbool.sinbool',
  );

  // TODO: Replace with your Firebase Windows config
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'YOUR_WINDOWS_API_KEY',
    appId: 'YOUR_WINDOWS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'sinbool-app',
    storageBucket: 'sinbool-app.appspot.com',
  );
}

// File generated based on Firebase configuration
// Project: sinbool-6e4c3

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATu6Je4C6qFfMUg00t8CEPdAyefX3zoAs',
    appId: '1:403072536070:android:d17fda13a4e5b65990fd87',
    messagingSenderId: '403072536070',
    projectId: 'sinbool-6e4c3',
    storageBucket: 'sinbool-6e4c3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiviviL7mX7p1BFBzJ83r_9XHu9V6UQYM',
    appId: '1:403072536070:ios:40d493fb7d2b578690fd87',
    messagingSenderId: '403072536070',
    projectId: 'sinbool-6e4c3',
    storageBucket: 'sinbool-6e4c3.firebasestorage.app',
    iosBundleId: 'com.sinbool.sinbool',
  );
}

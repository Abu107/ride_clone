// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjgpIAJq3GbSoc62LWMQBcKX-dSLfMqRM',
    appId: '1:647484639258:web:90aaed5a17f5599f3fa9a3',
    messagingSenderId: '647484639258',
    projectId: 'ride-b9b64',
    authDomain: 'ride-b9b64.firebaseapp.com',
    storageBucket: 'ride-b9b64.appspot.com',
    measurementId: 'G-XYM8MP3RMK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ7mjPKxWlrIi-eCgYyMDKTy1-95Fa1cs',
    appId: '1:647484639258:android:e3d3c51f009afe3b3fa9a3',
    messagingSenderId: '647484639258',
    projectId: 'ride-b9b64',
    storageBucket: 'ride-b9b64.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgO39s5C9BGLlRn_I1KjH9cRec8oCvRIM',
    appId: '1:647484639258:ios:de3d322fcdf4ecf03fa9a3',
    messagingSenderId: '647484639258',
    projectId: 'ride-b9b64',
    storageBucket: 'ride-b9b64.appspot.com',
    iosBundleId: 'com.zenva.ride',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgO39s5C9BGLlRn_I1KjH9cRec8oCvRIM',
    appId: '1:647484639258:ios:de3d322fcdf4ecf03fa9a3',
    messagingSenderId: '647484639258',
    projectId: 'ride-b9b64',
    storageBucket: 'ride-b9b64.appspot.com',
    iosBundleId: 'com.zenva.ride',
  );
}

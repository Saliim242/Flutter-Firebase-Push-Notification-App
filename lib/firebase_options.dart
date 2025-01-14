// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLO55tz8v4jRaSaWQDu_Li0HP1eo2nStQ',
    appId: '1:1006232752451:web:b50dc739239cc315a99ff6',
    messagingSenderId: '1006232752451',
    projectId: 'flutter-firebase-messagi-6a61f',
    authDomain: 'flutter-firebase-messagi-6a61f.firebaseapp.com',
    storageBucket: 'flutter-firebase-messagi-6a61f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJyHGY6Uf8U35mWUUzrrBexnOs-JDxgO4',
    appId: '1:1006232752451:android:4553ce5b65801560a99ff6',
    messagingSenderId: '1006232752451',
    projectId: 'flutter-firebase-messagi-6a61f',
    storageBucket: 'flutter-firebase-messagi-6a61f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDejd4xs4r1IJfQ1zvGX3hciodVtNnT09Y',
    appId: '1:1006232752451:ios:93ad5168fee0acffa99ff6',
    messagingSenderId: '1006232752451',
    projectId: 'flutter-firebase-messagi-6a61f',
    storageBucket: 'flutter-firebase-messagi-6a61f.appspot.com',
    iosBundleId: 'com.example.flutterNotificationApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDejd4xs4r1IJfQ1zvGX3hciodVtNnT09Y',
    appId: '1:1006232752451:ios:93ad5168fee0acffa99ff6',
    messagingSenderId: '1006232752451',
    projectId: 'flutter-firebase-messagi-6a61f',
    storageBucket: 'flutter-firebase-messagi-6a61f.appspot.com',
    iosBundleId: 'com.example.flutterNotificationApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLO55tz8v4jRaSaWQDu_Li0HP1eo2nStQ',
    appId: '1:1006232752451:web:c7b29589e61c2ba5a99ff6',
    messagingSenderId: '1006232752451',
    projectId: 'flutter-firebase-messagi-6a61f',
    authDomain: 'flutter-firebase-messagi-6a61f.firebaseapp.com',
    storageBucket: 'flutter-firebase-messagi-6a61f.appspot.com',
  );
}

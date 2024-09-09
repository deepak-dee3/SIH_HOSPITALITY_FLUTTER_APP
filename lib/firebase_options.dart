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
    apiKey: 'AIzaSyBUBeeIe3td6nFUnNQvoyyFAdF1eBnS8_M',
    appId: '1:450289499651:web:43724b5f67cd14ec409836',
    messagingSenderId: '450289499651',
    projectId: 'sih-2024-project',
    authDomain: 'sih-2024-project.firebaseapp.com',
    databaseURL: 'https://sih-2024-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sih-2024-project.appspot.com',
    measurementId: 'G-CE9P3PYKEK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuFbxSD9W23GecgOZDLZK7DVvi-Jjgkr4',
    appId: '1:450289499651:android:1fa8994f437479af409836',
    messagingSenderId: '450289499651',
    projectId: 'sih-2024-project',
    databaseURL: 'https://sih-2024-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sih-2024-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4PzX0vKqBvYl14cDUp_YwSc3l16Ee6vE',
    appId: '1:450289499651:ios:0190f4f7daf110ef409836',
    messagingSenderId: '450289499651',
    projectId: 'sih-2024-project',
    databaseURL: 'https://sih-2024-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sih-2024-project.appspot.com',
    iosBundleId: 'com.example.sih2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4PzX0vKqBvYl14cDUp_YwSc3l16Ee6vE',
    appId: '1:450289499651:ios:0190f4f7daf110ef409836',
    messagingSenderId: '450289499651',
    projectId: 'sih-2024-project',
    databaseURL: 'https://sih-2024-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sih-2024-project.appspot.com',
    iosBundleId: 'com.example.sih2024',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUBeeIe3td6nFUnNQvoyyFAdF1eBnS8_M',
    appId: '1:450289499651:web:34e76390e5d95c75409836',
    messagingSenderId: '450289499651',
    projectId: 'sih-2024-project',
    authDomain: 'sih-2024-project.firebaseapp.com',
    databaseURL: 'https://sih-2024-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sih-2024-project.appspot.com',
    measurementId: 'G-7LRYGSVE8S',
  );
}
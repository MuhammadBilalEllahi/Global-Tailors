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
    apiKey: 'AIzaSyBDJFap41gPMYIaGNZpBIhIIN40-5MY2oY',
    appId: '1:379557431579:web:f9dfa37d1995e564f32bbe',
    messagingSenderId: '379557431579',
    projectId: 'tailor-90d28',
    authDomain: 'tailor-90d28.firebaseapp.com',
    storageBucket: 'tailor-90d28.appspot.com',
    measurementId: 'G-VE3HPM32T5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIc1H_PhS7yLvhadsfTmIlSOgGTdzKBJo',
    appId: '1:379557431579:android:ab9b7006dbf110aaf32bbe',
    messagingSenderId: '379557431579',
    projectId: 'tailor-90d28',
    storageBucket: 'tailor-90d28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvtYWpYH_C5XCYzafPLhPVLzWZIyqiRb8',
    appId: '1:379557431579:ios:5d6316d081746a04f32bbe',
    messagingSenderId: '379557431579',
    projectId: 'tailor-90d28',
    storageBucket: 'tailor-90d28.appspot.com',
    iosBundleId: 'com.example.tailorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvtYWpYH_C5XCYzafPLhPVLzWZIyqiRb8',
    appId: '1:379557431579:ios:db325ca992c6ac05f32bbe',
    messagingSenderId: '379557431579',
    projectId: 'tailor-90d28',
    storageBucket: 'tailor-90d28.appspot.com',
    iosBundleId: 'com.example.tailorApp.RunnerTests',
  );
}
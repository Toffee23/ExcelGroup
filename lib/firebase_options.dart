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
    apiKey: 'AIzaSyBmioqey7cVpD_nvJBmLsUpiBoijCPmjEo',
    appId: '1:1027112230279:android:1db2b8c4ae1d5426f9c722',
    messagingSenderId: '1027112230279',
    projectId: 'excel-academy-online',
    databaseURL: 'https://excel-academy-online-default-rtdb.firebaseio.com',
    storageBucket: 'excel-academy-online.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEXxk03HDBG2vWxdacTcKrhwPg9gPwZUg',
    appId: '1:1027112230279:ios:f8ff0632c164551ff9c722',
    messagingSenderId: '1027112230279',
    projectId: 'excel-academy-online',
    databaseURL: 'https://excel-academy-online-default-rtdb.firebaseio.com',
    storageBucket: 'excel-academy-online.appspot.com',
    androidClientId: '1027112230279-64d5mvtib4gpfo9bs1fh0kmjpdbs4e2t.apps.googleusercontent.com',
    iosClientId: '1027112230279-4qurvqks6aq07tmb4p3jam6davv9j0ep.apps.googleusercontent.com',
    iosBundleId: 'com.example.courseView',
  );
}

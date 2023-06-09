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
    apiKey: 'AIzaSyCE6-ZWYBKwWGDpQcmA1J7LPftx5XenzLk',
    appId: '1:247845329380:web:175ab681c1c94349404ff1',
    messagingSenderId: '247845329380',
    projectId: 'women-safety-ab693',
    authDomain: 'women-safety-ab693.firebaseapp.com',
    storageBucket: 'women-safety-ab693.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBy-38VnnPVOKhtpiI-sWIViKrQnoyIWDk',
    appId: '1:247845329380:android:4029cba7b232fa7a404ff1',
    messagingSenderId: '247845329380',
    projectId: 'women-safety-ab693',
    storageBucket: 'women-safety-ab693.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCScvAOK29r0Yxfq1GqhwenArVdraH-8dc',
    appId: '1:247845329380:ios:acc4dfe737567fb5404ff1',
    messagingSenderId: '247845329380',
    projectId: 'women-safety-ab693',
    storageBucket: 'women-safety-ab693.appspot.com',
    iosClientId:
        '247845329380-87pm1mo6ldgbp3rfmlvldpjto7m30q63.apps.googleusercontent.com',
    iosBundleId: 'com.example.womenSafety',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCScvAOK29r0Yxfq1GqhwenArVdraH-8dc',
    appId: '1:247845329380:ios:acc4dfe737567fb5404ff1',
    messagingSenderId: '247845329380',
    projectId: 'women-safety-ab693',
    storageBucket: 'women-safety-ab693.appspot.com',
    iosClientId:
        '247845329380-87pm1mo6ldgbp3rfmlvldpjto7m30q63.apps.googleusercontent.com',
    iosBundleId: 'com.example.womenSafety',
  );
}

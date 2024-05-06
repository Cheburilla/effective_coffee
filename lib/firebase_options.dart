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
    apiKey: 'AIzaSyBs0ZXiV2ci8Rj5otigIu2rVOWCSUn0_iw',
    appId: '1:153214160023:web:65992eeeb9935e450eadd2',
    messagingSenderId: '153214160023',
    projectId: 'effective-coffee',
    authDomain: 'effective-coffee.firebaseapp.com',
    storageBucket: 'effective-coffee.appspot.com',
    measurementId: 'G-H208BGEGWX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwQhLkkTVLncZZsM9CuMp3nKh0UiXHLT8',
    appId: '1:153214160023:android:ef8ec578be0412a30eadd2',
    messagingSenderId: '153214160023',
    projectId: 'effective-coffee',
    storageBucket: 'effective-coffee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgDhtpmtmL8m64YbFK1RDWBRLXc-IKFaQ',
    appId: '1:153214160023:ios:cb0b3349f85989880eadd2',
    messagingSenderId: '153214160023',
    projectId: 'effective-coffee',
    storageBucket: 'effective-coffee.appspot.com',
    iosBundleId: 'com.example.effectiveCoffee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgDhtpmtmL8m64YbFK1RDWBRLXc-IKFaQ',
    appId: '1:153214160023:ios:cb0b3349f85989880eadd2',
    messagingSenderId: '153214160023',
    projectId: 'effective-coffee',
    storageBucket: 'effective-coffee.appspot.com',
    iosBundleId: 'com.example.effectiveCoffee',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBs0ZXiV2ci8Rj5otigIu2rVOWCSUn0_iw',
    appId: '1:153214160023:web:21c82d8b2efa84990eadd2',
    messagingSenderId: '153214160023',
    projectId: 'effective-coffee',
    authDomain: 'effective-coffee.firebaseapp.com',
    storageBucket: 'effective-coffee.appspot.com',
    measurementId: 'G-DLEG6NSJ22',
  );

}
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
    apiKey: 'AIzaSyDRCf6Fo26dKauFNoNnlwiPLf-mXBSGegY',
    appId: '1:715888780707:web:4a1d30a9c03060dc05e616',
    messagingSenderId: '715888780707',
    projectId: 'dapp-game-14b47',
    authDomain: 'dapp-game-14b47.firebaseapp.com',
    storageBucket: 'dapp-game-14b47.appspot.com',
    measurementId: 'G-GKN0MXQWRG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHtxdNc4fCzfZwXu1pTqqdMNovIU53YiU',
    appId: '1:715888780707:android:c6d0d38c29801bff05e616',
    messagingSenderId: '715888780707',
    projectId: 'dapp-game-14b47',
    storageBucket: 'dapp-game-14b47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb06XKK9zgsvh1GMnA03-vu639-jYpzKU',
    appId: '1:715888780707:ios:1d041aa5a696408c05e616',
    messagingSenderId: '715888780707',
    projectId: 'dapp-game-14b47',
    storageBucket: 'dapp-game-14b47.appspot.com',
    androidClientId: '715888780707-viahobvvt5llnm7ti36uo8j72j3u5o0b.apps.googleusercontent.com',
    iosClientId: '715888780707-rgpl0mp52gh2f1qvo4vbi2i417mse0bb.apps.googleusercontent.com',
    iosBundleId: 'com.procity.dapgames',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBb06XKK9zgsvh1GMnA03-vu639-jYpzKU',
    appId: '1:715888780707:ios:40114a4c172a6efc05e616',
    messagingSenderId: '715888780707',
    projectId: 'dapp-game-14b47',
    storageBucket: 'dapp-game-14b47.appspot.com',
    androidClientId: '715888780707-viahobvvt5llnm7ti36uo8j72j3u5o0b.apps.googleusercontent.com',
    iosClientId: '715888780707-ar70f3n6b3kesdrpphl2j8heaasecitj.apps.googleusercontent.com',
    iosBundleId: 'com.dapgame.app.dapGame.RunnerTests',
  );
}

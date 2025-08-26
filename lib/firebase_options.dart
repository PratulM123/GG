// File generated manually from Firebase CLI sdkconfig outputs for project "giggy-auth".
// This mirrors the structure produced by `flutterfire configure`.

// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars

import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

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
        return ios; // Reuse iOS for macOS if needed
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return android; // Fallback for unsupported platforms in this app
    }
  }

  // Web options
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjkmXnhe1Qaklz3KW5ycxQjEBjGH4MTyg',
    appId: '1:784943686692:web:39e4be4fe60e88fcf8a4b1',
    messagingSenderId: '784943686692',
    projectId: 'giggy-auth',
    authDomain: 'giggy-auth.firebaseapp.com',
    storageBucket: 'giggy-auth.firebasestorage.app',
    databaseURL: 'https://giggy-auth-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // Android options (package: com.example.global_globe)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSBtQAar2ZtrvuytyYhDk3PpJ5-lX7RnQ',
    appId: '1:784943686692:android:b8996c5cf826b4fff8a4b1',
    messagingSenderId: '784943686692',
    projectId: 'giggy-auth',
    storageBucket: 'giggy-auth.firebasestorage.app',
    databaseURL: 'https://giggy-auth-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // iOS options (bundle id: com.example.globalGlobe)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0XpylPSqjVaODT8W2Br_M2fConoWD7Gw',
    appId: '1:784943686692:ios:b394ec3639a5c718f8a4b1',
    messagingSenderId: '784943686692',
    projectId: 'giggy-auth',
    storageBucket: 'giggy-auth.firebasestorage.app',
    iosBundleId: 'com.example.globalGlobe',
    databaseURL: 'https://giggy-auth-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}




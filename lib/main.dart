import 'dart:async';
import 'dart:developer';
import 'package:effective_coffee/firebase_options.dart';
import 'package:effective_coffee/src/common/local_notification_service.dart';
import 'package:effective_coffee/src/features/menu/bloc/base_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = const BaseObserver();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    LocalNotificationService.initialize();

    FirebaseMessaging.onMessage
        .listen((message) => LocalNotificationService.display(message));

    runApp(const CoffeeShopApp());
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

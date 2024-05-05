import 'dart:async';
import 'dart:developer';
import 'package:effective_coffee/firebase_options.dart';
import 'package:effective_coffee/src/features/menu/bloc/base_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

void main() async{
  Bloc.observer = const BaseObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

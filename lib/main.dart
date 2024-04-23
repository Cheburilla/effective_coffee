import 'dart:async';
import 'dart:developer';
import 'package:effective_coffee/src/features/menu/bloc/base_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

void main() {
  Bloc.observer = const BaseObserver();

  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

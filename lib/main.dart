import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/common/network/api.dart';
import 'package:effective_coffee/src/features/menu/bloc/base_observer.dart';
import 'package:effective_coffee/src/features/menu/data/menu_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

void main() {
  Bloc.observer = const BaseObserver();
  final menuRepository =
      DioMenuRepository(api: EffectiveAcademyApi(), client: Dio());
  runZonedGuarded(
      () => runApp(RepositoryProvider.value(
        value: menuRepository,
        child: const CoffeeShopApp())), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

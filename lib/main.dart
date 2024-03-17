import 'dart:async';
import 'dart:developer';
import 'package:effective_coffee/src/common/network/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/menu/data/menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

void main() {
  runZonedGuarded(
      () => runApp(RepositoryProvider(
          create: (BuildContext context) => DioMenuRepository(api: EffectiveAcademyApi(), client: Dio()),
          child: const CoffeeShopApp())), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

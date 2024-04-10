import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/common/database/database.dart';
import 'package:effective_coffee/src/features/menu/bloc/base_observer.dart';
import 'package:effective_coffee/src/features/menu/data/category_repository.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_categories_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_products_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/order_repository.dart';
import 'package:effective_coffee/src/features/menu/data/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/app.dart';

void main() {
  Bloc.observer = const BaseObserver();
  final dioClient = Dio(BaseOptions(baseUrl: const String.fromEnvironment("BASEURL")));
  final db = AppDatabase();

  runZonedGuarded(
      () => runApp(MultiRepositoryProvider(providers: [
            RepositoryProvider<OrderRepository>(
                create: (context) => OrderRepository(
                    networkOrderDataSource:
                        NetworkOrdersDataSource(dio: dioClient))),
            RepositoryProvider<CategoriesRepository>(
                create: (context) => CategoriesRepository(
                    networkCategoriesDataSource:
                        NetworkCategoriesDataSource(dio: dioClient),
                    dbCategoriesDataSource: DbCategoriesDataSource(db: db))),
            RepositoryProvider<ProductsRepository>(
                create: (context) => ProductsRepository(
                    networkProductsDataSource:
                        NetworkProductsDataSource(dio: dioClient),
                    dbProductsDataSource: DbProductsDataSource(db: db))),
          ], child: const CoffeeShopApp())), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

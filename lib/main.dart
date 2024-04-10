import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
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
  final dioClient = Dio();
  final networkCategoriesDataSource =
      NetworkCategoriesDataSource(dio: dioClient);
  final dbCategoriesDataSource = DbCategoriesDataSource();
  final networkProductsDataSource = NetworkProductsDataSource(dio: dioClient);
  final dbProductsDataSource = DbProductsDataSource();
  final networkOrdersDataSource = NetworkOrdersDataSource(dio: dioClient);
  final productsRepository = ProductsRepository(
    networkProductsDataSource: networkProductsDataSource,
    dbProductsDataSource: dbProductsDataSource,
  );
  final categoriesRepository = CategoriesRepository(
      networkCategoriesDataSource: networkCategoriesDataSource,
      dbCategoriesDataSource: dbCategoriesDataSource);
  final orderRepository =
      OrderRepository(networkOrderDataSource: networkOrdersDataSource);
  runZonedGuarded(
      () => runApp(MultiRepositoryProvider(providers: [
            RepositoryProvider<OrderRepository>(
                create: (context) => orderRepository),
            RepositoryProvider<CategoriesRepository>(
                create: (context) => categoriesRepository),
            RepositoryProvider<ProductsRepository>(
                create: (context) => productsRepository),
          ], child: const CoffeeShopApp())), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}

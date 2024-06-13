import 'package:dio/dio.dart';
import 'package:effective_coffee/src/common/database/database.dart';
import 'package:effective_coffee/src/features/locations/bloc/map/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/bloc/permissions/permissions_bloc.dart';
import 'package:effective_coffee/src/features/locations/data/data_sources/locations_data_source.dart';
import 'package:effective_coffee/src/features/locations/data/data_sources/savable_locations_data_source.dart';
import 'package:effective_coffee/src/features/locations/data/locations_repository.dart';
import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/bloc/menu/menu_bloc.dart';
import 'package:effective_coffee/src/features/menu/data/category_repository.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_categories_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_products_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/order_repository.dart';
import 'package:effective_coffee/src/features/menu/data/products_repository.dart';
import 'package:effective_coffee/src/features/menu/view/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:effective_coffee/src/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  static final dioClient = Dio(
    BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'),
  );
  static final db = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ILocationsRepository>(
          create: (context) => LocationsRepository(
            networkLocationsDataSource:
                NetworkLocationsDataSource(dio: dioClient),
            dbLocationsDataSource: DbLocationsDataSource(db: db),
          ),
        ),
        RepositoryProvider<IOrderRepository>(
          create: (context) => OrderRepository(
            networkOrderDataSource: NetworkOrdersDataSource(dio: dioClient),
          ),
        ),
        RepositoryProvider<ICategoriesRepository>(
          create: (context) => CategoriesRepository(
            networkCategoriesDataSource:
                NetworkCategoriesDataSource(dio: dioClient),
            dbCategoriesDataSource: DbCategoriesDataSource(db: db),
          ),
        ),
        RepositoryProvider<IProductsRepository>(
          create: (context) => ProductsRepository(
            networkProductsDataSource:
                NetworkProductsDataSource(dio: dioClient),
            dbProductsDataSource: DbProductsDataSource(db: db),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        theme: theme,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CartBloc(
                context.read<IOrderRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => PermissionsBloc()
                ..add(const PermissionRequested(Permission.location)),
              lazy: false,
            ),
            BlocProvider(
              create: (context) => MenuBloc(
                context.read<IProductsRepository>(),
                context.read<ICategoriesRepository>(),
              )..add(
                  const CategoryLoadingStarted(),
                ),
            ),
            BlocProvider(
              create: (context) => MapBloc(context.read<ILocationsRepository>())
                ..add(const MapLoadingStarted()),
            ),
          ],
          child: const MenuScreen(),
        ),
      ),
    );
  }
}

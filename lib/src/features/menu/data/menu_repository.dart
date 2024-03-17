import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/common/network/api.dart';
import 'package:effective_coffee/src/common/network/api_exception.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

abstract class MenuRepository {
  Future<List<CategoryModel>> getCategories();
  Future<ProductInfoModel> getProductInfo(String id);
}

class DioMenuRepository implements MenuRepository {
  DioMenuRepository({required this.api, required this.client});
  final EffectiveAcademyApi api;
  final Dio client;

  @override
  Future<List<CategoryModel>> getCategories() {
    // TODO: implement getProductInfo
    throw UnimplementedError();
  }

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri.toString());
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.data);
          return builder(data);
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future<ProductInfoModel> getProductInfo(String id) {
    // TODO: implement getProductInfo
    throw UnimplementedError();
  }
}

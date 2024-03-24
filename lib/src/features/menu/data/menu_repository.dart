import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/common/network/api.dart';
import 'package:effective_coffee/src/common/network/api_exception.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

abstract class MenuRepository {
  Future<List<CategoryModel>> getCategories({int? page, int? limit});
  Future<ProductInfoModel> getProductInfo(int id);
  Future<List<ProductInfoModel>> getProducts(
      {int? page, int? limit, CategoryModel? category});
  Future<void> postOrder(Map<ProductInfoModel, int> items);
}

class DioMenuRepository implements MenuRepository {
  DioMenuRepository({required this.api, required this.client});
  final EffectiveAcademyApi api;
  final Dio client;

  @override
  Future<List<CategoryModel>> getCategories({int? page, int? limit}) =>
      _getData(
        uri: api.categories(page: page, limit: limit),
        builder: (data) => (data as List)
            .map<CategoryModel>((i) => CategoryModel.fromJSON(i))
            .toList(),
      );

  @override
  Future<List<ProductInfoModel>> getProducts(
          {int? page, int? limit, CategoryModel? category}) =>
      _getData(
        uri: api.products(page: page, limit: limit, category: category?.id),
        builder: (data) => (data as List)
            .map<ProductInfoModel>((i) => ProductInfoModel.fromJSON(i))
            .toList(),
      );

  @override
  Future<ProductInfoModel> getProductInfo(int id) => _getData(
        uri: api.product(id),
        builder: (data) => ProductInfoModel.fromJSON(data),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri.toString());
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          return builder(data);
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future<bool> postOrder(Map<ProductInfoModel, int> items) =>
      _postData(uri: api.order(), sendingData: {
        "positions": items.map(
          (key, value) => MapEntry(key.id.toString(), value),
        ),
        "token": "<FCM Registration Token>"
      });

  Future<bool> _postData({
    required Uri uri,
    required Object sendingData,
  }) async {
    try {
      final request = sendingData;
      final response = await client.post(
        uri.toString(),
        data: json.encode(request),
      );
      switch (response.statusCode) {
        case 201:
          return true;
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

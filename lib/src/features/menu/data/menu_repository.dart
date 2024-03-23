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
              .map<CategoryModel>((i) => CategoryModel.fromJson(i))
              .toList());

  @override
  Future<ProductInfoModel> getProductInfo(int id) => _getData(
        uri: api.product(id),
        builder: (data) => ProductInfoModel.fromJson(data),
      );

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
  Future<Map<String, String>> postOrder(Map<ProductInfoModel, int> items) => _postData(
        uri: api.order(),
        builder: (data) => <String, String>{},
        sendingData: json.encode(items.map((key, value) => MapEntry(key.id, value),)),
      );

  Future<T> _postData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
    required String sendingData,
  }) async {
    try {
      final request = {"positions": sendingData, "token": "<FCM Registration Token>"};
      final response = await client.post(uri.toString(), data: request);
      switch (response.statusCode) {
        case 201:
          final data = json.decode(response.data);
          return builder(data);
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

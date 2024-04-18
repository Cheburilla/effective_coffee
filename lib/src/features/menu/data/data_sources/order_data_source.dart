import 'dart:io';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';

abstract interface class IOrderDataSource {
  Future<Map<String, dynamic>> postOrder(
      {required Map<ProductModel, int> items});
}

final class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> postOrder(
      {required Map<ProductModel, int> items}) async {
    final positions = items.map(
      (key, value) => MapEntry(key.id.toString(), value),
    );
    final response =
        await _dio.post('/orders', data: {"positions": positions, "token": ""});
    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw const HttpException('/orders');
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/product_dto.dart';

abstract interface class IProductsDataSource {
  Future<List<ProductDTO>> fetchProducts({
    required int categoryId,
    int page = 0,
    int limit = 25,
  });
  Future<ProductDTO> fetchProduct({required int productId});
}

final class NetworkProductsDataSource implements IProductsDataSource {
  final Dio _dio;

  const NetworkProductsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductDTO>> fetchProducts({
    required int categoryId,
    int page = 0,
    int limit = 25,
  }) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {
          'page': '$page',
          'limit': '$limit',
          'category': '$categoryId',
        },
      );
      final data = response.data['data'];
      if (data is! List) throw const FormatException();
      return (data)
          .map<ProductDTO>(
            (i) => ProductDTO.fromJSON(i),
          )
          .toList();
    } on DioException catch (_) {
      if (_.type == DioExceptionType.connectionError) {
        throw SocketException('/products with categoryId = $categoryId');
      }
      rethrow;
    }
  }

  @override
  Future<ProductDTO> fetchProduct({required int productId}) async {
    try {
      final response = await _dio.get('products/$productId');
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          return ProductDTO.fromJSON(data);
        default:
          throw HttpException('/products/$productId');
      }
    } on DioException catch (_) {
      if (_.type == DioExceptionType.connectionError) {
        throw SocketException('/products/$productId');
      }
      rethrow;
    }
  }
}

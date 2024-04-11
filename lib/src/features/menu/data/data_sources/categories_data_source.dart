import 'dart:io';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/category_dto.dart';

abstract interface class ICategoriesDataSource {
  Future<List<CategoryDTO>> fetchCategories();
}

final class NetworkCategoriesDataSource implements ICategoriesDataSource {
  final Dio _dio;

  const NetworkCategoriesDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CategoryDTO>> fetchCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'];
          if (data is! List) throw const FormatException();
          return (data)
              .map<CategoryDTO>(
                (i) => CategoryDTO.fromJSON(i),
              )
              .toList();
        default:
          throw const HttpException('/categories');
      }
    } on DioException catch (_) {
      if (_.type == DioExceptionType.connectionError) {
        throw const SocketException('/products/categories');
      }
      rethrow;
    }
  }
}

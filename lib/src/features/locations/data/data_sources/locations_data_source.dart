import 'dart:io';
import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/locations/models/DTOs/location_dto.dart';

abstract interface class ILocationsDataSource {
  Future<List<LocationDTO>> fetchLocations();
}

final class NetworkLocationsDataSource implements ILocationsDataSource {
  final Dio _dio;

  const NetworkLocationsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<LocationDTO>> fetchLocations() async {
    try {
      final response = await _dio.get('/locations');
      final data = response.data['data'];
      if (data is! List) throw const FormatException();
      return (data)
          .map<LocationDTO>(
            (i) => LocationDTO.fromJSON(i),
          )
          .toList();
    } on DioException catch (_) {
      if (_.type == DioExceptionType.connectionError) {
        throw const SocketException('/locations');
      }
      rethrow;
    }
  }
}

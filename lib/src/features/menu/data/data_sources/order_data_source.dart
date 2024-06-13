import 'package:dio/dio.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class IOrderDataSource {
  Future<Map<String, dynamic>> postOrder({
    required Map<ProductModel, int> items,
  });
}

final class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> postOrder({
    required Map<ProductModel, int> items,
  }) async {
    final positions = items.map(
      (key, value) => MapEntry(key.id.toString(), value),
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final response =
        await _dio.post('/orders', data: {"positions": positions, "token": fcmToken});
    return response.data;
  }
}

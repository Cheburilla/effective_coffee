import 'package:effective_coffee/src/features/menu/models/category_model.dart';

class ProductInfoModel {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final CategoryModel category;

  const ProductInfoModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });

  factory ProductInfoModel.fromJSON(Map<String, dynamic> json) {
    if (json['prices'] is! List<dynamic> || json['category'] is! Map<String, dynamic>) throw const FormatException();
    final prices = json['prices'];
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imageUrl'],
      name: json['name'],
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: CategoryModel.fromJSON(json['category']),
    );
  }
}

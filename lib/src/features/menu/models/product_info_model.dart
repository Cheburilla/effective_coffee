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
    final prices = json['prices'] is! List<dynamic>
        ? throw const FormatException()
        : json['prices'];
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imageUrl'],
      name: json['name'],
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: json['category'] is! Map<String, dynamic>
          ? throw const FormatException()
          : CategoryModel.fromJSON(json['category']),
    );
  }
}

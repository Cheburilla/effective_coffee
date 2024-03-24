import 'package:effective_coffee/src/features/menu/models/category_model.dart';

class ProductInfoModel {
  final int id;
  final String name;
  final int price;
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
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imageUrl'],
      name: json['name'],
      price: json['prices'][0]['value'],
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );
  }
}

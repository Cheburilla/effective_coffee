import 'package:effective_coffee/src/features/menu/models/category_model.dart';

class ProductModel {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final CategoryModel category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}

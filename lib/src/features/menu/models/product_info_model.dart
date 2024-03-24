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
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imageUrl'],
      name: json['name'],
      price: double.parse(
        ((json['prices'] as List<dynamic>).first
                as Map<String, dynamic>)['value']
            .toString(),
      ),
      category:
          CategoryModel.fromJSON(json['category'] as Map<String, dynamic>),
    );
  }
}

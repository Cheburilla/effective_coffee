import 'package:effective_coffee/src/features/menu/models/DTOs/category_dto.dart';

class ProductDTO {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final CategoryDTO category;

  const ProductDTO({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory ProductDTO.fromJSON(Map<String, dynamic> json) {
    if (json['prices'] is! List<dynamic> || json['category'] is! Map<String, dynamic>) throw const FormatException();
    final prices = json['prices'];
    return ProductDTO(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: CategoryDTO.fromJSON(json['category']),
    );
  }
}

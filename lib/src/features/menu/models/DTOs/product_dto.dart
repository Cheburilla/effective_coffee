import 'package:effective_coffee/src/features/menu/models/DTOs/category_dto.dart';

class ProductDTO {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final CategoryDTO category;

  const ProductDTO({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  factory ProductDTO.fromJSON(Map<String, dynamic> json) {
    if (json['prices'] is! List<dynamic> ||
        json['category'] is! Map<String, dynamic>) {
      throw const FormatException();
    }
    final prices = json['prices'];
    return ProductDTO(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: CategoryDTO.fromJSON(json['category']),
    );
  }

  factory ProductDTO.fromDB(product, category) {
    return ProductDTO(
      id: product.id,
      name: product.name,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      category: CategoryDTO(id: category.id, slug: category.slug),
    );
  }
}

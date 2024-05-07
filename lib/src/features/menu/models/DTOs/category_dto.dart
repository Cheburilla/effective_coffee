import 'package:effective_coffee/src/common/database/database.dart';

class CategoryDTO {
  final String slug;
  final int id;

  const CategoryDTO({
    required this.slug,
    required this.id,
  });

  factory CategoryDTO.fromJSON(Map<String, dynamic> json) {
    return CategoryDTO(
      slug: json['slug'],
      id: json['id'],
    );
  }

  static fromDB(Category category) {
    return CategoryDTO(slug: category.slug, id: category.id);
  }
}

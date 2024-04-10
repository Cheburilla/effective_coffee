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
}

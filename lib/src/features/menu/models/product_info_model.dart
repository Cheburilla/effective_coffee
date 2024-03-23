class ProductInfoModel {
  final int id;
  final String name;
  final int price;
  final String? imagePath;

  const ProductInfoModel({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath,
  });

  factory ProductInfoModel.fromJSON(Map<String, dynamic> json) {
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imagePath'],
      name: json['name'],
      price: json['price'],
    );
  }

  static fromJson(data) {}
}

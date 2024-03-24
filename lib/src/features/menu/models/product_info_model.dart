class ProductInfoModel {
  final int id;
  final String name;
  final int price;
  final String imagePath;

  const ProductInfoModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  factory ProductInfoModel.fromJSON(Map<String, dynamic> json) {
    return ProductInfoModel(
      id: json['id'],
      imagePath: json['imageUrl'],
      name: json['name'],
      price: json['prices'][0]['value'],
    );
  }
}

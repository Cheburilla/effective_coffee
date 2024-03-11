class ProductInfoModel {
  final String name;
  final int price;
  final String? imagePath;

  const ProductInfoModel({
    required this.name,
    required this.price,
    this.imagePath,
  });

  factory ProductInfoModel.fromJSON(Map<String, dynamic> json) {
    return ProductInfoModel(
      imagePath: json['imagePath'],
      name: json['name'],
      price: json['price'],
    );
  }

}

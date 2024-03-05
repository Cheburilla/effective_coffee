import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

class CategoryModel {
  final String categoryName;
  final List<ProductInfoModel> products;

  CategoryModel({
    required this.categoryName,
    required this.products,
  });

  factory CategoryModel.fromJSON(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      products: json['products'],
    );
  }
}

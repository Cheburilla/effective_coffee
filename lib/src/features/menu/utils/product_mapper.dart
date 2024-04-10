import 'package:effective_coffee/src/features/menu/models/DTOs/product_dto.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:effective_coffee/src/features/menu/utils/category_mapper.dart';

extension ProductMapper on ProductDTO {
  ProductModel toModel() => ProductModel(
        id: id,
        name: name,
        price: price,
        imagePath: imageUrl,
        description: description,
        category: category.toModel(),
      );
}

import 'package:effective_coffee/src/features/menu/models/DTOs/category_dto.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';

extension CategorytMapper on CategoryDTO {
  CategoryModel toModel() => CategoryModel(
        id: id,
        categoryName: slug,
      );
}

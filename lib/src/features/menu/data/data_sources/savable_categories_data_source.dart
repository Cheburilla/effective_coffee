import 'package:drift/drift.dart';
import 'package:effective_coffee/src/common/database/database.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/category_dto.dart';

abstract interface class ISavableCategoriesDataSource
    implements ICategoriesDataSource {
  Future<void> saveCategories({required List<CategoryDTO> categories});
}

final class DbCategoriesDataSource implements ISavableCategoriesDataSource {
  final AppDatabase _db;

  const DbCategoriesDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<CategoryDTO>> fetchCategories() async {
    final result = await (_db.select(_db.categories)).get();
    return List<CategoryDTO>.of(
      result.map((e) => CategoryDTO(id: e.id, slug: e.slug)),
    );
  }

  @override
  Future<void> saveCategories({required List<CategoryDTO> categories}) async {
    for (var category in categories) {
      _db.into(_db.categories).insertOnConflictUpdate(
            CategoriesCompanion.insert(
              id: Value(category.id),
              slug: category.slug,
            ),
          );
    }
  }
}

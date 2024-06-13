import 'package:drift/drift.dart';
import 'package:effective_coffee/src/common/database/database.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/product_dto.dart';

abstract interface class ISavableProductsDataSource
    implements IProductsDataSource {
  Future<void> saveProducts({required List<ProductDTO> products});
}

final class DbProductsDataSource implements ISavableProductsDataSource {
  final AppDatabase _db;

  const DbProductsDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<ProductDTO>> fetchProducts({
    required int categoryId,
    int page = 0,
    int limit = 25,
  }) async {
    List<ProductDTO> data = [];
    int offset = limit * page;
    final products = await (_db.select(_db.products)
          ..where((u) => u.categoryId.equals(categoryId))
          ..limit(limit, offset: offset))
        .get();
    for (var product in products) {
      final category = await (_db.select(_db.categories)
            ..where((u) => u.id.equals(product.categoryId)))
          .getSingle();
      data.add(
        ProductDTO.fromDB(
          product,
          category,
        ),
      );
    }
    return data;
  }

  @override
  Future<void> saveProducts({required List<ProductDTO> products}) async {
    for (ProductDTO product in products) {
      _db.into(_db.products).insertOnConflictUpdate(
            ProductsCompanion.insert(
              id: Value(product.id),
              name: product.name,
              description: product.description,
              imageUrl: product.imageUrl,
              price: product.price,
              categoryId: product.category.id,
            ),
          );
    }
  }

  @override
  Future<ProductDTO> fetchProduct({required int productId}) async {
    final product = await (_db.select(_db.products)
          ..where((u) => u.id.equals(productId)))
        .getSingle();
    final category = await (_db.select(_db.categories)
          ..where((e) => e.id.equals(product.categoryId)))
        .getSingle();
    return ProductDTO.fromDB(
      product,
      category,
    );
  }
}

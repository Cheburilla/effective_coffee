import 'dart:io';

import 'package:effective_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:effective_coffee/src/features/menu/data/data_sources/savable_products_data_source.dart';
import 'package:effective_coffee/src/features/menu/models/DTOs/product_dto.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:effective_coffee/src/features/menu/utils/product_mapper.dart';

abstract interface class IProductsRepository {
  Future<List<ProductModel>> loadProducts(
      {required CategoryModel category, int page = 0, int limit = 25});
}

final class ProductsRepository implements IProductsRepository {
  final IProductsDataSource _networkProductsDataSource;
  final ISavableProductsDataSource _dbProductsDataSource;

  const ProductsRepository({
    required IProductsDataSource networkProductsDataSource,
    required ISavableProductsDataSource dbProductsDataSource,
  })  : _networkProductsDataSource = networkProductsDataSource,
        _dbProductsDataSource = dbProductsDataSource;

  @override
  Future<List<ProductModel>> loadProducts(
      {required CategoryModel category, int page = 0, int limit = 25}) async {
    var dtos = <ProductDTO>[];
    try {
      dtos = await _networkProductsDataSource.fetchProducts(
          categoryId: category.id, page: page, limit: limit);
      _dbProductsDataSource.saveProducts(products: dtos);
    } on SocketException {
      dtos = await _dbProductsDataSource.fetchProducts(
          categoryId: category.id, page: page, limit: limit);
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}

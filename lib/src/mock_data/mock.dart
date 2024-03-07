import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

var categories = [
  CategoryModel(
    categoryName: 'Кофе',
    products: [
      const ProductInfoModel(name: 'Олеато', price: 139),
      const ProductInfoModel(name: 'Капучино', price: 129),
      const ProductInfoModel(name: 'Эспрессо', price: 119),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    products: [
      const ProductInfoModel(name: 'Липтон', price: 139),
      const ProductInfoModel(name: 'Гринфилд', price: 89),
    ],
  ),
  CategoryModel(
    categoryName: 'Холодный кофе',
    products: [
      const ProductInfoModel(name: 'Айс латте', price: 159),
      const ProductInfoModel(name: 'Айсмэн', price: 169),
    ],
  ),
  CategoryModel(
    categoryName: 'Рафы',
    products: [
      const ProductInfoModel(name: 'Авторский', price: 209),
      const ProductInfoModel(name: 'Classic', price: 219),
      const ProductInfoModel(name: 'Медовый', price: 229),
    ],
  ),
];

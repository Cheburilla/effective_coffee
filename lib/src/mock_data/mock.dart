import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Кофе',
    products: [
      ProductInfoModel(name: 'Олеато', price: 139),
      ProductInfoModel(name: 'Капучино', price: 129),
      ProductInfoModel(name: 'Эспрессо', price: 119),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    products: [
      ProductInfoModel(name: 'Липтон', price: 139),
      ProductInfoModel(name: 'Гринфилд', price: 89),
    ],
  ),
  CategoryModel(
    categoryName: 'Холодный кофе',
    products: [
      ProductInfoModel(name: 'Айс латте', price: 159),
      ProductInfoModel(name: 'Айсмэн', price: 169),
    ],
  ),
  CategoryModel(
    categoryName: 'Рафы',
    products: [
      ProductInfoModel(name: 'Авторский', price: 209),
      ProductInfoModel(name: 'Classic', price: 219),
      ProductInfoModel(name: 'Медовый', price: 229),
    ],
  ),
];

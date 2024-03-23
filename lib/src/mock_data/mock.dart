import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Кофе',
    products: [
      ProductInfoModel(id: 1, name: 'Олеато', price: 139),
      ProductInfoModel(id: 2, name: 'Капучино', price: 129),
      ProductInfoModel(id: 3, name: 'Эспрессо', price: 119),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    products: [
      ProductInfoModel(id: 4, name: 'Липтон', price: 139),
      ProductInfoModel(id: 5, name: 'Гринфилд', price: 89),
    ],
  ),
  CategoryModel(
    categoryName: 'Холодный кофе',
    products: [
      ProductInfoModel(id: 6, name: 'Айс латте', price: 159),
      ProductInfoModel(id: 7, name: 'Айсмэн', price: 169),
    ],
  ),
  CategoryModel(
    categoryName: 'Рафы',
    products: [
      ProductInfoModel(id: 8, name: 'Авторский', price: 209),
      ProductInfoModel(id: 9, name: 'Classic', price: 219),
      ProductInfoModel(id: 10, name: 'Медовый', price: 229),
    ],
  ),
];

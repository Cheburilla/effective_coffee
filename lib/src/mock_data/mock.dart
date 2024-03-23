import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Кофе',
    products: [
      ProductInfoModel(id: 800, name: 'Олеато', price: 139, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 801, name: 'Капучино', price: 129, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 802, name: 'Эспрессо', price: 119, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    products: [
      ProductInfoModel(id: 4, name: 'Липтон', price: 139, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 5, name: 'Гринфилд', price: 89, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
    ],
  ),
  CategoryModel(
    categoryName: 'Холодный кофе',
    products: [
      ProductInfoModel(id: 6, name: 'Айс латте', price: 159, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 7, name: 'Айсмэн', price: 169, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
    ],
  ),
  CategoryModel(
    categoryName: 'Рафы',
    products: [
      ProductInfoModel(id: 8, name: 'Авторский', price: 209, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 9, name: 'Classic', price: 219, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
      ProductInfoModel(id: 10, name: 'Медовый', price: 229, imagePath: "https://storage.yandexcloud.net/coffee-shop/ca6ecf6c-f1e3-4c3e-bb15-f75d2f067231.jpg"),
    ],
  ),
];

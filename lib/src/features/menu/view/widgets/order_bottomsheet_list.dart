import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class OrderBottomSheetList extends StatelessWidget {
  const OrderBottomSheetList({super.key, required this.products});

  final Map<ProductInfoModel, int> products;

  @override
  Widget build(BuildContext context) {
    final List<ProductInfoModel> orderList = [];
    for (var element in products.entries) {
      for (var i = 0; i < element.value; i++) {
        orderList.add(element.key);
      }
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return OrderTile(
          product: orderList[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: orderList.length,
    );
  }
}

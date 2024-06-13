import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class OrderBottomSheetList extends StatefulWidget {
  const OrderBottomSheetList({super.key, required this.products});

  final Map<ProductModel, int> products;

  @override
  State<OrderBottomSheetList> createState() => _OrderBottomSheetListState();
}

class _OrderBottomSheetListState extends State<OrderBottomSheetList> {
  final List<ProductModel> orderList = [];
  @override
  void initState() {
    super.initState();
    for (MapEntry<ProductModel, int> element in widget.products.entries) {
      for (int i = 0; i < element.value; i++) {
        orderList.add(element.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

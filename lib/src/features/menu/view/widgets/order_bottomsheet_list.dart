import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class OrderBottomSheetList extends StatefulWidget {
  const OrderBottomSheetList({super.key, required this.products});

  final Map<ProductInfoModel, int> products;

  @override
  State<OrderBottomSheetList> createState() => _OrderBottomSheetListState();
}

class _OrderBottomSheetListState extends State<OrderBottomSheetList> {
  final List<ProductInfoModel> orderList = [];
  @override
  void initState() {
    super.initState();
    for (var element in widget.products.entries) {
      for (var i = 0; i < element.value; i++) {
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

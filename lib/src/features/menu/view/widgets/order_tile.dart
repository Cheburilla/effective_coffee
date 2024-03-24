import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.product});
  final ProductInfoModel product;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: product.imagePath,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.contain,
        width: 55,
      ),
      title: Text(
        product.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Text(
        "${product.price.floor()} р.",
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

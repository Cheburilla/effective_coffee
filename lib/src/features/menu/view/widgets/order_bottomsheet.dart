import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.91,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourOrder,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(const DeleteOrder());
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      BlocProvider.of<CartBloc>(context).state.cartItems.length,
                  itemBuilder: (context, index) {
                    List<ProductInfoModel> products = productMapper(
                        BlocProvider.of<CartBloc>(context).state.cartItems);
                    return OrderTile(product: products[index]);
                  }),
            ),
            BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state.status == CartStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(AppLocalizations.of(context)!.orderSuccess),
                    ),
                  );
                  BlocProvider.of<CartBloc>(context).add(const DeleteOrder());
                  Navigator.of(context).pop();
                }
                if (state.status == CartStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(AppLocalizations.of(context)!.orderFailure),
                    ),
                  );
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CartBloc>(context).add(const PostOrder());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 56),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Оформить заказ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.product});
  final ProductInfoModel product;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CachedNetworkImage(
          imageUrl: product.imagePath,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.contain,
          width: 55,
        ),
        title: Text(product.name),
        trailing: Text("${product.price} р."));
  }
}

List<ProductInfoModel> productMapper<ProductInfoModel>(
    Map<ProductInfoModel, int> products) {
  var tempMap = Map.from(products);
  List<ProductInfoModel> result = [];
  tempMap.forEach((key, value) {
    result.addAll(List.filled(value, key, growable: true));
  });
  print(result.length);
  return result;
}

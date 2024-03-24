import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductInfoModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: product.imagePath,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 24,
                  child: BlocProvider.of<CartBloc>(context, listen: true)
                          .state
                          .cartItems
                          .containsKey(product)
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.lightblue),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(CartProductRemoved(product));
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 9,
                                  ),
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: MediaQuery.sizeOf(context).width > 450
                                    ? const EdgeInsets.symmetric(horizontal: 8)
                                    : const EdgeInsets.symmetric(horizontal: 2),
                                child: SizedBox(
                                  height: 24,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color: AppColors.lightblue,
                                    ),
                                    child: Center(
                                      child: BlocBuilder<CartBloc, CartState>(
                                          builder: (context, state) {
                                        return Text(
                                          '${state.cartItems[product]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.lightblue),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(CartProductAdded(product));
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 9,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : FilledButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(CartProductAdded(product));
                          },
                          child: Text(
                            '${product.price} р.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

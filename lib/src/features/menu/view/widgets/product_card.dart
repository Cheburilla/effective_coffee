import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool get showQuantityButtons => _quantity > 0;

  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.idle &&
            !state.cartItems.containsKey(widget.product) &&
            _quantity > 0) {
          _quantity = 0;
        }
      },
      builder: (context, state) {
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
                        imageUrl: widget.product.imagePath,
                        placeholder: (context, url) => const Center(
                          child: SizedBox.shrink(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SizedBox(
                      height: 24,
                      child: showQuantityButtons
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 24,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: AppColors.lightblue,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_quantity > 0) {
                                            _quantity--;
                                            context.read<CartBloc>().add(
                                                  CartProductChanged(
                                                    widget.product,
                                                    _quantity,
                                                  ),
                                                );
                                          }
                                        });
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
                                    padding:
                                        MediaQuery.sizeOf(context).width > 450
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              )
                                            : const EdgeInsets.symmetric(
                                                horizontal: 2,
                                              ),
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
                                          child:
                                              BlocListener<CartBloc, CartState>(
                                            listenWhen: (previous, current) =>
                                                current.status ==
                                                CartStatus.success,
                                            listener: (context, state) {
                                              _quantity = 0;
                                            },
                                            child: Text(
                                              '$_quantity',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
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
                                      color: AppColors.lightblue,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_quantity < 10) {
                                            _quantity++;
                                            context.read<CartBloc>().add(
                                                  CartProductChanged(
                                                    widget.product,
                                                    _quantity,
                                                  ),
                                                );
                                          }
                                        });
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
                                setState(() {
                                  _quantity = 1;
                                });
                                context
                                    .read<CartBloc>()
                                    .add(CartProductChanged(widget.product, 1));
                              },
                              child: Text(
                                '${widget.product.price.floor()} р.',
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
      },
    );
  }
}

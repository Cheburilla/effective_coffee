import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:effective_coffee/src/theme/image_sources.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductInfoModel product;

  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool showQuantityButtons() {
    if (_quantity > 0) return true;
    return false;
  }

  int _quantity = 0;
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
                child: widget.product.imagePath != null
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100),
                        child: Image.network(widget.product.imagePath!),
                      )
                    : ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100),
                        child: Image.asset(ImageSources.placeholder),
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
                  child: showQuantityButtons()
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              child: IconButton.filled(
                                onPressed: () {
                                  setState(() {
                                    _quantity--;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 9,
                                ),
                                color: AppColors.lightblue,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 52),
                                child: FilledButton(
                                  onPressed: () {},
                                  child: Text(
                                    '$_quantity',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              child: IconButton.filled(
                                onPressed: () {
                                  setState(() {
                                    if (_quantity < 10) {
                                      _quantity++;
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 9,
                                  color: AppColors.lightblue,
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
                          },
                          child: Text(
                            '${widget.product.price} р.',
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

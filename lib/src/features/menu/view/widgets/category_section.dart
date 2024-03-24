import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final CategoryModel category;
  const CategorySection({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            category.categoryName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: 196,
          ),
          itemCount: category.products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: category.products[index]);
          },
        ),
      ],
    );
  }
}

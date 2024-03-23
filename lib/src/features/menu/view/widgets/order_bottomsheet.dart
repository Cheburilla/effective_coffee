import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount:
                  BlocProvider.of<CartBloc>(context).state.cartItems.length,
              itemBuilder: (context, index) => ProductCard(
                product: (BlocProvider.of<CartBloc>(context)
                    .state
                    .cartItems
                    .keys
                    .toList())[index],
              ),
            ),
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
    );
  }
}

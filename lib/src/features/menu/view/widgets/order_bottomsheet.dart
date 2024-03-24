import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_bottomsheet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({super.key, required this.scaffoldKey});

  final GlobalKey scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.91,
        child: Scaffold(
          body: Padding(
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
                        BlocProvider.of<CartBloc>(context)
                            .add(const DeleteOrder());
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: OrderBottomSheetList(
                    products:
                        BlocProvider.of<CartBloc>(context).state.cartItems,
                  ),
                ),
                BlocListener<CartBloc, CartState>(
                  listener: (context, state) {
                    if (state.status == CartStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content:
                              Text(AppLocalizations.of(context)!.orderSuccess),
                        ),
                      );
                      BlocProvider.of<CartBloc>(context)
                          .add(const DeleteOrder());
                      Navigator.of(context).pop();
                    }
                    if (state.status == CartStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content:
                              Text(AppLocalizations.of(context)!.orderFailure),
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
                      AppLocalizations.of(context)!.makeOrder,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

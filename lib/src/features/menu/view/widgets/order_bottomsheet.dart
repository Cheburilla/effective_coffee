import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_bottomsheet_list.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.91,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: Scaffold(
            body: ColoredBox(
              color: AppColors.white,
              child: Column(
                children: [
                  SizedBox(
                    width: Theme.of(context)
                        .bottomSheetTheme
                        .dragHandleSize
                        ?.width,
                    height: Theme.of(context)
                        .bottomSheetTheme
                        .dragHandleSize
                        ?.height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).bottomSheetTheme.dragHandleColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.yourOrder,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                const CartOrderDeleted(),
                              );
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: OrderBottomSheetList(
                      products: context.read<CartBloc>().state.cartItems,
                    ),
                  ),
                  BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state.status == CartStatus.success) {
                        context.read<CartBloc>().add(
                              const CartOrderDeleted(),
                            );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              AppLocalizations.of(context)!.orderSuccess,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        );
                      }
                      if (state.status == CartStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              AppLocalizations.of(context)!.orderFailure,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(const CartOrderPosted());
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 56),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.makeOrder,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

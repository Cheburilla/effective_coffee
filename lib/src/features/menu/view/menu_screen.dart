import 'package:effective_coffee/src/features/locations/view/widgets/location_button.dart';
import 'package:effective_coffee/src/features/menu/bloc/cart/cart_bloc.dart';
import 'package:effective_coffee/src/features/menu/bloc/menu/menu_bloc.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/category_section.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/order_bottomsheet.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String selectedCategoryName;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  late ItemPositionsListener itemListener;
  int current = 0;
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    itemListener = ItemPositionsListener.create();
    itemListener.itemPositions.addListener(() {
      if (itemListener.itemPositions.value.isNotEmpty &&
          inProgress != true &&
          current != itemListener.itemPositions.value.first.index) {
        setCurrent(itemListener.itemPositions.value.first.index);
        appBarScrollToCategory(itemListener.itemPositions.value.first.index);
      }
      bool needToPaginate =
          itemListener.itemPositions.value.last.itemTrailingEdge <= 3 &&
              inProgress != true &&
              context
                  .read<MenuBloc>()
                  .state
                  .items
                  .where((e) => e.category.id == current + 2)
                  .toList()
                  .isEmpty;
      if (needToPaginate) {
        context.read<MenuBloc>().add(const PageLoadingStarted());
      }
    });
  }

  void setCurrent(int newCurrent) {
    setState(() {
      current = newCurrent;
    });
  }

  void menuScrollToCategory(int ind) async {
    inProgress = true;
    _menuController.scrollTo(
      index: ind,
      duration: const Duration(milliseconds: 1000),
    );
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
      curve: Curves.easeOut,
      opacityAnimationWeights: [20, 20, 60],
      index: ind,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      buildWhen: (context, state) {
        return state.status == MenuStatus.idle;
      },
      builder: (context, state) {
        if (state.status != MenuStatus.error) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight((94)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                        child: LocationButton(),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 36,
                        child: ScrollablePositionedList.builder(
                          itemScrollController: _appBarController,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<MenuBloc>().add(
                                      OneCategoryLoadingStarted(
                                          state.categories[index]));
                                  setCurrent(index);
                                  menuScrollToCategory(index);
                                  appBarScrollToCategory(index);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: index == current
                                        ? AppColors.lightblue
                                        : AppColors.white),
                                child: Text(
                                  state.categories[index].slug,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: index == current
                                              ? AppColors.white
                                              : AppColors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 20),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _menuController,
                  itemPositionsListener: itemListener,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    final products = state.items
                        .where((e) => e.category.id == category.id)
                        .toList();
                    return CategorySection(
                      category: category,
                      products: products,
                    );
                  },
                  itemCount: state.categories.length,
                ),
              ),
              floatingActionButton: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.cartItems.isNotEmpty) {
                    return FloatingActionButton.extended(
                      backgroundColor: AppColors.lightblue,
                      onPressed: () => {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: AppColors.white,
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<CartBloc>(context),
                            child: const OrderBottomSheet(),
                          ),
                        ),
                      },
                      icon: const Icon(
                        Icons.local_mall,
                        color: AppColors.white,
                      ),
                      label: Text(
                        '${state.cost.floor()} ₽',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

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
    context.read<MenuBloc>().add(const PageLoadingStarted());
    itemListener = ItemPositionsListener.create();
    itemListener.itemPositions.addListener(() {
      final fullVisibles = itemListener.itemPositions.value.where(
        (item) => item.itemLeadingEdge >= 0,
      );
      if (fullVisibles.isNotEmpty) {
        final fullVisible = itemListener.itemPositions.value
            .firstWhere(
              (item) => item.itemLeadingEdge >= 0,
            )
            .index;
        if ((fullVisible != current) && inProgress != true) {
          setCurrent(fullVisible - 1 > -1 ? fullVisible - 1 : 0);
          appBarScrollToCategory(fullVisible - 1 > -1 ? fullVisible - 1 : 0);
        }
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
      duration: const Duration(milliseconds: 200),
    );
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
      curve: Curves.easeOut,
      opacityAnimationWeights: [20, 20, 60],
      index: ind,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(
              (40),
            ),
            child: SizedBox(
              height: 40,
              child: BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  if (state.status != MenuStatus.error &&
                      state.categories != null) {
                    return ScrollablePositionedList.builder(
                      itemScrollController: _appBarController,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          context.read<MenuBloc>().state.categories!.length,
                      itemBuilder: (context, index) {
                        final category =
                            context.read<MenuBloc>().state.categories![index];
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () {
                              setCurrent(index);
                              menuScrollToCategory(index);
                              appBarScrollToCategory(index);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: index == current
                                    ? AppColors.lightblue
                                    : AppColors.white),
                            child: Text(
                              category.categoryName,
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
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state.status != MenuStatus.error &&
                      state.categories != null &&
                      state.items != null
                  //&& state.items!.isNotEmpty
                  ) {
                return ScrollablePositionedList.builder(
                  itemScrollController: _menuController,
                  itemPositionsListener: itemListener,
                  itemBuilder: (context, index) {
                    if (index % 25 == 10){
                      context.read<MenuBloc>().add(const PageLoadingStarted());
                    }
                    final category =
                        context.read<MenuBloc>().state.categories![index];
                    final products = context
                        .read<MenuBloc>()
                        .state
                        .items!
                        .where((e) => e.category.id == category.id)
                        .toList();
                    return CategorySection(
                      category: category,
                      products: products,
                    );
                  },
                  itemCount: context.read<MenuBloc>().state.categories!.length,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        floatingActionButton: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.status != CartStatus.initial) {
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
                  BlocProvider.of<CartBloc>(context)
                      .state
                      .cost
                      .toStringAsFixed(2),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

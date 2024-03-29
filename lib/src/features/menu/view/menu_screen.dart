import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/category_section.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const MenuScreen({super.key, required this.categories});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> categoryKeys;
  late String selectedCategoryName;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  late ItemPositionsListener itemListener;
  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    itemListener = ItemPositionsListener.create();

    categoryKeys = {
      for (var category in widget.categories) category.categoryName: GlobalKey()
    };

    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value.firstWhere((item) {
        return item.itemLeadingEdge >= 0;
      }).index;

      if (((fullVisible != current) && inProgress != true) &&
          scrolledToBottom == false) {
        setCurrent(fullVisible);
        appBarScrollToCategory(fullVisible);
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
        index: ind, duration: const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 200));
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
        curve: Curves.easeOut,
        opacityAnimationWeights: [20, 20, 60],
        index: ind,
        duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: PreferredSize(
            preferredSize: const Size.fromHeight((40)),
            child: SizedBox(
              height: 40,
              child: ScrollablePositionedList.builder(
                itemScrollController: _appBarController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: index == current
                                ? AppColors.white
                                : AppColors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollablePositionedList.builder(
            itemScrollController: _menuController,
            itemPositionsListener: itemListener,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return CategorySection(
                key: categoryKeys[category.categoryName],
                category: category,
              );
            },
            itemCount: widget.categories.length,
          ),
        ),
      ),
    );
  }
}

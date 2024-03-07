import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/view/widgets/category_section.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const MenuScreen({super.key, required this.categories});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> categoryKeys;
  late String selectedCategoryName;
  late ItemScrollController _menuController;
  late ItemScrollController _appBarController;
  bool inProgress = false;
  late ItemPositionsListener itemListener;

  @override
  void initState() {
    super.initState();
    _menuController = ItemScrollController();
    _appBarController = ItemScrollController();
    itemListener = ItemPositionsListener.create();

    bool scrolledToBottom = false;

    categoryKeys = {
      for (var category in widget.categories) category.categoryName: GlobalKey()
    };

    selectedCategoryName = widget.categories.first.categoryName;
    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value
          .where((item) {
            final isTopVisible = item.itemLeadingEdge >= 0;
            final isBottomVisible = item.itemTrailingEdge < 1.02;
            return isTopVisible && isBottomVisible;
          })
          .map((item) => item.index)
          .toList();

      if (fullVisible.length == 2) {
        if ((fullVisible[1] == widget.categories.length - 1) &&
            inProgress != true) {
          if (fullVisible[1] != current) {
            scrolledToBottom = true;
            setCurrent(fullVisible[1]);
            appBarScrollToCategory(fullVisible[1]);
          }
        } else {
          scrolledToBottom = false;
        }
      } else {
        scrolledToBottom = false;
      }

      if (((fullVisible[0] != current) && inProgress != true) &&
          scrolledToBottom == false) {
        setCurrent(fullVisible[0]);
        appBarScrollToCategory(fullVisible[0]);
      }
    });
  }

  int current = 0;
  void setCurrent(int newCurrent) {
    setState(() {
      current = newCurrent;
    });
  }

  menuScrollToCategory(int ind) async {
    inProgress = true;
    _menuController.scrollTo(
        index: ind, duration: const Duration(milliseconds: 200));
    await Future.delayed(const Duration(milliseconds: 200));
    inProgress = false;
  }

  appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
        index: ind, duration: const Duration(milliseconds: 120));
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
                shrinkWrap: true,
                itemScrollController: _appBarController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategoryName = category.categoryName;
                        });
                        setCurrent(index);
                        menuScrollToCategory(index);
                        appBarScrollToCategory(index);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return selectedCategoryName == category.categoryName
                                ? AppColors.lightblue
                                : AppColors.white;
                          },
                        ),
                      ),
                      child: Text(
                        category.categoryName,
                        style: Theme.of(context).textTheme.bodyMedium,
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
            shrinkWrap: true,
            itemScrollController: _menuController,
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

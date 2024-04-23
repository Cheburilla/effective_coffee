import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:effective_coffee/src/features/menu/data/category_repository.dart';
import 'package:effective_coffee/src/features/menu/data/products_repository.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'menu_event.dart';
part 'menu_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this._productsRepository, this._categoriesRepository)
      : super(
          const MenuState(status: MenuStatus.idle, items: [], categories: []),
        ) {
    on<CategoryLoadingStarted>(_loadCategories);
    on<PageLoadingStarted>(
      _loadProducts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<OneCategoryLoadingStarted>(_loadProductsFromOneCategory);
  }

  final IProductsRepository _productsRepository;
  final ICategoriesRepository _categoriesRepository;

  CategoryModel? _currentPaginatedCategory;

  int _currentPage = 0;

  final int _pageLimit = 25;

  Future<void> _loadCategories(event, emit) async {
    emit(
      state.copyWith(items: state.items, status: MenuStatus.progress),
    );
    try {
      final categories = await _categoriesRepository.loadCategories();
      emit(
        state.copyWith(
          categories: categories,
          items: List.empty(),
          status: MenuStatus.success,
        ),
      );
      add(
        const PageLoadingStarted(),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  Future<void> _loadProductsFromOneCategory(event, emit) async {
    CategoryModel? currentCategory = event.category;
    if (currentCategory == null) return;
    emit(
      state.copyWith(items: state.items, status: MenuStatus.progress),
    );
    final List<ProductModel> previousItems =
        List<ProductModel>.from(state.items);
    try {
      final items = await _productsRepository.loadProducts(
        category: currentCategory,
        limit: _pageLimit,
      );
      previousItems.addAll(items);
      emit(
        state.copyWith(
          categories: state.categories,
          items: previousItems,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          items: previousItems,
          status: MenuStatus.idle,
        ),
      );
    }
  }

  Future<void> _loadProducts(event, emit) async {
    List<CategoryModel>? categories = state.categories;
    if (categories.isEmpty) return;
    CategoryModel? currentCategory = _currentPaginatedCategory;
    currentCategory ??= categories.first;
    emit(
      state.copyWith(items: state.items, status: MenuStatus.progress),
    );
    try {
      final List<ProductModel> previousItems =
          List<ProductModel>.from(state.items);
      final items = await _productsRepository.loadProducts(
        category: currentCategory,
        page: _currentPage,
        limit: _pageLimit,
      );
      _currentPage += 1;
      if (items.length < _pageLimit) {
        if (currentCategory != categories.last) {
          int nextPaginatedCategoryIndex =
              categories.indexOf(currentCategory) + 1;
          currentCategory = categories[nextPaginatedCategoryIndex];
          _currentPage = 0;
        }
      }
      _currentPaginatedCategory = currentCategory;
      previousItems.addAll(items);
      emit(
        state.copyWith(
          categories: state.categories,
          items: previousItems,
          status: MenuStatus.success,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle,
        ),
      );
    }
  }
}

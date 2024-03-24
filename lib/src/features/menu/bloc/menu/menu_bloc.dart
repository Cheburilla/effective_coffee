import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:effective_coffee/src/features/menu/data/menu_repository.dart';
import 'package:effective_coffee/src/features/menu/models/category_model.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this._repository) : super(const MenuState(status: MenuStatus.idle)) {
    on<CategoryLoadingStarted>(_loadCategories);
    on<PageLoadingStarted>(_loadProducts);
  }

  final MenuRepository _repository;

  CategoryModel? _currentPaginatedCategory;
  final int _currentPage = 0;

  final int _pageLimit = 25;

  Future<void> _loadCategories(event, emit) async {
    emit(MenuState(items: state.items, status: MenuStatus.progress));
    try {
      final categories = await _repository.getCategories();
      emit(MenuState(
          categories: categories,
          items: List.empty(),
          status: MenuStatus.success));
    } on Object {
      emit(MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error));
      rethrow;
    } finally {
      emit(MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle));
    }
  }

  Future<void> _loadProducts(event, emit) async {
    _currentPaginatedCategory ??= state.categories?.first;
    if (_currentPaginatedCategory == null) return;

    emit(MenuState(items: state.items, status: MenuStatus.progress));
    try {
      final items = await _repository.getProducts(
          category: _currentPaginatedCategory!,
          page: _currentPage,
          limit: _pageLimit);
      if (items.length < _pageLimit) {
        // Обновить счетчик страниц и выбрать следующую категорию
      }
      emit(MenuState(
          categories: state.categories,
          items: items,
          status: MenuStatus.success));
    } on Object {
      emit(MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.error));
      rethrow;
    } finally {
      emit(MenuState(
          categories: state.categories,
          items: state.items,
          status: MenuStatus.idle));
    }
  }
}

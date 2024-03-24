import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:effective_coffee/src/features/menu/data/menu_repository.dart';
import 'package:effective_coffee/src/features/menu/models/product_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._repository)
      : super(const CartState(cartItems: <ProductInfoModel, int>{})) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<PostOrder>(_onPostOrder);
    on<DeleteOrder>(_onDeleteOrder);
  }

  final MenuRepository _repository;

  Future<void> _onAddProduct(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(state.cartItems);
    final count = items[event.product] ?? 0;
    if (count < 10) {
      items[event.product] = count + 1;
    }
    emit(
      state.copyWith(
        status: CartStatus.filled,
        cartItems: items,
        cost: _costsCounter(items),
      ),
    );
  }

  Future<void> _onRemoveProduct(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(state.cartItems);
    ProductInfoModel newItem = event.product;
    if (items[newItem]! == 1) {
      items.remove(newItem);
    } else {
      items[newItem] = (items[newItem]! - 1);
    }
    if (items.isEmpty) {
      emit(
        state.copyWith(
          status: CartStatus.initial,
          cartItems: <ProductInfoModel, int>{},
          cost: _costsCounter(items),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CartStatus.filled,
          cartItems: items,
          cost: _costsCounter(items),
        ),
      );
    }
  }

  Future<void> _onPostOrder(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(
      state.cartItems,
    );
    try {
      emit(
        state.copyWith(
          status: CartStatus.loading,
        ),
      );
      await _repository.postOrder(items);
      emit(
        state.copyWith(
          status: CartStatus.success,
        ),
      );
      emit(
        state.copyWith(
          status: CartStatus.initial,
          cost: _costsCounter(items),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          cartItems: items,
        ),
      );
      emit(
        state.copyWith(
          status: CartStatus.filled,
          cartItems: items,
          cost: _costsCounter(items),
        ),
      );
      rethrow;
    }
  }

  Future<void> _onDeleteOrder(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(state.cartItems);
    emit(
      state.copyWith(
        status: CartStatus.initial,
        cartItems: <ProductInfoModel, int>{},
        cost: _costsCounter(items),
      ),
    );
  }

  double _costsCounter(Map<ProductInfoModel, int> orderMap) {
    double costs = 0;
    for (var product in orderMap.entries) {
      final productPrice = product.key.price;
      final productCount = product.value;
      costs += productPrice * productCount;
    }
    return costs;
  }
}

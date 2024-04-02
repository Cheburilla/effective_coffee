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
    on<CartProductChanged>(_onCartProductChanged);
    on<CartOrderPosted>(_onCartOrderPosted);
    on<CartOrderDeleted>(_onCartOrderDeleted);
  }

  final MenuRepository _repository;

  Future<void> _onCartProductChanged(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(state.cartItems);
    final count = event.count;
    items[event.product] = count;
    emit(
      state.copyWith(
        status: CartStatus.filled,
        cartItems: items,
        cost: _costsCounter(items),
      ),
    );
  }

  Future<void> _onCartOrderPosted(event, emit) async {
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

  Future<void> _onCartOrderDeleted(event, emit) async {
    Map<ProductInfoModel, int> items = Map.from(state.cartItems);
    emit(
      state.copyWith(
        status: CartStatus.initial,
        cartItems: <ProductInfoModel, int>{},
        cost: _costsCounter(items),
      ),
    );
  }

  double _costsCounter(Map<ProductInfoModel, int> products) {
    double costs = 0;
    for (var product in products.entries) {
      costs += product.key.price * product.value;
    }
    return costs;
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:effective_coffee/src/features/menu/data/order_repository.dart';
import 'package:effective_coffee/src/features/menu/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._orderRepository)
      : super(const CartState(cartItems: <ProductModel, int>{})) {
    on<CartProductChanged>(_onCartProductChanged);
    on<CartOrderPosted>(_onCartOrderPosted);
    on<CartOrderDeleted>(_onCartOrderDeleted);
  }

  final IOrderRepository _orderRepository;

  Future<void> _onCartProductChanged(event, emit) async {
    Map<ProductModel, int> items = Map.from(state.cartItems);
    final count = event.count;
    if (count == 0) {
      items.remove(event.product);
    }
    else {
      items[event.product] = count;
    }
    emit(
      state.copyWith(
        cartItems: items,
        cost: _costsCounter(items),
      ),
    );
  }

  Future<void> _onCartOrderPosted(event, emit) async {
    emit(
      state.copyWith(
        status: CartStatus.loading,
      ),
    );
    Map<ProductModel, int> items = Map.from(
      state.cartItems,
    );
    try {
      await _orderRepository.postOrder(items);
      emit(
        state.copyWith(
          status: CartStatus.success,
          cartItems: <ProductModel, int>{},
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
        ),
      );
      rethrow;
    } finally {
      emit(
        state.copyWith(
          status: CartStatus.idle,
          cost: _costsCounter(state.cartItems),
        ),
      );
    }
  }

  Future<void> _onCartOrderDeleted(event, emit) async {
    emit(
      state.copyWith(
        cartItems: <ProductModel, int>{},
        cost: 0,
      ),
    );
  }

  double _costsCounter(Map<ProductModel, int> products) {
    double costs = 0;
    for (var product in products.entries) {
      costs += product.key.price * product.value;
    }
    return costs;
  }
}

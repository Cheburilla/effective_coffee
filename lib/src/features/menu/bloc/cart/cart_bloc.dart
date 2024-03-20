import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cartItems: <int, int>{})) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  final Map<int, int> _cartItems = {};
  Map<int, int> get items => _cartItems;

  Future<void> _onAddProduct(event, emit) async {
    var items = state.cartItems;
    var newItem = event.productId;
    if (items.containsKey(newItem) && items[newItem] != null) {
      items[newItem] = (items[newItem] as int) + 1;
    } else {
      items.addAll({newItem: 1});
    }
    emit(state.copyWith(status: CartStatus.filled, cartItems: items));
  }

  Future<void> _onRemoveProduct(event, emit) async {
    var items = state.cartItems;
    var newItem = event.productId;
    if (items.containsKey(newItem) && items[newItem] != null) {
      if (items[newItem]! > 1) {
        items[newItem] = (items[newItem] as int) - 1;
      }
    } else if (items[newItem]! == 1) {
      items.remove(newItem);
    }
    if (items.isEmpty) {
      emit(state.copyWith(status: CartStatus.empty, cartItems: items));
    } else {
      emit(state.copyWith(status: CartStatus.filled, cartItems: items));
    }
  }
}

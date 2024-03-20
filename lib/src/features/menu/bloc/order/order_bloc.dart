import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<PostOrder>(_onPostOrder);
  }

  final Map<int, int> _cartItems = {};
  Map<int, int> get items => _cartItems;

  Future<void> _onPostOrder(event, emit) async {
    var newItem = event.productId;
    if (items.containsKey(newItem) && items[newItem] != null) {
      items[newItem] = (items[newItem] as int) + 1;
    } else {
      items.addAll({newItem: 1});
    }
    emit(state.copyWith(status: OrderStatus.loading));
  }
}

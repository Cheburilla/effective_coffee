part of 'cart_bloc.dart';

enum CartStatus {
  idle,
  loading,
  success,
  failure,
}

final class CartState extends Equatable {
  final Map<ProductInfoModel, int> cartItems;
  final CartStatus status;
  final double cost;

  const CartState({
    this.status = CartStatus.idle,
    required this.cartItems,
    this.cost = 0,
  });

  CartState copyWith({
    CartStatus? status,
    Map<ProductInfoModel, int>? cartItems,
    double? cost,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      cost: cost ?? this.cost,
    );
  }

  @override
  String toString() {
    return '''CartStatus { status: $status, cartItems: ${cartItems.length}, fullCosts: $cost }''';
  }

  @override
  List<Object> get props => [
        status,
        cartItems,
        cost,
      ];
}

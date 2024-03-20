part of 'cart_bloc.dart';

enum CartStatus {empty, filled}

final class CartState extends Equatable{
  final Map<int, int> cartItems;
  final CartStatus status;

  const CartState({
    this.status = CartStatus.empty,
    required this.cartItems,
  });

  CartState copyWith({
    CartStatus? status,
    Map<int, int>? cartItems,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  String toString() {
    return '''CartStatus { status: $status, cartItems: ${cartItems.length} }''';
  }

  @override
  List<Object> get props => [status, cartItems];
}

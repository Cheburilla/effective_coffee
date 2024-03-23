part of 'cart_bloc.dart';

enum CartStatus { initial, filled, loading, success, failure }

final class CartState extends Equatable{
  final Map<ProductInfoModel, int> cartItems;
  final CartStatus status;

  const CartState({
    this.status = CartStatus.initial,
    required this.cartItems,
  });

  CartState copyWith({
    CartStatus? status,
    Map<ProductInfoModel, int>? cartItems,
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

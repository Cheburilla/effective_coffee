part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class AddProduct extends CartEvent {
  final int productId;

  const AddProduct(this.productId);

  @override
  String toString() => 'AddProduct { id: $productId }';
}

class RemoveProduct extends CartEvent {
  final int productId;

  const RemoveProduct(this.productId);

  @override
  String toString() => 'RemoveProduct { id: $productId }';
}

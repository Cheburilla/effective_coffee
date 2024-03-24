part of 'cart_bloc.dart';

@immutable
sealed class CartEvent{
  const CartEvent();
}

class CartProductAdded extends CartEvent {
  final ProductInfoModel product;

  const CartProductAdded(this.product);

  @override
  String toString() => 'CartProductAdded { id: ${product.id} }';

}

class CartProductRemoved extends CartEvent {
  final ProductInfoModel product;

  const CartProductRemoved(this.product);

  @override
  String toString() => 'CartProductRemoved { id: ${product.id} }';

}

class CartOrderPosted extends CartEvent {
  const CartOrderPosted();

  @override
  String toString() => 'CartOrderPosted';

}

class CartOrderDeleted extends CartEvent {
  const CartOrderDeleted();

  @override
  String toString() => 'CartOrderDeleted';

}

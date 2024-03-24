part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
}

class CartProductAdded extends CartEvent {
  final ProductInfoModel product;

  const CartProductAdded(
    this.product,
  );

  @override
  String toString() => 'CartProductAdded { id: ${product.id} }';

  @override
  List<Object> get props => [
        product,
      ];
}

class CartProductRemoved extends CartEvent {
  final ProductInfoModel product;

  const CartProductRemoved(
    this.product,
  );

  @override
  String toString() => 'CartProductRemoved { id: ${product.id} }';

  @override
  List<Object> get props => [
        product,
      ];
}

class CartOrderPosted extends CartEvent {
  const CartOrderPosted();

  @override
  String toString() => 'CartOrderPosted';

  @override
  List<Object> get props => [];
}

class CartOrderDeleted extends CartEvent {
  const CartOrderDeleted();

  @override
  String toString() => 'CartOrderDeleted';

  @override
  List<Object> get props => [];
}

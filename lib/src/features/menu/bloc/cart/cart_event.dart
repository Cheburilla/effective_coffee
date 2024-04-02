part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
}

class CartProductChanged extends CartEvent {
  final ProductInfoModel product;
  final int count;
  const CartProductChanged(
    this.product,
    this.count,
  );

  @override
  String toString() => 'CartProductChanged { id: ${product.id} }';

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

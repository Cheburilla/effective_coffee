part of 'cart_bloc.dart';

@immutable
sealed class CartEvent{
  const CartEvent();
}

class AddProduct extends CartEvent {
  final ProductInfoModel product;

  const AddProduct(this.product);

  @override
  String toString() => 'AddProduct { id: ${product.id} }';

}

class RemoveProduct extends CartEvent {
  final ProductInfoModel product;

  const RemoveProduct(this.product);

  @override
  String toString() => 'RemoveProduct { id: ${product.id} }';

}

class PostOrder extends CartEvent {
  const PostOrder();

  @override
  String toString() => 'PostOrder';

}

class DeleteOrder extends CartEvent {
  const DeleteOrder();

  @override
  String toString() => 'DeleteOrder';

}

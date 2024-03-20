part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {
  const OrderEvent();
}

class PostOrder extends OrderEvent {
  const PostOrder();

  @override
  String toString() => 'PostOrder {}';
}

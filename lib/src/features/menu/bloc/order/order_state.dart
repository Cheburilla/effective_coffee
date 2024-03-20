part of 'order_bloc.dart';

enum OrderStatus { idle, success, failure, loading }

final class OrderState extends Equatable {
  final OrderStatus status;

  const OrderState({
    this.status = OrderStatus.idle,
  });

  OrderState copyWith({
    OrderStatus? status,
  }) {
    return OrderState(
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '''OrderStatus { status: $status }''';
  }

  @override
  List<Object> get props => [status];
}

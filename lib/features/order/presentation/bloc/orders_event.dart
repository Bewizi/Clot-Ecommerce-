part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrdersByUserEvent extends OrdersEvent {
  const FetchOrdersByUserEvent({this.status});

  final String? status;

  @override
  List<Object?> get props => [status];
}

class FetchOrderByIdEvent extends OrdersEvent {
  const FetchOrderByIdEvent({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

class FetchOrderItemsEvent extends OrdersEvent {
  const FetchOrderItemsEvent({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

class PlaceOrderEvent extends OrdersEvent {
  const PlaceOrderEvent({
    required this.shippingAddress,
    this.shippingPhone,
    required this.cartItems,
    required this.total,
  });

  final String shippingAddress;
  final String? shippingPhone;
  final List<CartDomain> cartItems;
  final double total;

  @override
  List<Object?> get props => [shippingAddress, shippingPhone, cartItems, total];
}

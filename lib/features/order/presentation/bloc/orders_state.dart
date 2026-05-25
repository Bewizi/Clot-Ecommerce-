part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  const OrdersLoaded({required this.orders, this.selectedStatus});

  final List<OrdersDomain> orders;
  final String? selectedStatus;

  @override
  List<Object?> get props => [orders, selectedStatus];
}

final class OrderDetailLoaded extends OrdersState {
  const OrderDetailLoaded({required this.order});

  final OrdersDomain order;

  @override
  List<Object?> get props => [order];
}

final class OrderItemsLoaded extends OrdersState {
  const OrderItemsLoaded({required this.order, required this.items});

  final OrdersDomain order;
  final List<OrderItemDomain> items;

  @override
  List<Object?> get props => [order, items];
}

final class OrdersError extends OrdersState {
  const OrdersError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class PlaceOrderSuccess extends OrdersState {
  const PlaceOrderSuccess({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

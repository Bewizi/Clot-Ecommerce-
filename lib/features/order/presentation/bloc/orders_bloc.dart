import 'package:bloc/bloc.dart';
import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/order/domain/order_item_domain.dart';
import 'package:clot/features/order/domain/orders_domain.dart';
import 'package:clot/features/order/domain/orders_repository.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({required this.ordersRepository}) : super(OrdersInitial()) {
    on<FetchOrdersByUserEvent>(_onFetchOrdersByUser);
    on<FetchOrderByIdEvent>(_onFetchOrderById);
    on<FetchOrderItemsEvent>(_onFetchOrderItems);
    on<PlaceOrderEvent>(_onPlaceOrder);
  }

  final OrdersRepository ordersRepository;

  Future<void> _onFetchOrdersByUser(
    FetchOrdersByUserEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final orders = await ordersRepository.fetchOrdersByUser(
        status: event.status,
      );
      emit(OrdersLoaded(orders: orders, selectedStatus: event.status));
    } on Exception catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  Future<void> _onFetchOrderById(
    FetchOrderByIdEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final order = await ordersRepository.fetchOrdersById(id: event.orderId);
      emit(OrderDetailLoaded(order: order));
    } on Exception catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  Future<void> _onFetchOrderItems(
    FetchOrderItemsEvent event,
    Emitter<OrdersState> emit,
  ) async {
    final currentState = state;
    OrdersDomain? currentOrder;

    if (currentState is OrderDetailLoaded) {
      currentOrder = currentState.order;
    }

    emit(OrdersLoading());
    try {
      currentOrder ??= await ordersRepository.fetchOrdersById(
        id: event.orderId,
      );
      final items = await ordersRepository.fetchOrders(orderId: event.orderId);
      emit(OrderItemsLoaded(order: currentOrder, items: items));
    } on Exception catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      final orderId = await ordersRepository.placeOrder(
        shippingAddress: event.shippingAddress,
        shippingPhone: event.shippingPhone,
        cartItems: event.cartItems,
      );
      emit(PlaceOrderSuccess(orderId: orderId));
    } on Exception catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }
}

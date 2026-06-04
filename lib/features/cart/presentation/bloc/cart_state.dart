part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  const CartLoaded({required this.cartItems});

  final List<CartDomain> cartItems;

  double get subtotal =>
      cartItems.fold(0, (sum, i) => sum + (i.price * i.quantity));

  double get shippingCost => cartItems.isEmpty ? 0 : 8.0;

  double get tax => 0;

  double get total => subtotal + shippingCost + tax;

  @override
  List<Object> get props => [cartItems];
}

final class CartError extends CartState {
  const CartError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

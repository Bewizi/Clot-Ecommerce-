part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItem extends CartEvent {
  const LoadCartItem({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

class AddToCart extends CartEvent {
  const AddToCart({
    required this.productId,
    required this.userId,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  final String productId;
  final String userId;
  final String title;
  final double price;
  final String image;
  final int quantity;

  @override
  List<Object> get props => [
    productId,
    userId,
    title,
    price,
    image,
    quantity,
  ];
}

class RemoveFromCart extends CartEvent {
  const RemoveFromCart({required this.cartItemId});

  final String cartItemId;

  @override
  List<Object> get props => [cartItemId];
}

class UpdateQuantity extends CartEvent {
  const UpdateQuantity({
    required this.cartItemId,
    required this.newQuantity,
  });

  final String cartItemId;
  final int newQuantity;

  @override
  List<Object> get props => [cartItemId, newQuantity];
}

class RemoveAllFromCart extends CartEvent {
  const RemoveAllFromCart({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

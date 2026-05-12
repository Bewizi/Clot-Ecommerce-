import 'package:bloc/bloc.dart';
import 'package:clot/features/cart/domain/cart_domain.dart';
import 'package:clot/features/cart/domain/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCartItem>(_onLoadCartItem);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<RemoveAllFromCart>(_onRemoveAllFromCart);
  }

  final CartRepository cartRepository;

  Future<void> _onLoadCartItem(
    LoadCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final cartItems = await cartRepository.getCartItems(userId: event.userId);
      emit(CartLoaded(cartItems: cartItems));
    } on Exception catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = state is CartLoaded
        ? (state as CartLoaded).cartItems
        : <CartDomain>[];
    try {
      final newItem = await cartRepository.addToCart(
        productId: event.productId,
        userId: event.userId,
        title: event.title,
        price: event.price,
        image: event.image,
        quantity: event.quantity,
      );
      emit(CartLoaded(cartItems: [...currentItems, newItem]));
    } on Exception catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = state is CartLoaded
        ? (state as CartLoaded).cartItems
        : <CartDomain>[];

    final updated = currentItems
        .where((i) => i.cartId != event.cartItemId)
        .toList();
    emit(CartLoaded(cartItems: updated));
    try {
      await cartRepository.removeFromCart(cartItemId: event.cartItemId);
    } on Exception catch (e) {
      emit(CartLoaded(cartItems: currentItems));
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = state is CartLoaded
        ? (state as CartLoaded).cartItems
        : <CartDomain>[];
    try {
      final updated = await cartRepository.updateQuantity(
        cartItemId: event.cartItemId,
        newQuantity: event.newQuantity,
      );
      final newList = currentItems
          .map((i) => i.cartId == event.cartItemId ? updated : i)
          .toList();
      emit(CartLoaded(cartItems: newList));
    } on Exception catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onRemoveAllFromCart(
    RemoveAllFromCart event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = state is CartLoaded
        ? (state as CartLoaded).cartItems
        : <CartDomain>[];
    emit(const CartLoaded(cartItems: []));
    try {
      for (final item in currentItems) {
        await cartRepository.removeFromCart(cartItemId: item.cartId);
      }
    } on Exception catch (e) {
      emit(CartLoaded(cartItems: currentItems));
      emit(CartError(message: e.toString()));
    }
  }
}

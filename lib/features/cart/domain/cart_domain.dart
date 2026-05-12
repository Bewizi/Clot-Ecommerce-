import 'package:equatable/equatable.dart';

class CartDomain extends Equatable {
  const CartDomain({
    required this.cartId,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.title,
    required this.price,
    required this.image,
  });

  factory CartDomain.fromJson(Map<String, dynamic> json) {
    return CartDomain(
      cartId: json['id'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] as String? ?? '',
    );
  }

  CartDomain copyWith({
    String? cartId,
    String? productId,
    String? userId,
    int? quantity,
    String? title,
    double? price,
    String? image,
  }) {
    return CartDomain(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': cartId,
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  final String cartId;
  final String productId;
  final String userId;
  final int quantity;
  final String title;
  final double price;
  final String image;

  @override
  List<Object?> get props => [
    cartId,
    productId,
    userId,
    quantity,
    title,
    price,
    image,
  ];
}

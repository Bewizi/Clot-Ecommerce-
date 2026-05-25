class OrderItemDomain {
  final String orderId;
  final String productId;
  final int quantity;
  final double priceAtPurchase;

  OrderItemDomain({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.priceAtPurchase,
  });

  factory OrderItemDomain.fromJson(Map<String, dynamic> json) {
    return OrderItemDomain(
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int,
      priceAtPurchase: (json['price_at_purchase'] as num).toDouble(),
    );
  }

  OrderItemDomain copyWith({
    String? orderId,
    String? productId,
    int? quantity,
    double? priceAtPurchase,
  }) {
    return OrderItemDomain(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      priceAtPurchase: priceAtPurchase ?? this.priceAtPurchase,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }

  List<Object?> get props => [
    orderId,
    productId,
    quantity,
    priceAtPurchase,
  ];
}

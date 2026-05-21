class OrdersDomain {
  final String id;
  final String orderNumber;
  final String userId;
  final String status;
  final String shippingAddress;
  final DateTime placedAt;
  final DateTime confirmedAt;
  final DateTime shippedAt;
  final DateTime deliveredAt;
  final DateTime returnedAt;
  final DateTime canceledAt;

  // final List<OrderItem> items;
  // final double totalPrice;

  OrdersDomain({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.status,
    required this.shippingAddress,
    required this.placedAt,
    required this.confirmedAt,
    required this.shippedAt,
    required this.deliveredAt,
    required this.returnedAt,
    required this.canceledAt,
    // required this.items,
    // required this.totalPrice,
  });

  factory OrdersDomain.fromJson(Map<String, dynamic> json) {
    return OrdersDomain(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      userId: json['user_id'] as String,
      status: json['status'] as String,
      shippingAddress: json['shipping_address'] as String,
      placedAt: json['placed_at'] != null
          ? DateTime.parse(json['placed_at'] as String)
          : DateTime.now(),
      confirmedAt: json['confirmed_at'] != null
          ? DateTime.parse(json['confirmed_at'] as String)
          : DateTime.now(),
      shippedAt: json['shipped_at'] != null
          ? DateTime.parse(json['shipped_at'] as String)
          : DateTime.now(),
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'] as String)
          : DateTime.now(),
      returnedAt: json['returned_at'] != null
          ? DateTime.parse(json['returned_at'] as String)
          : DateTime.now(),
      canceledAt: json['canceled_at'] != null
          ? DateTime.parse(json['canceled_at'] as String)
          : DateTime.now(),
    );
  }

  OrdersDomain copyWith({
    String? id,
    String? orderNumber,
    String? userId,
    String? status,
    String? shippingAddress,
    DateTime? placedAt,
    DateTime? confirmedAt,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? returnedAt,
    DateTime? canceledAt,
  }) {
    return OrdersDomain(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      placedAt: placedAt ?? this.placedAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      shippedAt: shippedAt ?? this.shippedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      returnedAt: returnedAt ?? this.returnedAt,
      canceledAt: canceledAt ?? this.canceledAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'userId': userId,
      'status': status,
      'shippingAddress': shippingAddress,
      'placedAt': placedAt.toIso8601String(),
      'confirmedAt': confirmedAt.toIso8601String(),
      'shippedAt': shippedAt.toIso8601String(),
      'deliveredAt': deliveredAt.toIso8601String(),
      'returnedAt': returnedAt.toIso8601String(),
      'canceledAt': canceledAt.toIso8601String(),
    };
  }

  List<Object?> get props => [
    id,
    orderNumber,
    userId,
    status,
    shippingAddress,
    placedAt,
    confirmedAt,
    shippedAt,
    deliveredAt,
    returnedAt,
    canceledAt,
  ];
}

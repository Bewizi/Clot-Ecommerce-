class OrdersDomain {
  final String id;
  final String orderNumber;
  final String userId;
  final String status;
  final String shippingAddress;
  final DateTime createdAt;

  // final List<OrderItem> items;
  // final double totalPrice;

  OrdersDomain({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
    // required this.items,
    // required this.totalPrice,
  });

  factory OrdersDomain.fromJson(Map<String, dynamic> json) {
    return OrdersDomain(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      userId: json['userId'] as String,
      status: json['status'] as String,
      shippingAddress: json['shippingAddress'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  OrdersDomain copyWith({
    String? id,
    String? orderNumber,
    String? userId,
    String? status,
    String? shippingAddress,
    DateTime? createdAt,
  }) {
    return OrdersDomain(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'userId': userId,
      'status': status,
      'shippingAddress': shippingAddress,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  List<Object?> get props => [
    id,
    orderNumber,
    userId,
    status,
    shippingAddress,
    createdAt,
  ];
}

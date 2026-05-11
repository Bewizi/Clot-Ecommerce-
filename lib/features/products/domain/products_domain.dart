import 'package:equatable/equatable.dart';

class ProductsDomain extends Equatable {
  const ProductsDomain({
    required this.productId,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.productTag = 'none',
  });

  factory ProductsDomain.fromJson(Map<String, dynamic> json) {
    return ProductsDomain(
      productId: json['id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      image: json['image_url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String? ?? '',
      productTag: json['product_tag'] as String? ?? 'none',
    );
  }

  ProductsDomain copyWith({
    String? productId,
    String? categoryId,
    String? image,
    String? title,
    double? price,
    String? description,
    String? productsTag,
  }) {
    return ProductsDomain(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      productTag: productsTag ?? productTag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'category_id': categoryId,
      'image_url': image,
      'title': title,
      'price': price,
      'description': description,
      'product_tag': productTag,
    };
  }

  final String productId;
  final String categoryId;
  final String image;
  final String title;
  final double price;
  final String description;
  final String productTag;

  @override
  List<Object?> get props => [
    productId,
    categoryId,
    image,
    title,
    price,
    description,
    productTag,
  ];
}

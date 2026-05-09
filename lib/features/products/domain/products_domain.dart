import 'package:equatable/equatable.dart';

class ProductsDomain extends Equatable {
  const ProductsDomain({
    required this.categoryId,
    required this.image,
    required this.title,
    required this.price,
    this.productTag = 'none',
  });

  factory ProductsDomain.fromJson(Map<String, dynamic> json) {
    return ProductsDomain(
      categoryId: json['category_id'] as String? ?? '',
      image: json['image_url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      productTag: json['product_tag'] as String? ?? 'none',
    );
  }

  ProductsDomain copyWith({
    String? categoryId,
    String? image,
    String? title,
    double? price,
    String? productsTag,
  }) {
    return ProductsDomain(
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      productTag: productsTag ?? productTag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'image_url': image,
      'title': title,
      'price': price,
      'product_tag': productTag,
    };
  }

  final String categoryId;
  final String image;
  final String title;
  final double price;
  final String productTag;

  @override
  List<Object?> get props => [categoryId, image, title, price, productTag];
}

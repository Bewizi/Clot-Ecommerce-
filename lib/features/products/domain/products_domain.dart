import 'package:equatable/equatable.dart';

class ProductsDomain extends Equatable {
  const ProductsDomain({
    required this.categoryId,
    required this.image,
    required this.title,
    required this.price,
  });

  factory ProductsDomain.fromJson(Map<String, dynamic> json) {
    return ProductsDomain(
      categoryId: json['category_id'] as String,
      image: json['image_url'] as String,
      title: json['title'] as String,
      price: double.parse(json['price'].toString()),
    );
  }

  ProductsDomain copyWith({
    String? categoryId,
    String? image,
    String? title,
    double? price,
  }) {
    return ProductsDomain(
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'image': image,
      'title': title,
      'price': price,
    };
  }

  final String categoryId;
  final String image;
  final String title;
  final double price;

  @override
  List<Object?> get props => [
    categoryId,
    image,
    title,
    price,
  ];
}

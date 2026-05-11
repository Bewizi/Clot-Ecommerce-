part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {
  const GetProducts({required this.categoryId});

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}

class AllProducts extends ProductsEvent {
  const AllProducts();

  @override
  List<Object> get props => [];
}

class GetTopSelling extends ProductsEvent {
  const GetTopSelling();

  @override
  List<Object> get props => [];
}

class GetNewIn extends ProductsEvent {
  const GetNewIn();

  @override
  List<Object> get props => [];
}

class GetProductsById extends ProductsEvent {
  const GetProductsById({required this.productId});

  final String productId;

  @override
  List<Object> get props => [productId];
}

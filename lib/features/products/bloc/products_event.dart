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

part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  const ProductsLoaded({required this.products});

  final List<ProductsDomain> products;

  @override
  List<Object> get props => [products];
}

final class ProductsError extends ProductsState {
  const ProductsError({required this.message});

  final String message;
}

final class TopSellingLoaded extends ProductsState {
  const TopSellingLoaded({required this.products});

  final List<ProductsDomain> products;

  @override
  List<Object> get props => [products];
}

final class NewInLoaded extends ProductsState {
  const NewInLoaded({required this.products});

  final List<ProductsDomain> products;

  @override
  List<Object> get props => [products];
}

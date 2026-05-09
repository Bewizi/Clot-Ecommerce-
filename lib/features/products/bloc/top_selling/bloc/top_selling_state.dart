part of 'top_selling_bloc.dart';

sealed class TopSellingState extends Equatable {
  const TopSellingState();

  @override
  List<Object> get props => [];
}

final class TopSellingInitial extends TopSellingState {}

final class TopSellingLoading extends TopSellingState {}

final class TopSellingLoaded extends TopSellingState {
  const TopSellingLoaded({required this.products});

  final List<ProductsDomain> products;

  @override
  List<Object> get props => [products];
}

final class TopSellingFailure extends TopSellingState {
  const TopSellingFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

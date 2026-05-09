part of 'new_in_bloc.dart';

sealed class NewInState extends Equatable {
  const NewInState();

  @override
  List<Object> get props => [];
}

final class NewInInitial extends NewInState {}

final class NewInLoading extends NewInState {}

final class NewInLoaded extends NewInState {
  const NewInLoaded({required this.products});
  final List<ProductsDomain> products;

  @override
  List<Object> get props => [products];
}

final class NewInError extends NewInState {
  const NewInError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

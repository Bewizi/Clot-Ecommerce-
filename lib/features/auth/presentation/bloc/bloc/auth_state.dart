part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  const AuthLoaded({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class AccountCreated extends AuthState {}

final class AuthSuccess extends AuthState {
  const AuthSuccess({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

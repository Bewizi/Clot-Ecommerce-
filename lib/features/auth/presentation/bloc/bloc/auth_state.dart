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

// Emitted after StoreAccountDetails is dispatched.
// Holds  data so AboutYourself can read it from the bloc state
// and combine it with gender + age when dispatching RegisterAccount.
final class AccountDetailsStored extends AuthState {
  const AccountDetailsStored({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;

  @override
  List<Object> get props => [firstName, lastName, email, password];
}

// Emitted after RegisterAccount  succeeds.
// Signals the UI to navigate to Home.
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

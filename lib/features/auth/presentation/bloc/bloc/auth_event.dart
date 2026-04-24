part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// No Supabase call yet. Just stores details temporarily in the bloc state
// so AboutYourself can read them when dispatching RegisterAccount.
class StoreAccountDetails extends AuthEvent {
  const StoreAccountDetails({
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

// This is the ONLY place the Supabase signUp + insert happens.
// All fields including gender and age are inserted together in one call.
class RegisterAccount extends AuthEvent {
  const RegisterAccount({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String gender;
  final int age;

  @override
  List<Object> get props => [
    firstName,
    lastName,
    email,
    password,
    gender,
    age,
  ];
}

class SignInUser extends AuthEvent {
  const SignInUser({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class GetUserData extends AuthEvent {
  const GetUserData({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

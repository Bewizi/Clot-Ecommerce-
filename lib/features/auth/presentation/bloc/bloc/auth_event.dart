part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Step 1 — dispatched from CreateAccount screen.
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

// Step 2 — dispatched from AboutYourself screen.
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
  final String gender; // 'male' or 'female' — matches DB CHECK constraint
  final int age; // 0–120 — matches DB CHECK constraint

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

class SignIn extends AuthEvent {
  const SignIn({
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

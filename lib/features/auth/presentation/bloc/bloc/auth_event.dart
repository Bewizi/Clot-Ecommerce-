part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class RegisterAccount extends AuthEvent {
  const RegisterAccount({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.gender,
    this.age,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? gender;
  final int? age;
}

class UpdateProfile extends AuthEvent {
  const UpdateProfile({
    required this.userId,
    required this.gender,
    required this.age,
  });

  final String userId;
  final String gender;
  final int age;

  @override
  List<Object> get props => [userId, gender, age];
}

class SignIn extends AuthEvent {
  const SignIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class SignOut extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class GetUserData extends AuthEvent {
  const GetUserData({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

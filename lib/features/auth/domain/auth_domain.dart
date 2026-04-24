import 'package:equatable/equatable.dart';

class AuthDomain extends Equatable {
  const AuthDomain({
    required this.profileId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.gender,
    this.age,
  });

  factory AuthDomain.fromMap(Map<String, dynamic> json) {
    return AuthDomain(
      profileId: json['profile_id'] as String? ?? '',
      firstName: json['firstname'] as String? ?? '',
      lastName: json['lastname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      gender: json['gender'] as String?,
      age: json['age'] as int?,
    );
  }
  final String profileId;
  final String firstName;
  final String lastName;
  final String email;
  final String? gender;
  final int? age;

  AuthDomain copyWith({
    String? profileId,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    int? age,
  }) {
    return AuthDomain(
      profileId: profileId ?? this.profileId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileId': profileId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'age': age,
    };
  }

  @override
  List<Object?> get props => [
    profileId,
    firstName,
    lastName,
    email,
    gender,
    age,
  ];
}

part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfile extends ProfileEvent {}

final class UpdateProfile extends ProfileEvent {
  const UpdateProfile({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  @override
  List<Object> get props => [
    id,
    name,
    email,
  ];
}

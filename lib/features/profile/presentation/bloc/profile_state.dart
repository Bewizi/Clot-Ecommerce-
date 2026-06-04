part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required this.profile});

  final ProfileDomain profile;

  @override
  List<Object> get props => [profile];
}

final class ProfileError extends ProfileState {
  const ProfileError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class ProfileLoading extends ProfileState {}

final class ProfileUpdating extends ProfileState {}

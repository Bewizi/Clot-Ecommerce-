import 'package:bloc/bloc.dart';
import 'package:clot/features/profile/domain/profile_domain.dart';
import 'package:clot/features/profile/domain/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  final ProfileRepository profileRepository;

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } on Exception catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    try {
      await profileRepository.updateProfile(
        id: event.id,
        name: event.name,
        email: event.email,
      );
      final updatedProfile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: updatedProfile));
    } on Exception catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}

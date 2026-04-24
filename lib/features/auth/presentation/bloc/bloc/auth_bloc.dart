import 'package:bloc/bloc.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:clot/features/auth/presentation/pages/create_account/create_account.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterAccount>(_registerAccount);
    on<UpdateProfile>(_updateProfile);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
  }

  Future<void> _registerAccount(
    RegisterAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.createAccount(
        firstname: event.firstName,
        lastname: event.lastName,
        email: event.email,
        password: event.password,
      );
      emit(AccountCreated());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _updateProfile(
    UpdateProfile event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.updateProfile(
        userId: event.userId,
        gender: event.gender,
        age: event.age,
      );
      emit(const AuthSuccess(message: 'Profile updated successfully'));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _signIn(
    SignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(const AuthSuccess(message: 'Signed in successfully'));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _signOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(const AuthSuccess(message: 'Signed out successfully'));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

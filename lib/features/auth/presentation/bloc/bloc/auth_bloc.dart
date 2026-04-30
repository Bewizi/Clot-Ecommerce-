import 'package:bloc/bloc.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<StoreAccountDetails>(_storeAccountDetails);
    on<RegisterAccount>(_registerAccount);
    on<SignInUser>(_signIn);
    on<SignOut>(_signOut);
    on<ResetPassword>(_resetPassword);
    on<VerifyOtp>(_verifyOtp);
    on<UpdatePassword>(_updatePassword);
  }

  // no Supabase call — just stores the form data in state
  // so AboutYourself can read it later via context.read<AuthBloc>().state
  void _storeAccountDetails(
    StoreAccountDetails event,
    Emitter<AuthState> emit,
  ) {
    emit(
      AccountDetailsStored(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
      ),
    );
  }

  // the actual Supabase signUp + single insert with ALL fields
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
        gender: event.gender,
        age: event.age,
      );
      emit(const AuthSuccess(message: 'Account created successfully'));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _signIn(
    SignInUser event,
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

  Future<void> _resetPassword(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.forgotPassword(email: event.email);
      emit(
        const PasswordResetEmailSent(
          message: 'Password reset email sent successfully',
        ),
      );
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _verifyOtp(
    VerifyOtp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.verifyOtp(
        email: event.email,
        token: event.token,
      );
      emit(OtpVerified());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _updatePassword(
    UpdatePassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.updatePassword(newPassword: event.newPassword);
      emit(const PasswordUpdated(message: 'Password updated successfully'));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

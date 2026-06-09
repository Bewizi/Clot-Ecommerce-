import 'package:bloc_test/bloc_test.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository authRepository;
  late AuthBloc authBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository);
  });

  tearDown(() async {
    await authBloc.close();
  });

  group('Auth Bloc', () {
    group('initial state', () {
      test('is AuthInitial', () {
        expect(authBloc.state, AuthInitial());
      });
    });
  });

  group('Sign In Test Cases', () {
    // sign in
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when signIn succeeds',
      build: () {
        when(
          () => authRepository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const SignInUser(email: 'test@mail.com', password: 'password123'),
      ),

      expect: () => [
        AuthLoading(),
        const AuthSuccess(message: 'Signed in successfully'),
      ],
      verify: (_) {
        verify(
          () => authRepository.signIn(
            email: 'test@mail.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    // create Account
  });

  group('Sign Out Test Cases', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when createAccount succeeds',
      build: () {
        when(
          () => authRepository.createAccount(
            firstname: any(named: 'firstname'),
            lastname: any(named: 'lastname'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            gender: any(named: 'gender'),
            age: any(named: 'age'),
          ),
        ).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const RegisterAccount(
          firstName: 'test',
          lastName: 'test',
          email: 'test@mail.com',
          password: 'password123',
          gender: 'male',
          age: 20,
        ),
      ),
      expect: () => [
        AuthLoading(),
        const AuthSuccess(message: 'Account created successfully'),
      ],
      verify: (_) {
        verify(
          () => authRepository.createAccount(
            firstname: 'test',
            lastname: 'test',
            email: 'test@mail.com',
            password: 'password123',
            gender: 'male',
            age: 20,
          ),
        ).called(1);
      },
    );
  });
}

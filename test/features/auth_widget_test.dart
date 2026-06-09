import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:clot/features/auth/presentation/pages/create_account/create_account.dart';
import 'package:clot/features/auth/presentation/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

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

  Widget buildSignIn() {
    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: const SignIn(),
    );
  }

  Widget buildCreateAccount() {
    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: const CreateAccount(),
    );
  }

  group('SignIn', () {
    testWidgets('renders sign in form', (tester) async {
      await tester.pumpApp(buildSignIn());

      expect(find.text('Sign in'), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Continue With Apple'), findsOneWidget);
      expect(find.text('Continue With Google'), findsOneWidget);
      expect(find.text('Continue With Facebook'), findsOneWidget);
    });

    testWidgets('shows validation errors when form is empty', (tester) async {
      await tester.pumpApp(buildSignIn());

      await tester.tap(find.text('Sign in').last);
      await tester.pump();

      expect(find.text('Please enter your email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });
  });

  group('Create Account', () {
    testWidgets('', (tester) async {
      await tester.pumpApp(buildCreateAccount());

      expect(find.text('Create Account'), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Firstname'), findsOneWidget);
      expect(find.text('Lastname'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets(
      'shows validation errors for create account when form is empty',
      (tester) async {
        await tester.pumpApp(buildCreateAccount());

        await tester.tap(find.text('Continue').last);
        await tester.pump();

        expect(find.text('Please enter your firstname'), findsOneWidget);
        expect(find.text('Please enter your lastname'), findsOneWidget);
        expect(find.text('Please enter your email address'), findsOneWidget);
        expect(find.text('Please enter your password'), findsOneWidget);
      },
    );
  });
}

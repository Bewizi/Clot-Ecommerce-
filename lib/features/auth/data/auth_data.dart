import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthData implements AuthRepository {
  @override
  Future<void> createAccount({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String gender,
    required int age,
  }) async {
    try {
      final response = await supaBase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userId = response.user!.id;

        // Single insert with ALL fields — no update needed later.
        // profile_id  → FK to auth.users(id), stores the user's UUID
        // firstname   → matches column name in clot.profile exactly
        // lastname    → matches column name in clot.profile exactly
        // gender      → 'male' or 'female', enforced by DB CHECK constraint
        // age         → 0–120, enforced by DB CHECK constraint
        await supaBase.schema('clot').from('profile').insert({
          'profile_id': userId,
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'gender': gender,
          'age': age,
        });
      }
    } on AuthException catch (e) {
      throw Exception(
        'Failed to create account: Authentication error {${e.message}}',
      );
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supaBase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception('Failed to sign in: Invalid credentials');
      }
    } on AuthException catch (e) {
      throw Exception(
        'Failed to sign in: Authentication error {${e.message}}',
      );
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supaBase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await supaBase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.clot://reset-password',
        captchaToken: email,
      );
    } catch (e) {
      throw Exception('Failed to request password reset: $e');
    }
  }
}

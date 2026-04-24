import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthData implements AuthRepository {
  @override
  Future<void> createAccount({
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? gender,
    int? age,
  }) async {
    try {
      final response = await supaBase.auth.signUp(
        email: email,
        password: password!,
      );
      if (response.user != null) {
        final userId = response.user!.id;
        await supaBase.schema('clot').from('profile').insert({
          'profile_id': userId,
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
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
  Future<void> updateProfile({
    required String userId,
    required String gender,
    required int age,
  }) async {
    try {
      await supaBase
          .schema('clot')
          .from('profile')
          .update({
            'gender': gender,
            'age': age,
          })
          .eq('profile_id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
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
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

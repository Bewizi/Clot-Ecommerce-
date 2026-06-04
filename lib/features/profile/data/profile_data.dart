import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:clot/features/profile/domain/profile_domain.dart';
import 'package:clot/features/profile/domain/profile_repository.dart';

class ProfileDataImpl implements ProfileRepository {
  @override
  Future<ProfileDomain> getProfile() async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('profile')
          .select()
          .single();
      return ProfileDomain.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<ProfileDomain> updateProfile({
    required String id,
    required String name,
    required String email,
  }) async {
    try {
      final response = await supaBase
          .schema('clot')
          .from('profile')
          .update({
            'id': id,
            'name': name,
            'email': email,
          })
          .eq('id', id)
          .select()
          .single();

      return ProfileDomain.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}

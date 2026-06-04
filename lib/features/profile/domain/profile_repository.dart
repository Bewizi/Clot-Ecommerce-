import 'package:clot/features/profile/domain/profile_domain.dart';

abstract class ProfileRepository {
  Future<ProfileDomain> getProfile();
  Future<ProfileDomain> updateProfile({
    required String id,
    required String name,
    required String email,
  });
}

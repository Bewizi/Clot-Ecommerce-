abstract class AuthRepository {
  Future<void> createAccount({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });

  Future<void> updateProfile({
    required String userId,
    required String gender,
    required int age,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

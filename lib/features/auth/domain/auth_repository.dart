abstract class AuthRepository {
  // Single method — signs up the user and inserts ALL profile fields at once
  Future<void> createAccount({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String gender,
    required int age,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> forgotPassword({
    required String email,
  });

  Future<void> verifyOtp({
    required String email,
    required String token,
  });

  Future<void> updatePassword({required String newPassword});
}

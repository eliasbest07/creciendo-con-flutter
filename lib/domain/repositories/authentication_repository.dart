abstract class AuthenticationRepository {
  Future<bool> signIn(String email, String password);
}

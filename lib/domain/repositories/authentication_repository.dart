abstract class AuthenticationRepository {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String name, String email, String password);
  Future<void> signOut();
}

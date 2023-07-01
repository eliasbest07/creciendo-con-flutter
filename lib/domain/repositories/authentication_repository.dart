import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String name, String email, String password);
  Future<void> signOut();

  Future<void> signInWithGoogle();
  Future<void> storeUserName(String email, String name);
  Future<void> storeUserNameWithGoogle(User user);
}

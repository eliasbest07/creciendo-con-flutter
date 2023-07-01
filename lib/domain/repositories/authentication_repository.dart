
import 'package:TaskFlow/domain/entities/usuario_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<bool> signIn(String email, String password);
  Future<void> signInWithGoogle();
  Future<bool> signUp(String name, String email, String password);
  Future<void> signOut();

  Future<void> storeUserName(String email, String name);
  Future<void> storeUserNameWithGoogle(User user);

  User? getCurrentUser();
  Usuario createUsuario(String email, String name);
  Future<void> updateUserData(String uid, Usuario usuario);
}

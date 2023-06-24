import 'package:creciendo_con_flutter/domain/exceptions/exceptions.dart';
import 'package:creciendo_con_flutter/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication implements AuthenticationRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final User = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      //print('${User.user!.email}');
      return auth.authStateChanges().map((user) => user != null).first;
    } on FirebaseAuthException catch (error) {
      //throw UserNotFound(error.message!);
      return false;
    }
  }

  @override
  Future<bool> signUp(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return auth.authStateChanges().map((user) => user != null).first;
    } on FirebaseAuthException catch (error) {
      //throw SignUpFailed(error.message!);
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signInWithGoogle() async {
    // Iniciar sesión con Google
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtener la autenticación de Google
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Crear una credencial utilizando los tokens de acceso y de identificación de Google
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // Iniciar sesión en Firebase con la credencial
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

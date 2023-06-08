import 'package:creciendo_con_flutter/domain/exceptions/exceptions.dart';
import 'package:creciendo_con_flutter/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication implements AuthenticationRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return auth.authStateChanges().map((user) => user != null).first;
    } on FirebaseAuthException catch (error) {
      throw UserNotFound(error.message!);
    }
  }
}

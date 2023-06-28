import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/domain/exceptions/exceptions.dart';
import 'package:creciendo_con_flutter/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
      print("Error de inicio de sesión: ${error.message}");
      return false;
    }
  }

  @override
  Future<bool> signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {storeUserName(email, name)});
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

    if (gUser == null) {
      //El usuerio canceló el inicio de sesión
      return;
    }

    // Obtener la autenticación de Google
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Crear una credencial utilizando los tokens de acceso y de identificación de Google
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // Iniciar sesión en Firebase con la credencial
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user != null) {
      storeUserNameWithGoogle(user);
    } else {
      print("Error al obtener usuario");
    }
  }

  @override
  Future<void> storeUserName(String email, String name) async {
    User? user = auth.currentUser;

    if (user != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child("users").child(user.uid);
      Usuario usu = Usuario(
          email: email,
          nombre: name,
          rol: "Auxiliar",
          fechaRegistro: DateTime.now());
      try {
        await ref.update(usu.toJson());
      } catch (e) {
        print("Error al almacenar el usuario: $e");
      }
    }
  }

  @override
  Future<void> storeUserNameWithGoogle(User user) async {
    final String uid = user.uid;
    final String name = user.displayName ?? "";
    final String email = user.email ?? "email";
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("users").child(uid);
    //Verifica si el usuario ya fue creado
    DatabaseEvent databaseEvent = await databaseReference.once();
    if (databaseEvent.snapshot.value != null) {
      return;
    }
    //Almacena el usuario
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child("users").child(uid);
      Usuario user = Usuario(
          email: email,
          nombre: name,
          rol: "Auxiliar",
          fechaRegistro: DateTime.now());
      await ref.update(user.toJson());
    } catch (e) {
      print("Error al almacenar el usuario");
    }
  }
}

import 'package:TaskFlow/domain/entities/usuario_entity.dart';
import 'package:TaskFlow/domain/exceptions/exceptions.dart';
import 'package:TaskFlow/domain/repositories/authentication_repository.dart';
import 'package:TaskFlow/infrastructure/services/local_storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication implements AuthenticationRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //print('${User.user!.email}');

      //guardando logeo internamente en shared preferences
        final LocalStorage localStorage = LocalStorage();
        localStorage.setLoggedIn(true);
      return auth.authStateChanges().map((user) => user != null).first;
    } on FirebaseAuthException catch (error) {
      throw UserNotFound("Error durante el logeo: $error");
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
      throw SignUpFailed("Error durante el registro: $error");
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();

    //guardando logeo internamente en shared preferences
    final LocalStorage localStorage = LocalStorage();
    localStorage.setLoggedIn(false);
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
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

        //guardando logeo internamente en shared preferences
        final LocalStorage localStorage = LocalStorage();
        localStorage.setLoggedIn(true);
      } else {
        print("Error al obtener usuario");
      }
    } on FirebaseAuthException catch (error) {
      throw SignUpFailed(
          "Error durante el inicio de sesión con Google: $error");
    }
  }

// Almacena el nombre de usuario en Firebase Realtime Database.
// Nota: El método requiere que el usuario esté autenticado.
  @override
  Future<void> storeUserName(String email, String name) async {
    User? user = getCurrentUser();

    if (user != null) {
      Usuario usu = createUsuario(email, name);
      try {
        await updateUserData(user.uid, usu);
      } catch (e) {
        print(e.toString());
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
      Usuario usu = createUsuario(email, name);
      await updateUserData(uid, usu);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  User? getCurrentUser() {
    return auth.currentUser;
  }

  @override
  Usuario createUsuario(String email, String name) {
    return Usuario(
        email: email,
        nombre: name,
        rol: "Auxiliar",
        fechaRegistro: DateTime.now());
  }

  @override
  Future<void> updateUserData(String uid, Usuario usuario) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("users").child(uid);
    try {
      await ref.update(usuario.toJson());
    } catch (e) {
      throw UserStorageFailed("Error al almacenar el usuario: $e");
    }
  }
  
}

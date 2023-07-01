import 'package:TaskFlow/infrastructure/services/firebaseAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/login.dart';

class LoginController extends StateNotifier<Login> {
  LoginController() : super(Login(email: '', password: ''));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailRegisterController =
      TextEditingController();
  final TextEditingController _passwordRegisterController =
      TextEditingController();

  final TextEditingController _nameRegisterController = TextEditingController();

  // final TextEditingController _name = TextEditingController();
  bool verClave = true;

  final FirebaseAuthentication auth = FirebaseAuthentication();

  void setLogin(Login login) {
    state = login;
  }

  bool get claveVer => verClave;
  set claveVer(bool act) {
    verClave = act;
  }

  TextEditingController get inputControllerEmail => _emailController;
  TextEditingController get inputControllerPassword => _passwordController;

  TextEditingController get inputControllerEmailRegister =>
      _emailRegisterController;
  TextEditingController get inputControllerPasswordRegister =>
      _passwordRegisterController;

  TextEditingController get inputControllerNameRegister =>
      _nameRegisterController;

  Future<bool> inciarSesion() async {
    // async
    state =
        Login(email: _emailController.text, password: _passwordController.text);

    return await auth.signIn(state.email, state.password);

    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    // manda a firebase <--
  }

  Future<void> iniciarConGoogle() async {
    await auth.signInWithGoogle();
  }

  Future<bool> registrar() async {
    return await auth.signUp(
        inputControllerNameRegister.text,
        inputControllerEmailRegister.text,
        inputControllerPasswordRegister.text);
  }

  Future<void> cerrarSesion() async {
    inputControllerEmail.text = "";
    inputControllerPassword.text = "";
    await auth.signOut();
  }
  // se conecta al backend Firebase
}

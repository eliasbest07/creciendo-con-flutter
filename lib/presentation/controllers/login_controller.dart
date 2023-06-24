import 'package:creciendo_con_flutter/infrastructure/services/firebaseAuthentication.dart';
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

  final TextEditingController _name = TextEditingController();
  bool verClave = false;
  final FirebaseAuthentication auth = FirebaseAuthentication();

  void setLogin(Login login) {
    state = login;
  }

  get inputControllerEmail => _emailController;
  get inputControllerPassword => _passwordController;

  get inputControllerEmailRegister => _emailRegisterController;
  get inputControllerPasswordRegister => _passwordRegisterController;

  get inputControllerNameRegister => _nameRegisterController;

  Future<bool> inciarSesion() async {
    // async
    state =
        Login(email: _emailController.text, password: _passwordController.text);
    print(' correo = ${state.email} | clave= ${state.password}');
    return await auth.signIn(state.email, state.password);

    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    // manda a firebase <--
  }

  Future<bool> registrar() async {
    return await auth.signUp(
        inputControllerNameRegister.text,
        inputControllerEmailRegister.text,
        inputControllerPasswordRegister.text);
  }

  Future<void> cerrarSesion() async {
    await auth.signOut();
  }
  // se conecta al backend Firebase
}

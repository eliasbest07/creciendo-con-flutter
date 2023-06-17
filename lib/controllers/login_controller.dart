import 'package:creciendo_con_flutter/infrastructure/services/firebaseAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login.dart';

class LoginController extends StateNotifier<Login>{
  LoginController() : super(Login(email: '', password: ''));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  bool verClave =false;
  final FirebaseAuthentication auth = FirebaseAuthentication();
  
  void setLogin(Login login){
    state = login;
  }

  get inputControllerEmail => _emailController;
  get inputControllerPassword => _passwordController;

  void inciarSesion() async { // async 
    state = Login(email: _emailController.text, password: _passwordController.text);
    print(' correo = ${state.email} | clave= ${state.password}');
    await auth.signIn(state.email, state.password);
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    // manda a firebase <--
  }
  void registrar(Login credenciales) async{
    await auth.signUp('carlos', state.email, state.password);
  }


  void cerrarSesion() async{
    await auth.signOut();
  }
  // se conecta al backend Firebase

}
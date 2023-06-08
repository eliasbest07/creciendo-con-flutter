import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login.dart';

class LoginController extends StateNotifier<Login>{
  LoginController() : super(Login(email: '', password: ''));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  void setLogin(Login login){
    state = login;
  }

  get inputControllerEmail => _emailController;
  get inputControllerPassword => _passwordController;

  void inciarSesion() { // async 
    state = Login(email: _emailController.text, password: _passwordController.text);
    print(' correo = ${state.email} | clave= ${state.password}');
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    // manda a firebase <--
  }
  void registrar(Login credenciales){
    
  }
  // se conecta al backend Firebase

}
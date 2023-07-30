import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimController extends StateNotifier<void> {
  AnimController(super.state);

  late AnimationController controllerLogin;
  late AnimationController controllerRegister;
  late AnimationController showalerta;
  late AnimationController showMensaje;
  String mensajeError = '';

  // void set controllerLogin(AnimationController? controllerLogin){
  //   _controllerLogin = controllerLogin;
  // }
  // void set controllerRegister(AnimationController? controllerRegister){
  //   _controllerRegister = controllerRegister;
  // }
  // AnimationController? get controllerLogin => _controllerLogin;
  // AnimationController? get controllerRegister => _controllerRegister;
}

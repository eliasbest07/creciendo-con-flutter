import 'package:TaskFlow/presentation/controllers/animation_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/controllers/login_controller.dart';
import '../presentation/controllers/proyecto_controller.dart';
import '../domain/entities/login.dart';
import '../domain/entities/proyecto/proyecto_entity.dart';

final loadingProvider = StateProvider<bool>((ref) => false);
final showClave =
    StateProvider<bool>((ref) => true); // para la pantalla de login
final showMensaje = StateProvider<String>((ref) => '');
final showClaveReg = StateProvider<bool>(
    (ref) => true); // para la pantalla de login en Registrar
// final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>> ((ref) => ProyectoProvider([Proyecto()])); // es una forma

final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>>(
    (ref) => ProyectoProvider()); // es una forma

final loginController =
    StateNotifierProvider<LoginController, Login>((ref) => LoginController());

final animationController =
    StateNotifierProvider<AnimController, void>((ref) => AnimController(null));

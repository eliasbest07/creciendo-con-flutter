import 'package:creciendo_con_flutter/presentation/controllers/animation_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/controllers/login_controller.dart';
import '../presentation/controllers/proyecto_controller.dart';
import '../domain/entities/login.dart';
import '../domain/entities/proyecto_entity.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

// final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>> ((ref) => ProyectoProvider([Proyecto()])); // es una forma

final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>>(
    (ref) => ProyectoProvider()); // es una forma

final loginController =
    StateNotifierProvider<LoginController, Login>((ref) => LoginController());

final animationController =
    StateNotifierProvider<AnimController, void>((ref) => AnimController(null));

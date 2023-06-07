
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/login_controller.dart';
import '../controllers/proyecto_controller.dart';
import '../models/login.dart';
import '../models/proyecto.dart';

final loadingProvider = StateProvider((ref) => true);

// final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>> ((ref) => ProyectoProvider([Proyecto()])); // es una forma 

final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>> ((ref) => ProyectoProvider()); // es una forma 

final loginController = StateNotifierProvider<LoginController, Login>((ref) => LoginController());
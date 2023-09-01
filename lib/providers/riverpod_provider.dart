import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:TaskFlow/presentation/controllers/animation_controller.dart';
import 'package:TaskFlow/presentation/controllers/task_detail_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/controllers/auxiliar_proyecto_controller.dart';
import '../presentation/controllers/edit_goal_controller.dart';
import '../presentation/controllers/list_goals_controller.dart';
import '../presentation/controllers/list_task_controller.dart';
import '../presentation/controllers/login_controller.dart';
import '../presentation/controllers/new_task_controller.dart';
import '../presentation/controllers/proyecto_controller.dart';
import '../domain/entities/login.dart';
import '../domain/entities/proyecto/proyecto_entity.dart';

final loadingProvider = StateProvider<bool>((ref) => false);
final showClave =
    StateProvider<bool>((ref) => true); // para la pantalla de login
final showMensaje = StateProvider<String>((ref) => '');
final showEstatus = StateProvider<String>((ref) => 'Usuario');
final showNombre = StateProvider<String>((ref) => 'Nombre');
final showClaveReg = StateProvider<bool>(
    (ref) => true); // para la pantalla de login en Registrar
// final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>> ((ref) => ProyectoProvider([Proyecto()])); // es una forma

final listaProyectos = StateNotifierProvider<ProyectoProvider, List<Proyecto>>(
    (ref) => ProyectoProvider()); // es una forma
final listaMetasMyProyecto =
    StateNotifierProvider<MetasController, Map<String, List<Meta>>>(
        (ref) => MetasController({}));
        final listaTareaMyMeta =
    StateNotifierProvider<TaskController, Map<String, List<Tarea>>>(
        (ref) => TaskController({}));
final listaMetasDetalleProyecto =
    StateNotifierProvider<MetasController, Map<String, List<Meta>>>(
        (ref) => MetasController({}));
final listAuxiliarPoyecto =
    StateNotifierProvider<ProyectoAuxiliar, List<ProyectoAuxiliar>>(
        (ref) => ProyectoAuxiliar());
final loginController =
    StateNotifierProvider<LoginController, Login>((ref) => LoginController());

final animationController =
    StateNotifierProvider<AnimController, void>((ref) => AnimController(null));

final editGoal = StateNotifierProvider<EditGoalController, Meta>(
    (ref) => EditGoalController());

final tareaDetails = StateNotifierProvider<TaskDetailController, bool>(
    (ref) => TaskDetailController());

final newTask = StateNotifierProvider<NewTaskController, bool> ((ref) => NewTaskController());

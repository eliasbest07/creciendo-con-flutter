import 'package:TaskFlow/domain/entities/proyecto/tarea_usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskUserController extends StateNotifier<List<TareaUsuario>> {
  TaskUserController() : super([]) {
    init();
  }

  void init() {
    //state = List<Proyecto>.empty();
    //state = [Proyecto(icon: 'vacio', nombre: 'prueba',id: 'test01')];
    cargarProyectos();
    //Cargar los elementos de la lista desde el Backend
    //Firebase.obtenerTodoLosProjectosDelUsuario(IDusuario)
  }

  Future<void> cargarProyectos() async {
    List<TareaUsuario> proyectos = await ProyectoService()
        .obtenerTodasTareasUsuario(FirebaseAuth.instance.currentUser!.uid);
    state = proyectos;
  }
}

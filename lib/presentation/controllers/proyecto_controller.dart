import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/infrastructure/services/proyecto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto_entity.dart';
import '../../domain/entities/tarea_entity.dart';

class ProyectoProvider extends StateNotifier<List<Proyecto>> {
  // ProyectoProvider(super.state);
  ProyectoProvider() : super([]) {
    init();
  }
  TextEditingController inputName = TextEditingController();
  void init() {
    state = List<Proyecto>.empty();
    cargarProyectos();
    //Cargar los elementos de la lista desde el Backend
    //Firebase.obtenerTodoLosProjectosDelUsuario(IDusuario)
  }

  Future<void> cargarProyectos() async {
    List<Proyecto> proyectos = await ProyectoService().obtenerTodosProyectos();
    state = proyectos;
  }

  Future<bool> agregarProyecto() async {
    bool save = false;
    if (inputName.text.isEmpty) {
      return save;
    }
    Proyecto nuevoProyecto = Proyecto(icon: "icon", nombre: inputName.text);
    state = [...state, nuevoProyecto];
    inputName.text = '';
    save = await ProyectoService().guardarProyecto(nuevoProyecto);
    return save;
    //mandar a guardar este nuevoProyecto en firebase y retornar un true si lo guardo bien
    // o retornar false si por cualquier razon no se guardo en firebase
    //bool seGuardo = firebase.nuevoProyectodelUsuario(IDusuario, nuevoProyecto);
  }

  void eliminarProyecto(Proyecto eliminar) {
    //TODO
  }
  void actualizarProyecto(Proyecto actualizar) {
    //TODO
  }
  void agregarIcono() {}
}

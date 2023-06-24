import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto_entity.dart';

class ProyectoProvider extends StateNotifier<List<Proyecto>> {
  // ProyectoProvider(super.state);
  ProyectoProvider() : super([]);
  TextEditingController inputName = TextEditingController();
  void init() {
    state = List<Proyecto>.empty();

    //Cargar los elementos de la lista desde el Backend
    //Firebase.obtenerTodoLosProjectosDelUsuario(IDusuario)
  }

  void agregarProyecto() {
    if (inputName.text.isEmpty) {
      return;
    }
    //Proyecto nuevoProyecto = Proyecto(nombre: inputName.text);
    //state = [...state, nuevoProyecto];
    inputName.text = '';
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

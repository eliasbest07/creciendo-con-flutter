import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto_entity.dart';
import '../../infrastructure/services/proyecto_service.dart';

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
    if (inputName.text.isEmpty) {
      return false;
    }
    Proyecto nuevoProyecto = Proyecto(icon: "icon", nombre: inputName.text);

    //Verificar si el usuario tiene suficientes puntos
    bool puntoSuf = await UsuarioService().verificarPuntosSuficientes();

    if (puntoSuf) {
      bool save = await ProyectoService().guardarProyecto(nuevoProyecto);
      if (save) {
        state = [...state, nuevoProyecto];
        inputName.text = '';
        return true;
      }
    }
    return false;
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

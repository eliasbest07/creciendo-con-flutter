import 'package:TaskFlow/domain/entities/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/meta_entity.dart';
import 'package:TaskFlow/domain/entities/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto_entity.dart';
import '../../domain/entities/tarea_entity.dart';

class ProyectoProvider extends StateNotifier<List<Proyecto>> {
  // ProyectoProvider(super.state);
  ProyectoProvider() : super([]);
  TextEditingController inputName = TextEditingController();
  void init() {
    state = List<Proyecto>.empty();

    //Cargar los elementos de la lista desde el Backend
    //Firebase.obtenerTodoLosProjectosDelUsuario(IDusuario)
  }

  Future<bool> agregarProyecto() async {
    bool save = false;
    if (inputName.text.isEmpty) {
      return save;
    }
    Proyecto nuevoProyecto = Proyecto(icon: "icon", nombre: inputName.text);
    /* Proyecto nuevoProyecto =
        Proyecto(icon: "", nombre: inputName.text, listMeta: [
      Meta(
          nombre: "nombre",
          porcentaje: 10.0,
          item: "item",
          fechaCreada: DateTime(2017, 9, 7, 17, 30),
          fechaEstablecida: DateTime(2017, 9, 7, 17, 30),
          listTarea: [
            Tarea(
                nombre: "nombre",
                listComentarioTarea: [
                  Comentario(nombre: "nombre", descripcion: "descripcion")
                ],
                descripcion: "descripcion",
                estado: "",
                fechaCreada: DateTime(2017, 9, 7, 17, 30),
                fechaEstablecida: DateTime(2017, 9, 7, 17, 30),
                usuarioAsignado: "FH8iwKt5RyTo4i4DMc6xCdg4Mlk1",
                nivel: 1)
          ],
          listComentarioMeta: [
            Comentario(nombre: "nombre", descripcion: "descripcion)"),
          ])
    ], listComentarioPy: [
      Comentario(nombre: "Comentario", descripcion: "descripcion"),
      Comentario(nombre: "Comentario", descripcion: "descripcion")
    ], listUserLideres: [
      "FH8iwKt5RyTo4i4DMc6xCdg4Mlk1",
      "BZQ7nBkuIHMMnZYO9Ov96EqEdiK2"
    ]); */
    state = [...state, nuevoProyecto];
    inputName.text = '';
    save = await ProyectoCrud().guardarProyecto(nuevoProyecto);
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

import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tarea {
  String nombre;
  String descripcion;
  List<Comentario> listComentario = [];
  User usuarioAsignado;
  DateTime fechaCreada;
  DateTime fechaEstablecida;
  String estado;
  int nivel;

  Tarea(
      this.nombre,
      this.descripcion,
      this.listComentario,
      this.usuarioAsignado,
      this.fechaCreada,
      this.fechaEstablecida,
      this.estado,
      this.nivel);
}

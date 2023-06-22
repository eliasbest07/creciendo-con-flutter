import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';

import 'usuarioAsignado_entity.dart';

class Tarea {
  String nombre;
  String descripcion;
  List<Comentario> listComentario = [];
  UsuarioAsignado usuarioAsignado;
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

        Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'listComentario': listComentario.map((comentario) => comentario.toJson()).toList(),
      'usuarioAsignado': usuarioAsignado.toJson(),
      'fechaCreada': fechaCreada.toIso8601String(),
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'estado': estado,
      'nivel': nivel,
    };
  }
}

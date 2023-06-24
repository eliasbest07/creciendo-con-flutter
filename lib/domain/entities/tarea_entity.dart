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
      {required this.nombre,
      required this.descripcion,
      required this.listComentario,
      required this.usuarioAsignado,
      required this.fechaCreada,
      required this.fechaEstablecida,
      required this.estado,
      required this.nivel});

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'listComentario':
          listComentario.map((comentario) => comentario.toJson()).toList(),
      'usuarioAsignado': usuarioAsignado.toJson(),
      'fechaCreada': fechaCreada.toIso8601String(),
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'estado': estado,
      'nivel': nivel,
    };
  }

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      listComentario: List<Comentario>.from(
        json['listComentario']
            .map((comentarioJson) => Comentario.fromJson(comentarioJson)),
      ),
      usuarioAsignado: UsuarioAsignado.fromJson(json['usuarioAsignado']),
      fechaCreada: DateTime.parse(json['fechaCreada']),
      fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
      estado: json['estado'],
      nivel: json['nivel'],
    );
  }
}

import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';

import 'usuarioAsignado_entity.dart';

class Tarea {
  String nombre;
  String descripcion;
  List<Comentario>? listComentario = [];
  UsuarioAsignado? usuarioAsignado;
  DateTime? fechaCreada;
  DateTime? fechaEstablecida;
  String estado;
  int nivel;

  Tarea({
    required this.nombre,
    required this.descripcion,
    this.listComentario,
    this.usuarioAsignado,
    this.fechaCreada,
    this.fechaEstablecida,
    required this.estado,
    required this.nivel,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'listComentario':
          listComentario?.map((comentario) => comentario.toJson()).toList(),
      'usuarioAsignado': usuarioAsignado?.toJson(),
      'fechaCreada': fechaCreada?.toIso8601String(),
      'fechaEstablecida': fechaEstablecida?.toIso8601String(),
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

  static List<Tarea> listaTarea = [
    Tarea(
      nombre: 'Tarea 1',
      descripcion:
          'Et ut tempor adipisicing laborum qui sunt est magna pariatur eiusmod dolor minim. Consequat fugiat cillum aliquip in laboris veniam nostrud excepteur occaecat sit. Ad minim sint ex nisi exercitation qui proident eu duis do pariatur deserunt mollit. Eiusmod sit est in deserunt consectetur est officia minim culpa ipsum incididunt. Magna deserunt sint anim minim amet nulla laborum voluptate. Cupidatat commodo cillum cillum cupidatat aliqua. Officia consectetur consequat est sit cupidatat esse culpa Lorem est anim occaecat labore consequat.',
      estado: 'En proceso',
      nivel: 1,
    ),
    Tarea(
      nombre: 'Tarea 2',
      descripcion:
          'Eiusmod reprehenderit ea est amet dolore irure ex officia et adipisicing adipisicing. Fugiat consequat non consectetur deserunt exercitation deserunt ex et id duis. Ut sunt cupidatat nostrud ullamco quis nulla fugiat excepteur ullamco. Excepteur consectetur consectetur duis fugiat sunt sint culpa ad ullamco ipsum incididunt. Cillum nulla anim aliquip nulla mollit ut eu elit commodo labore nulla adipisicing. Ipsum aliqua velit excepteur minim irure dolore officia deserunt.',
      estado: 'En proceso',
      nivel: 2,
    ),
    Tarea(
      nombre: 'Tarea 3',
      descripcion:
          'Eiusmod non qui laborum sint sint duis officia irure sint Lorem magna qui est voluptate. In cupidatat irure laborum elit anim ipsum velit magna mollit. Id nostrud in minim adipisicing sit culpa. Quis mollit aliquip velit dolor labore tempor anim elit tempor consectetur fugiat. Voluptate laborum eu quis enim Lorem sit eiusmod incididunt occaecat reprehenderit culpa amet nisi nulla. Tempor sunt consectetur voluptate proident.',
      estado: 'Revisión',
      nivel: 2,
    ),
    Tarea(
      nombre: 'Tarea 4',
      descripcion:
          'Ipsum anim enim aliqua reprehenderit enim tempor cupidatat in dolor laborum exercitation.',
      estado: 'Terminado',
      nivel: 3,
    ),
    Tarea(
      nombre: 'Tarea 5',
      descripcion: 'Quis laboris Lorem occaecat duis culpa dolore dolore.',
      estado: 'Avanzado',
      nivel: 4,
    ),
    Tarea(
      nombre: 'Tarea 6',
      descripcion: 'Aliquip culpa magna proident mollit deserunt voluptate.',
      estado: 'Terminado',
      nivel: 5,
    ),
  ];
}

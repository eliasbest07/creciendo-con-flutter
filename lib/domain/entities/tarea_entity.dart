import 'package:TaskFlow/domain/entities/comentario_entity.dart';

class Tarea {
  String? id;
  String nombre;
  String descripcion;
  List<Comentario>? listComentarioTarea = [];
  String? usuarioAsignado;
  DateTime? fechaCreada;
  DateTime fechaEstablecida;
  String estado;
  int nivel;

  Tarea({
    this.id,
    required this.nombre,
    required this.descripcion,
    this.listComentarioTarea,
    this.usuarioAsignado,
    this.fechaCreada,
    required this.fechaEstablecida,
    required this.estado,
    required this.nivel,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'listComentarioTarea': listComentarioTarea
          ?.map((comentario) => comentario.toJson())
          .toList(),
      'usuarioAsignado': usuarioAsignado,
      'fechaCreada': fechaCreada?.toIso8601String(),
      'fechaEstablecida': fechaEstablecida?.toIso8601String(),
      'estado': estado,
      'nivel': nivel,
    };
  }

  factory Tarea.fromJson(Map<dynamic, dynamic> json) {
    return Tarea(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      listComentarioTarea: json['listComentarioTarea'] != null
          ? (json['listComentarioTarea'] as Map<dynamic, dynamic>)
              .values
              .map((comentJson) => Comentario.fromJson(comentJson))
              .toList()
          : null,
      usuarioAsignado: json['usuarioAsignado'],
      fechaCreada: json['fechaCreada'] != null
          ? DateTime.parse(json['fechaCreada'])
          : null,
      fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
      estado: json['estado'],
      nivel: json['nivel'],
    );
  }

  static List<Tarea> listaTarea = [
    Tarea(
      nombre: 'Tarea 1',
      fechaEstablecida: DateTime.now(),
      descripcion:
          'Et ut tempor adipisicing laborum qui sunt est magna pariatur eiusmod dolor minim. Consequat fugiat cillum aliquip in laboris veniam nostrud excepteur occaecat sit. Ad minim sint ex nisi exercitation qui proident eu duis do pariatur deserunt mollit. Eiusmod sit est in deserunt consectetur est officia minim culpa ipsum incididunt. Magna deserunt sint anim minim amet nulla laborum voluptate. Cupidatat commodo cillum cillum cupidatat aliqua. Officia consectetur consequat est sit cupidatat esse culpa Lorem est anim occaecat labore consequat.',
      estado: 'En proceso',
      nivel: 1,
    ),
    Tarea(
      nombre: 'Tarea 2',
      fechaEstablecida: DateTime.now(),
      descripcion:
          'Eiusmod reprehenderit ea est amet dolore irure ex officia et adipisicing adipisicing. Fugiat consequat non consectetur deserunt exercitation deserunt ex et id duis. Ut sunt cupidatat nostrud ullamco quis nulla fugiat excepteur ullamco. Excepteur consectetur consectetur duis fugiat sunt sint culpa ad ullamco ipsum incididunt. Cillum nulla anim aliquip nulla mollit ut eu elit commodo labore nulla adipisicing. Ipsum aliqua velit excepteur minim irure dolore officia deserunt.',
      estado: 'En proceso',
      nivel: 2,
    ),
    Tarea(
      nombre: 'Tarea 3',
      fechaEstablecida: DateTime.now(),
      descripcion:
          'Eiusmod non qui laborum sint sint duis officia irure sint Lorem magna qui est voluptate. In cupidatat irure laborum elit anim ipsum velit magna mollit. Id nostrud in minim adipisicing sit culpa. Quis mollit aliquip velit dolor labore tempor anim elit tempor consectetur fugiat. Voluptate laborum eu quis enim Lorem sit eiusmod incididunt occaecat reprehenderit culpa amet nisi nulla. Tempor sunt consectetur voluptate proident.',
      estado: 'Revisión',
      nivel: 2,
    ),
    Tarea(
      nombre: 'Tarea 4',
      fechaEstablecida: DateTime.now(),
      descripcion:
          'Ipsum anim enim aliqua reprehenderit enim tempor cupidatat in dolor laborum exercitation.',
      estado: 'Terminado',
      nivel: 3,
    ),
    Tarea(
      nombre: 'Tarea 5',
      fechaEstablecida: DateTime.now(),
      descripcion: 'Quis laboris Lorem occaecat duis culpa dolore dolore.',
      estado: 'Avanzado',
      nivel: 4,
    ),
    Tarea(
      nombre: 'Tarea 6',
      fechaEstablecida: DateTime.now(),
      descripcion: 'Aliquip culpa magna proident mollit deserunt voluptate.',
      estado: 'Terminado',
      nivel: 5,
    ),
  ];
}

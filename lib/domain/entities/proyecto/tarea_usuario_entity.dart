import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';

class TareaUsuario {
  String descripcion = '';
  String nombre = '';
  String estado = '';
  String metaId = '';
  String proyectoId = '';
  String tareaid = '';
  String userTareaId = '';
  DateTime fechaEstablecida;

  TareaUsuario(
      {required this.descripcion,
      required this.estado,
      required this.nombre,
      required this.metaId,
      required this.proyectoId,
      required this.tareaid,
      required this.fechaEstablecida,
      required this.userTareaId});

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'estado': estado,
      'metaId': metaId,
      'nombre': nombre,
      'tareaid': tareaid,
      'proyectoId': proyectoId,
      'userTareaId': userTareaId
    };
  }

  factory TareaUsuario.fromJson(Map<dynamic, dynamic> json) {
    return TareaUsuario(
      descripcion: json['descripcion'],
      fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
      estado: json['estado'],
      metaId: json['metaId'],
      tareaid: json['tareaid'],
      proyectoId: json['proyectoId'],
      userTareaId: json['userTareaId'] ?? '',
      nombre: json['nombre'] ?? 'sin nombre',
    );
  }

  static List<Tarea> convertirListTarea(List<TareaUsuario> tareaUsuario) {
    List<Tarea> resultado = [];
    for (var element in tareaUsuario) {
      resultado.add(Tarea(
        descripcion: element.descripcion,
        estado: element.estado,
        nivel: 1,
        nombre: element.descripcion,
        fechaEstablecida: element.fechaEstablecida,
        id: element.tareaid,
      ));
    }
    return resultado;
  }

  static Tarea convertirTarea(TareaUsuario tareaUsuario) {
    return Tarea(
      descripcion: tareaUsuario.descripcion,
      estado: tareaUsuario.estado,
      nivel: 1,
      nombre: tareaUsuario.descripcion,
      fechaEstablecida: tareaUsuario.fechaEstablecida,
      id: tareaUsuario.tareaid,
    );
  }
}

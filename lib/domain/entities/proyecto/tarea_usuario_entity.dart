import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';

class TareaUsuario {
  String descripcion = '';
  String estado = '';
  String metaId = '';
  String proyectoId = '';
  String tareaid = '';
  DateTime fechaEstablecida;

  TareaUsuario({
    required this.descripcion,
    required this.estado,
    required this.metaId,
    required this.proyectoId,
    required this.tareaid,
    required this.fechaEstablecida,
  });

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'estado': estado,
      'metaId': metaId,
      'tareaid': tareaid,
      'proyectoId': proyectoId,
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
    );
  }

  static List<Tarea> convertirListTarea(List<TareaUsuario> tareaUsuario) {
    List<Tarea> resultado = [];
    for (var element in tareaUsuario) { 
      TareaUsuario(descripcion:element.descripcion ,
      estado: element.estado,
      fechaEstablecida: element.fechaEstablecida,
      metaId: element.metaId,
      proyectoId: element.proyectoId,
      tareaid: element.tareaid,
      );
    }
    return resultado;
  }
}

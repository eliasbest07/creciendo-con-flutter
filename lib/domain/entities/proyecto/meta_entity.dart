import 'package:TaskFlow/domain/entities/proyecto/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';

class Meta {
  String? id;
  String proyectoID = '';
  String nombre;
  double? porcentaje;
  String item;
  List<String> campos = [];
  DateTime? fechaCreada;
  DateTime fechaEstablecida;
  List<Tarea>? listTarea = [];
  List<Comentario>? listComentarioMeta = [];

  Meta(
      {this.id,
      required this.nombre,
      this.porcentaje,
      this.proyectoID = '',
      required this.item,
      this.fechaCreada,
      required this.fechaEstablecida,
      this.listTarea,
      this.listComentarioMeta});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'porcentaje': porcentaje,
      'proyectoID': proyectoID,
      'item': item,
      'fechaCreada': fechaCreada?.toIso8601String(),
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'listTarea': listTarea?.map((tarea) => tarea.toJson()).toList(),
      'listComentarioMeta':
          listComentarioMeta?.map((comentario) => comentario.toJson()).toList(),
    };
  }

  factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
      id: json['id'],
      nombre: json['nombre'],
      porcentaje: json['porcentaje'] != null
          ? double.parse(json['porcentaje'].toString())
          : null,
      item: json['item'],
      proyectoID: json['proyectoID'],
      fechaCreada: json['fechaCreada'] != null
          ? DateTime.parse(json['fechaCreada'])
          : null,
      fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
      listTarea: json['listTarea'] != null
          ? (json['listTarea'] as Map<dynamic, dynamic>)
              .values
              .map((tareaJson) => Tarea.fromJson(tareaJson))
              .toList()
          : null,
      listComentarioMeta: json['listComentarioMeta'] != null
          ? (json['listComentarioMeta'] as Map<dynamic, dynamic>)
              .values
              .map((comentJson) => Comentario.fromJson(comentJson))
              .toList()
          : null);
}

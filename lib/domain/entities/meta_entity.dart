import 'package:TaskFlow/domain/entities/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/tarea_entity.dart';
import 'package:flutter/widgets.dart';

class Meta {
  String? id;
  String nombre;
  double? porcentaje;
  String item;
  DateTime? fechaCreada;
  DateTime fechaEstablecida;
  List<Tarea>? listTarea = [];
  List<Comentario>? listComentarioMeta = [];

  Meta(
      {this.id,
      required this.nombre,
      this.porcentaje,
      required this.item,
      required this.fechaCreada,
      required this.fechaEstablecida,
      required this.listTarea,
      this.listComentarioMeta});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'porcentaje': porcentaje,
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
        porcentaje: double.parse(json['porcentaje'].toString()),
        item: json['item'],
        fechaCreada: DateTime.parse(json['fechaCreada']),
        fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
        listTarea: List<Tarea>.from(
            json["listTarea"].map((tareaJson) => Tarea.fromJson(tareaJson))),
        listComentarioMeta: List<Comentario>.from(json["listComentarioMeta"]
            .map((comentarioJson) => Comentario.fromJson(comentarioJson))),
      );
}

import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:flutter/widgets.dart';

class Meta {
  String nombre;
  double porcentaje;
  String item;
  DateTime fechaCreada;
  DateTime fechaEstablecida;
  List<Tarea> listTarea = [];
  List<Comentario> listComentario = [];

  Meta(
      {required this.nombre,
      required this.porcentaje,
      required this.item,
      required this.fechaCreada,
      required this.fechaEstablecida,
      required this.listTarea,
      required this.listComentario});

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'porcentaje': porcentaje,
      'item': item,
      'fechaCreada': fechaCreada.toIso8601String(),
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'listTarea': listTarea.map((tarea) => tarea.toJson()).toList(),
      'listComentario':
          listComentario.map((comentario) => comentario.toJson()).toList(),
    };
  }

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        nombre: json['nombre'],
        porcentaje: json['porcentaje'],
        item: json['item'],
        fechaCreada: DateTime.parse(json['fechaCreada']),
        fechaEstablecida: DateTime.parse(json['fechaEstablecida']),
        listTarea: List<Tarea>.from(
            json["listTarea"].map((tareaJson) => Tarea.fromJson(tareaJson))),
        listComentario: List<Comentario>.from(json["listComentario"]
            .map((comentarioJson) => Comentario.fromJson(comentarioJson))),
      );
}

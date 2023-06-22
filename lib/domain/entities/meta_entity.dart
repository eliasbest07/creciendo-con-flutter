import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';

class Meta {
  String nombre;
  double porcentaje;
  String item;
  DateTime fechaCreada;
  DateTime fechaEstablecida;
  List<Tarea> listTarea = [];
  List<Comentario> listComentario = [];

  Meta(this.nombre, this.porcentaje, this.item, this.fechaCreada,
      this.fechaEstablecida, this.listTarea, this.listComentario);

        Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'porcentaje': porcentaje,
      'item': item,
      'fechaCreada': fechaCreada.toIso8601String(),
      'fechaEstablecida': fechaEstablecida.toIso8601String(),
      'listTarea': listTarea.map((tarea) => tarea.toJson()).toList(),
      'listComentario': listComentario.map((comentario) => comentario.toJson()).toList(),
    };
  }
}

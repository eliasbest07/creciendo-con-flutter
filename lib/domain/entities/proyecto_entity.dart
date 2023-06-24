import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

class Proyecto {
  String icon;
  String nombre;
  List<Meta> listMeta = [];
  List<Comentario> listComentario = [];
  List<Usuario> listUserLideres = [];

  Proyecto(
      {required this.icon,
      required this.nombre,
      required this.listMeta,
      required this.listComentario,
      required this.listUserLideres});

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'nombre': nombre,
      'listMeta': listMeta.map((meta) => meta.toJson()).toList(),
      'listComentario':
          listComentario.map((comentario) => comentario.toJson()).toList(),
      'listUserLideres':
          listUserLideres.map((usuario) => usuario.toJson()).toList(),
    };
  }

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
        icon: json["icon"],
        nombre: json["nombre"],
        listMeta: List<Meta>.from(
            json["listMeta"].map((metaJson) => Meta.fromJson(metaJson))),
        listComentario: List<Comentario>.from(json["listComentario"]),
        listUserLideres: List<Usuario>.from(json["listUserLideres"]),
      );
}

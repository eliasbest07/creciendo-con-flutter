import 'package:TaskFlow/domain/entities/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/meta_entity.dart';
import 'package:TaskFlow/domain/entities/usuarioLider_entity.dart';
import 'package:TaskFlow/domain/entities/usuario_entity.dart';

class Proyecto {
  String? id;
  String icon;
  String nombre;
  List<Meta>? listMeta;
  List<Comentario>? listComentarioPy;
  List<UsuarioLider>? listUserLideres;

  Proyecto(
      {this.id,
      required this.icon,
      required this.nombre,
      this.listMeta,
      this.listComentarioPy,
      this.listUserLideres});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'nombre': nombre,
      'listMeta': listMeta?.map((meta) => meta.toJson()).toList(),
      'listComentarioPy':
          listComentarioPy?.map((comentario) => comentario.toJson()).toList(),
      'listUserLideres':
          listUserLideres?.map((lideres) => lideres.toJson()).toList(),
    };
  }

  factory Proyecto.fromJson(Map<dynamic, dynamic> json) => Proyecto(
        id: json["id"],
        icon: json["icon"],
        nombre: json["nombre"],
        listMeta: json["listMeta"] != null
            ? (json['listMeta'] as Map<dynamic, dynamic>)
                .values
                .map((metaJson) => Meta.fromJson(metaJson))
                .toList()
            : null,
        listComentarioPy: json["listComentarioPy"] != null
            ? (json['listComentarioPy'] as Map<dynamic, dynamic>)
                .values
                .map((comentPyJson) => Comentario.fromJson(comentPyJson))
                .toList()
            : null,
        listUserLideres: json["listUserLideres"] != null
            ? (json['listUserLideres'] as Map<dynamic, dynamic>)
                .values
                .map((listUserJson) => UsuarioLider.fromJson(listUserJson))
                .toList()
            : null,
      );
}

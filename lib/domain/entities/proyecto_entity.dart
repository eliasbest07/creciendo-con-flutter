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
            ? List<Meta>.from(
                json["listMeta"].map((metaJson) => Meta.fromJson(metaJson)))
            : null,
        listComentarioPy: json["listComentarioPy"] != null
            ? List<Comentario>.from(json["listComentarioPy"]
                .map((comentarioJson) => Comentario.fromJson(comentarioJson)))
            : null,
        listUserLideres: json["listUserLideres"] != null
            ? List<UsuarioLider>.from(json["listUserLideres"])
            : null,
      );
}

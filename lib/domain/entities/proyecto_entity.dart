import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

class Proyecto {
  String icono;
  String nombre;
  List<Meta> listMeta = [];
  List<Comentario> listComentario = [];
  List<Usuario> listUserLideres = [];

  Proyecto(this.icono, this.nombre, this.listMeta, this.listComentario,
      this.listUserLideres);

        Map<String, dynamic> toJson() {
    return {
      'icon': icono,
      'nombre': nombre,
      'listMeta': listMeta.map((meta) => meta.toJson()).toList(),
      'listCom': listComentario.map((comentario) => comentario.toJson()).toList(),
      'listUserLideres': listUserLideres.map((usuario) => usuario.toJson()).toList(),
    };
  }
}

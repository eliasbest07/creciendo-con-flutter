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
}

import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

abstract class MetaRepository {
  Future<void> guardarMeta(Meta meta);
  Future<void> guardarProyecto(Proyecto proyecto);
  Future<void> guardarTarea(Tarea tarea);
  Future<void> guardarUsuario(Usuario usuario);
  Future<void> guardarComentario(Comentario comentario);
}

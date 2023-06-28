import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

abstract class ProyectoRepository {
  Future<bool> guardarProyecto(Proyecto proyecto);
  Future<void> guardarMeta(String proyectoId, Meta meta);
  Future<void> guardarTarea(String proyectoId, String metaId, Tarea tarea);

  Future<void> guardarComentarioProyecto(
      String proyectoId, Comentario comentario);
  Future<void> guardarComentarioMeta(
      String proyectoId, String metaId, Comentario comentario);
  Future<void> guardarComentarioTarea(
      String proyectoId, String metaId, String tareaId, Comentario comentario);

/*   Future<void> eliminarProyecto(Proyecto proyecto);
  Future<void> eliminarMeta(Meta meta);
  Future<void> eliminarTarea(Tarea tarea);
  Future<void> eliminarComentario(Comentario comentario); */

  /* Future<void> actualizarProyectoDeUsuario(
      String usuarioId, String proyectoId, Proyecto proyectoActualizado);
  Future<void> actualizarMeta(
      String usuarioId, Meta metaActualizada, String metaID);
  Future<void> actualizarTarea(String usuarioId, Tarea tarea, String tareaID);
  Future<void> actualizarComentario(
      String usuarioId, Comentario comActualizado, String comentarioId); */

  Future<Proyecto?> obtenerProyecto(String proyectoId);
  /* Future<Meta?> obtenerMeta(String metaId);
  Future<Tarea?> obtenerTarea(String tareaId);
  Future<Comentario?> obtenerComentario(String comentarioId); */
}

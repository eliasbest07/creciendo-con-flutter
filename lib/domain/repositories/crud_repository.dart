import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

abstract class CrudRepository {
  Future<void> guardarMeta(Meta meta);
  Future<void> guardarProyecto(Proyecto proyecto);
  Future<void> guardarTarea(Tarea tarea);
  Future<void> guardarUsuario(Usuario usuario);
  Future<void> guardarComentario(Comentario comentario);

  Future<void> eliminarUsuario(Usuario usuario);
  Future<void> eliminarProyecto(Proyecto proyecto);
  Future<void> eliminarMeta(Meta meta);
  Future<void> eliminarTarea(Tarea tarea);
  Future<void> eliminarComentario(Comentario comentario);

  Future<void> actualizarUsuario(String usuarioId, Usuario usuario);
  Future<void> actualizarProyectoDeUsuario(
      String usuarioId, String proyectoId, Proyecto proyectoActualizado);
  Future<void> actualizarMeta(
      String usuarioId, Meta metaActualizada, String metaID);
  Future<void> actualizarTarea(String usuarioId, Tarea tarea, String tareaID);
  Future<void> actualizarComentario(
      String usuarioId, Comentario comActualizado, String comentarioId);

  Future<Usuario?> obtenerUsuario(String usuarioId);
  Future<Proyecto?> obtenerProyecto(String proyectoId);
  Future<Meta?> obtenerMeta(String metaId);
  Future<Tarea?> obtenerTarea(String tareaId);
  Future<Comentario?> obtenerComentario(String comentarioId);
  Future<Medalla?> obtenerMedalla(String medallaId);
}

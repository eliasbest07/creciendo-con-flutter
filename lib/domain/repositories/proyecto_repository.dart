import 'package:TaskFlow/domain/entities/proyecto/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/proyecto_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';

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

  Future<void> eliminarProyecto(String proyectoId);

  Future<Proyecto?> buscarProyecto(String proyectoId);
  Future<Meta?> buscarMeta(String proyectoId, String metaId);
  Future<Tarea?> buscarTarea(String proyectoId, String metaId, String tareaId);

  Future<bool> ingresarComoAuxiliar(String projectId, String userId);
  Future<bool> verificarUsuarioEnProyecto(String proyectoId, String userId);
  /* Nota : Solo usar estos roles : Lider, Lider_Backend, Lider_UI, Lider_Code, Sublider_Backend,
  Sublider_UI, Sublider_Code, Auxiliar */
  Future<bool> cambiarRol(String proyectoId, String usuarioId, String nuevoRol);
}

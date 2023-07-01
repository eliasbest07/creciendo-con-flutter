import 'package:TaskFlow/domain/entities/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/medalla_entity.dart';
import 'package:TaskFlow/domain/entities/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto_entity.dart';
import 'package:TaskFlow/domain/entities/tarea_entity.dart';
import 'package:TaskFlow/domain/entities/usuario_entity.dart';

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
}

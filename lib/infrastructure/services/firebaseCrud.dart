import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/domain/repositories/crud_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseCrud implements CrudRepository {
  FirebaseDatabase db = FirebaseDatabase.instance;

  //Guardar objetos de firebase realtime

  @override
  Future<void> guardarUsuario(Usuario usuario) async {
    await db.ref().child("usuario").push().set(usuario);
  }

  @override
  Future<void> guardarProyecto(Proyecto proyecto) async {
    await db.ref().child("proyecto").push().set(proyecto);
  }

  @override
  Future<void> guardarMeta(Meta meta) async {
    await db.ref().child("meta").set(meta);
  }

  @override
  Future<void> guardarTarea(Tarea tarea) async {
    await db.ref().child("tarea").push().set(tarea);
  }

  @override
  Future<void> guardarComentario(Comentario comentario) async {
    await db.ref().child("comentario").push().set(comentario);
  }

  //Eliminar objetos de firebase realtime
  @override
  Future<void> eliminarUsuario(Usuario usuario) async {
    await db.ref().child("usuario").remove();
  }

  Future<void> eliminarProyecto(Proyecto proyecto) async {
    await db.ref().child("proyecto").remove();
  }

  Future<void> eliminarMeta(Meta meta) async {
    await db.ref().child("meta").remove();
  }

  Future<void> eliminarTarea(Tarea tarea) async {
    await db.ref().child("tarea").remove();
  }

  Future<void> eliminarComentario(Comentario comentario) async {
    await db.ref().child("comentario").remove();
  }

  //Actualizar objeto dentro de firebase realtime

  Future<void> actualizarUsuario(String usuarioId, Usuario usuario) async {
    DatabaseReference usuarioRef = db.ref().child("usuario").child(usuarioId);

    Map<String, dynamic> usuarioActualizadoMap = usuario.toJson();
    await usuarioRef.set(usuarioActualizadoMap);
  }

  Future<void> actualizarProyectoDeUsuario(
      String usuarioId, String proyectoId, Proyecto proyectoActualizado) async {
    DatabaseReference usuarioRef = db
        .ref()
        .child("usuario")
        .child(usuarioId)
        .child("proyecto")
        .child(proyectoId);

    Map<String, dynamic> proyectoActualizadoMap = proyectoActualizado.toJson();
    await usuarioRef.set(proyectoActualizadoMap);
  }

  Future<void> actualizarMeta(
      String usuarioId, Meta metaActualizada, String metaID) async {
    DatabaseReference usuarioRef =
        db.ref().child("usuario").child(usuarioId).child("meta").child(metaID);

    Map<String, dynamic> metaActualizadaMap = metaActualizada.toJson();
    await usuarioRef.set(metaActualizadaMap);
  }

  Future<void> actualizarTarea(
      String usuarioId, Tarea tarea, String tareaID) async {
    DatabaseReference usuarioRef = db
        .ref()
        .child("usuario")
        .child(usuarioId)
        .child("tarea")
        .child(tareaID);

    Map<String, dynamic> tareaActualizadaMap = tarea.toJson();
    await usuarioRef.set(tareaActualizadaMap);
  }

  Future<void> actualizarComentario(
      String usuarioId, Comentario comActualizado, String comentarioId) async {
    DatabaseReference usuarioRef = db
        .ref()
        .child("usuario")
        .child(usuarioId)
        .child("comentario")
        .child(comentarioId);

    Map<String, dynamic> comentarioActualizadaMap = comActualizado.toJson();
    await usuarioRef.set(comentarioActualizadaMap);
  }

  @override
  Future<Comentario?> obtenerComentario(String comentarioId) async {
    DatabaseReference ref = db.ref().child("comentario").child(comentarioId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> comentarioData =
          snapshot.value as Map<String, dynamic>;
      Comentario comentario = Comentario.fromJson(comentarioData);
      return comentario;
    }
    return null;
  }

  @override
  Future<Meta?> obtenerMeta(String metaId) async {
    DatabaseReference ref = db.ref().child("meta").child(metaId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> metaData = snapshot.value as Map<String, dynamic>;
      Meta meta = Meta.fromJson(metaData);
      return meta;
    }
    return null;
  }

  @override
  Future<Proyecto?> obtenerProyecto(String proyectoId) async {
    DatabaseReference ref = db.ref().child("proyecto").child(proyectoId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> proyectoData =
          snapshot.value as Map<String, dynamic>;
      Proyecto proyecto = Proyecto.fromJson(proyectoData);
      return proyecto;
    }
    return null;
  }

  @override
  Future<Tarea?> obtenerTarea(String tareaId) async {
    DatabaseReference ref = db.ref().child("tarea").child(tareaId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> tareaData = snapshot.value as Map<String, dynamic>;
      Tarea tarea = Tarea.fromJson(tareaData);
      return tarea;
    }
    return null;
  }

  @override
  Future<Usuario?> obtenerUsuario(String usuarioId) async {
    DatabaseReference ref = db.ref().child("usuario").child(usuarioId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> usuarioData = snapshot.value as Map<String, dynamic>;
      Usuario usuario = Usuario.fromJson(usuarioData);
      return usuario;
    }
    return null;
  }

  @override
  Future<Medalla?> obtenerMedalla(String medallaId) async {
    DatabaseReference ref = db.ref().child("medalla").child(medallaId);
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      Map<String, dynamic> medallaData = snapshot.value as Map<String, dynamic>;
      Medalla medalla = Medalla.fromJson(medallaData);
      return medalla;
    }
    return null;
  }
}

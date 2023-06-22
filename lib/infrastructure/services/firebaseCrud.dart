import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/domain/repositories/meta_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseCrud implements MetaRepository {
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

  Future<void> actualizarProyectoDeUsuario(String usuarioId, String proyectoId, Proyecto proyectoActualizado) async {
    DatabaseReference usuarioRef = db.ref().child("usuario").child(usuarioId).child("proyectos").child(proyectoId);

    Map<String, dynamic> proyectoActualizadoMap = proyectoActualizado.toJson();
    await usuarioRef.set(proyectoActualizadoMap);
  }

  Future<void> actualizarMeta(String usuarioId, Meta metaActualizada,String metaID) async {
    DatabaseReference usuarioRef = db.ref().child("usuario").child(usuarioId).child("meta").child(metaID);

    Map<String, dynamic> metaActualizadaMap = metaActualizada.toJson();
    await usuarioRef.set(metaActualizadaMap);
  }

  Future<void> actualizarTarea(String usuarioId, Tarea tarea,String tareaID) async {
    DatabaseReference usuarioRef = db.ref().child("usuario").child(usuarioId).child("tarea").child(tareaID);

    Map<String, dynamic> tareaActualizadaMap = tarea.toJson();
    await usuarioRef.set(tareaActualizadaMap);
  }

  Future<void> actualizarComentario(String usuarioId, Comentario comActualizado,String comentarioId) async {
    DatabaseReference usuarioRef = db.ref().child("usuario").child(usuarioId).child("comentario").child(comentarioId);

    Map<String, dynamic> comentarioActualizadaMap = comActualizado.toJson();
    await usuarioRef.set(comentarioActualizadaMap);
  }


}

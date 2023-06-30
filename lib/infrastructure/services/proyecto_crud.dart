import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuarioLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/domain/exceptions/exceptions.dart';
import 'package:creciendo_con_flutter/domain/repositories/proyecto_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProyectoCrud implements ProyectoRepository {
  FirebaseDatabase db = FirebaseDatabase.instance;

  //Guardar objetos de firebase realtime
  @override
  Future<bool> guardarProyecto(Proyecto proyecto) async {
    try {
      DatabaseReference proyectoRef = db.ref().child("proyecto").push();
      // Obtener el ID del proyecto creado
      String proyectoId = proyectoRef.key!;

      await _actualizarIDsComentariosProyecto(proyectoRef, proyecto);
      await _actualizarIDsMetasProyecto(proyectoRef, proyecto);

      final FirebaseAuth auth = FirebaseAuth.instance;
      final String userId = auth.currentUser!.uid;
      final UsuarioLider userLider = UsuarioLider(usuarioLiderId: userId);
      final ProyectoLider pyLider = ProyectoLider(proyectoLiderId: proyectoId);

      // Actualizar el proyecto con el ID generado
      proyecto.id = proyectoId;
      // Convertir el proyecto actualizado a un mapa
      Map<String, dynamic> proyectoMap = proyecto.toJson();

      // Guardar el proyecto actualizado con las IDs generadas
      await proyectoRef.set(proyectoMap);
      await proyectoRef.child("listUserLideres").push().set(userLider.toJson());

      //Agregar el ID del proyecto a la lista listProyectoLider del usuario
      final DatabaseReference usuarioRef =
          db.ref().child("users").child(userId).child("listProyectoLider");
      await usuarioRef.push().set(pyLider.toJson());

      return true;
    } catch (e) {
      throw ProyectStorageFailed("Error al almacenar proyecto: $e");
    }
  }

  @override
  Future<void> guardarMeta(String proyectoId, Meta meta) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference metaRef = proyectoRef.child("listMeta").push();
      //Obtener el ID generado
      String metaId = metaRef.key!;
      //Asignar el ID a la meta
      meta.id = metaId;
      meta.fechaCreada = DateTime.now();
      await metaRef.set(meta.toJson());
    } catch (e) {
      throw MetaStorageFailed("Error al almacenar meta: $e");
    }
  }

  @override
  Future<void> guardarTarea(
      String proyectoId, String metaId, Tarea tarea) async {
    try {
      DatabaseReference metaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId);
      DatabaseReference tareaRef = metaRef.child("listTarea").push();
      //Obtener el ID generado
      String tareaId = tareaRef.key!;
      //Asignar el ID a la tarea
      tarea.id = tareaId;
      await tareaRef.set(tarea.toJson());
    } catch (e) {
      throw TareaStorageFailed("Error al almacenar tarea: $e");
    }
  }

  @override
  Future<void> guardarComentarioMeta(
      String proyectoId, String metaId, Comentario comentario) async {
    try {
      DatabaseReference metaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId);
      DatabaseReference comentMetaRef =
          metaRef.child("listComentarioMeta").push();
      //Obtener el ID generado
      String comentMetaId = comentMetaRef.key!;
      //Asignar el ID
      comentario.id = comentMetaId;
      await comentMetaRef.set(comentario.toJson());
    } catch (e) {
      throw CommentMetaStorageFailed(
          "Error al almacenar comentario de meta: $e");
    }
  }

  @override
  Future<void> guardarComentarioTarea(String proyectoId, String metaId,
      String tareaId, Comentario comentario) async {
    try {
      DatabaseReference tareaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId)
          .child("listTarea")
          .child(tareaId);
      DatabaseReference comentTareaRef =
          tareaRef.child("listComentarioTarea").push();
      //Obtener el ID generado
      String comentTareaId = comentTareaRef.key!;
      //Asignar el ID
      comentario.id = comentTareaId;
      await comentTareaRef.set(comentario.toJson());
    } catch (e) {
      throw CommentTareaStorageFailed(
          "Error al almacenar comentario de tarea: $e");
    }
  }

  //Eliminar objetos de firebase realtime

  /* Future<void> eliminarProyecto(Proyecto proyecto) async {
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
 */
  //Actualizar objeto dentro de firebase realtime

  /* Future<void> actualizarProyectoDeUsuario(
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
  } */

  /*  @override
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
  } */

  @override
  Future<Proyecto?> obtenerProyecto(String proyectoId) async {
    DatabaseReference ref = db.ref().child("proyecto").child(proyectoId);
    DatabaseEvent databaseEvent = await ref.once();
    if (databaseEvent.snapshot.value != null) {
      Map<dynamic, dynamic> proyectoData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>;
      Proyecto proyecto = Proyecto.fromJson(proyectoData);
      print(proyectoData);
      return proyecto;
    }
    return null;
  }

  @override
  Future<void> guardarComentarioProyecto(
      String proyectoId, Comentario comentario) {
    // TODO: implement guardarComentarioProyecto
    throw UnimplementedError();
  }

  Future<void> _actualizarIDsComentariosProyecto(
      DatabaseReference proyectoRef, Proyecto proyecto) async {
    if (proyecto.listComentarioPy != null) {
      proyecto.listComentarioPy!
          .asMap()
          .forEach((comentarioPyIndex, comentario) {
        final DatabaseReference comentRef =
            proyectoRef.child("listComentarioPy").push();
        final String comentId = comentRef.key!;
        proyecto.listComentarioPy![comentarioPyIndex].id = comentId;
      });
    }
  }

  Future<void> _actualizarIDsMetasProyecto(
      DatabaseReference proyectoRef, Proyecto proyecto) async {
    if (proyecto.listMeta != null) {
      proyecto.listMeta!.asMap().forEach((metaIndex, meta) {
        final DatabaseReference metaRef = proyectoRef.child("listMeta").push();
        final String metaId = metaRef.key!;
        proyecto.listMeta![metaIndex].id = metaId;

        if (meta.listTarea != null) {
          _actualizarIDsTareasMeta(metaRef, proyecto.listMeta![metaIndex]);
        }

        if (meta.listComentarioMeta != null) {
          _actualizarIDsComentariosMeta(metaRef, proyecto.listMeta![metaIndex]);
        }
      });
    }
  }

  void _actualizarIDsTareasMeta(DatabaseReference metaRef, Meta meta) {
    meta.listTarea!.asMap().forEach((tareaIndex, tarea) {
      final DatabaseReference tareaRef = metaRef.child("listTarea").push();
      final String tareaId = tareaRef.key!;
      meta.listTarea![tareaIndex].id = tareaId;

      if (tarea.listComentarioTarea != null) {
        actualizarIDsComentariosTarea(tareaRef, tarea);
      }
    });
  }

  void actualizarIDsComentariosTarea(DatabaseReference tareaRef, Tarea tarea) {
    tarea.listComentarioTarea!.asMap().forEach((comentarioIndex, comentario) {
      final DatabaseReference comentarioRef =
          tareaRef.child("listComentarioTarea").push();
      final String comentarioId = comentarioRef.key!;
      tarea.listComentarioTarea![comentarioIndex].id = comentarioId;
    });
  }

  void _actualizarIDsComentariosMeta(DatabaseReference metaRef, Meta meta) {
    meta.listComentarioMeta!.asMap().forEach((comentarioIndex, comentario) {
      final DatabaseReference comentarioRef =
          metaRef.child("listComentarioMeta").push();
      final String comentarioId = comentarioRef.key!;
      meta.listComentarioMeta![comentarioIndex].id = comentarioId;
    });
  }

  /* @override
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
*/
}

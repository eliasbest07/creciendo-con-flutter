import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuarioLider_entity.dart';
import 'package:creciendo_con_flutter/domain/exceptions/exceptions.dart';
import 'package:creciendo_con_flutter/domain/repositories/proyecto_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProyectoService implements ProyectoRepository {
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
      await _guardarProyecto(proyecto, proyectoRef);
      await _almacenarProyectoUsuario(proyectoRef, userLider, userId, pyLider);

      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<void> _almacenarProyectoUsuario(DatabaseReference proyectoRef,
      UsuarioLider userLider, String userId, ProyectoLider pyLider) async {
    await proyectoRef.child("listUserLideres").push().set(userLider.toJson());

    //Agregar el ID del proyecto a la lista listProyectoLider del usuario
    final DatabaseReference usuarioRef =
        db.ref().child("users").child(userId).child("listProyectoLider");
    await usuarioRef.push().set(pyLider.toJson());
  }

  Future<void> _guardarProyecto(
      Proyecto proyecto, DatabaseReference proyectoRef) async {
    try {
      Map<String, dynamic> proyectoMap = proyecto.toJson();

      // Guardar el proyecto actualizado con las IDs generadas
      await proyectoRef.set(proyectoMap);
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
      tarea.fechaCreada = DateTime.now();
      await tareaRef.set(tarea.toJson());
    } catch (e) {
      throw TareaStorageFailed("Error al almacenar tarea: $e");
    }
  }

  @override
  Future<void> guardarComentarioProyecto(
      String proyectoId, Comentario comentario) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference comentPyRef =
          proyectoRef.child("listComentarioPy").push();
      //Obtener el ID generado
      String comentPyId = comentPyRef.key!;
      await _guardarComentarioPyConId(comentario, comentPyId, comentPyRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioPyConId(Comentario comentario,
      String comentPyId, DatabaseReference comentPyRef) async {
    try {
      comentario.id = comentPyId;
      await comentPyRef.set(comentario.toJson());
    } catch (e) {
      throw CommentPyStorageFailed(
          "Error al almacenar comentario de proyecto: $e");
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
      await _guardarComentarioMetaConId(
          comentario, comentMetaId, comentMetaRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioMetaConId(Comentario comentario,
      String comentMetaId, DatabaseReference comentMetaRef) async {
    try {
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
      await _guardarComentarioTareaConId(
          comentario, comentTareaId, comentTareaRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioTareaConId(Comentario comentario,
      String comentTareaId, DatabaseReference comentTareaRef) async {
    try {
      comentario.id = comentTareaId;
      await comentTareaRef.set(comentario.toJson());
    } catch (e) {
      throw CommentTareaStorageFailed(
          "Error al almacenar comentario de tarea: $e");
    }
  }

  Future<List<Proyecto>> obtenerTodosProyectos() async {
    try {
      DatabaseReference proyectosRef = db.ref().child("proyecto");
      DatabaseEvent databaseEvent = await proyectosRef.once();

      List<Proyecto> proyectos = [];
      Map<dynamic, dynamic>? proyectosData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>?;

      return _cargarProyectos(proyectosData, proyectos);
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  List<Proyecto> _cargarProyectos(
      Map<dynamic, dynamic>? proyectosData, List<Proyecto> proyectos) {
    try {
      if (proyectosData != null) {
        proyectosData.forEach((proyectoId, proyectoData) {
          Proyecto? proyecto = Proyecto.fromJson(proyectoData);
          proyecto.id = proyectoId;
          proyectos.add(proyecto);
        });
      }
      return proyectos;
    } catch (e) {
      throw GetAllProyectsFailed("Error al cargar proyectos: $e");
    }
  }

  @override
  Future<Proyecto?> buscarProyecto(String proyectoId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent = await proyectoRef.once();
      return _procesarProyectoSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<Meta?> buscarMeta(String proyectoId, String metaId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent =
          await proyectoRef.child("listMeta").child(metaId).once();

      return _procesarMetaSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<Tarea?> buscarTarea(
      String proyectoId, String metaId, String tareaId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent = await proyectoRef
          .child("listMeta")
          .child(metaId)
          .child("listTarea")
          .child(tareaId)
          .once();
      return _procesarTareaSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
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

  Meta? _procesarMetaSnapshot(DataSnapshot metaSnapshot) {
    try {
      if (metaSnapshot.value != null) {
        Map<dynamic, dynamic> metaData =
            metaSnapshot.value as Map<dynamic, dynamic>;
        return Meta.fromJson(metaData);
      }
      return null;
    } catch (e) {
      throw MetaSearchFailed("Error al buscar meta: $e");
    }
  }

  Proyecto? _procesarProyectoSnapshot(DataSnapshot proyectoSnapshot) {
    try {
      if (proyectoSnapshot.value != null) {
        Map<dynamic, dynamic> proyectoData =
            proyectoSnapshot.value as Map<dynamic, dynamic>;
        return Proyecto.fromJson(proyectoData);
      }
    } catch (e) {
      throw ProyectSearchFailed("Error al buscar proyecto: $e");
    }

    return null;
  }

  Tarea? _procesarTareaSnapshot(DataSnapshot tareaSnapshot) {
    try {
      if (tareaSnapshot.value != null) {
        Map<dynamic, dynamic> tareaData =
            tareaSnapshot.value as Map<dynamic, dynamic>;
        return Tarea.fromJson(tareaData);
      }
    } catch (e) {
      throw TareaSearchFailed("Error al buscar tarea: $e");
    }
    return null;
  }

  @override
  Future<void> eliminarProyecto(String proyectoId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      await _eliminarProyect(proyectoRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _eliminarProyect(DatabaseReference proyectoRef) async {
    try {
      await proyectoRef.remove();
    } catch (e) {
      throw ProyectDeleteFailed("Error al eliminar proyecto: $e");
    }
  }
}
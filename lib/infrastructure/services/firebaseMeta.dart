import 'package:creciendo_con_flutter/domain/entities/comentario_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/meta_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyecto_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/tarea_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';
import 'package:creciendo_con_flutter/domain/repositories/meta_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseMeta implements MetaRepository {
  FirebaseDatabase db = FirebaseDatabase.instance;

  @override
  Future<void> guardarComentario(Comentario comentario) async {
    await db.ref().child("comentario").push().set(comentario);
  }

  @override
  Future<void> guardarMeta(Meta meta) async {
    await db.ref().child("meta").set(meta);
  }

  @override
  Future<void> guardarProyecto(Proyecto proyecto) async {
    await db.ref().child("proyecto").push().set(proyecto);
  }

  @override
  Future<void> guardarTarea(Tarea tarea) async {
    await db.ref().child("tarea").push().set(tarea);
  }

  @override
  Future<void> guardarUsuario(Usuario usuario) async {
    await db.ref().child("usuario").push().set(usuario);
  }
}

import 'package:creciendo_con_flutter/models/data/dataClass.dart';
import 'package:firebase_database/firebase_database.dart';
class MetaFirebase{

  final DatabaseReference _metaRef = FirebaseDatabase.instance.reference().child('meta');

  void guardarMeta(Meta meta){
    _metaRef.push().set(meta); //meta.toJson()
  }

  void getMeta()=>_metaRef;
 
}

class ProyectoFirebase{

  final DatabaseReference _proyectoRef = FirebaseDatabase.instance.reference().child('proyecto');

  void guardarProyecto(Proyecto proyecto){
    _proyectoRef.push().set(proyecto); //proyecto.toJson()
  }

  void getProyecto()=>_proyectoRef;
}


class TareaFirebase{

  final DatabaseReference _tareaRef = FirebaseDatabase.instance.reference().child('tarea');

  void guardarTarea(Tarea tarea){
    _tareaRef.push().set(tarea); //tarea.toJson()
  }

  void getTarea()=>_tareaRef;
}

class UsuarioFirebase{

  final DatabaseReference _usuarioRef = FirebaseDatabase.instance.reference().child('usuario');

  void guardarUsuario(Usuario usuario){
    _usuarioRef.push().set(usuario); //usuario.toJson()
  }

  void getUsuario()=>_usuarioRef;
}

class ComentarioFirebase{

  final DatabaseReference _comentarioRef = FirebaseDatabase.instance.reference().child('comentario');

  void guardarComentario(Comentario comentario){
    _comentarioRef.push().set(comentario); //usuario.toJson()
  }

  void getComentario()=>_comentarioRef;
}


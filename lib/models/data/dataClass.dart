import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Meta {
  String nombre;
  double porcentaje;
   String item;
   DateTime fechaCreada;
   DateTime fechaEstablecida;
   List<Tarea> listTarea=[];
   List<Comentario> listComentario=[];

  Meta(this.nombre, this.porcentaje, this.item, this.fechaCreada, this.fechaEstablecida, this.listTarea, this.listComentario);
}

class Proyecto {
   String icono;
   String nombre;
   List<Meta> listMeta =[];
   List<Comentario> listComentario=[];
   List<Usuario> listUserLideres=[];

  Proyecto(this.icono, this.nombre, this.listMeta, this.listComentario, this.listUserLideres);

}

class Tarea {
  String nombre;
  String descripcion;
  List<Comentario> listComentario=[];
  User usuarioAsignado;
  DateTime fechaCreada;
  DateTime fechaEstablecida;
  String estado;
  int nivel;

  Tarea(this.nombre, this.descripcion, this.listComentario, this.usuarioAsignado, this.fechaCreada, this.fechaEstablecida, this.estado, this.nivel);

}

class Usuario {
   String nombre;
   String avatar;
   int puntos;
   DateTime fechaIngreso;
   List<Medalla> listMedalla=[];
   List<ProyectoLider> listProyectoLider=[];
   List<ProyectoAuxiliar> listProyectoAuxiliar =[];

   Usuario(this.nombre, this.avatar, this.puntos, this.fechaIngreso, this.listMedalla, this.listProyectoLider, this.listProyectoAuxiliar);
}

class Comentario{
  int id;
   String nombre;
   String descripcion;

   Comentario(this.id, this.nombre, this.descripcion);
}

class Medalla{
   int id;
   String nombre;
   String img;

   Medalla(this.id, this.nombre, this.img);
}

class ProyectoLider{
   int idUser;

   ProyectoLider(this.idUser);
}

class ProyectoAuxiliar{
 int idUser;

 ProyectoAuxiliar(this.idUser);
}
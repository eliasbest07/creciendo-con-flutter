import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';

class Usuario {
  String nombre;
  String avatar;
  int puntos;
  DateTime fechaIngreso;
  List<Medalla> listMedalla = [];
  List<ProyectoLider> listProyectoLider = [];
  List<ProyectoAuxiliar> listProyectoAuxiliar = [];

  Usuario(this.nombre, this.avatar, this.puntos, this.fechaIngreso,
      this.listMedalla, this.listProyectoLider, this.listProyectoAuxiliar);
}

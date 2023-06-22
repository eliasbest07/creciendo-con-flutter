import 'package:creciendo_con_flutter/domain/entities/lider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';

class Usuario {
  String nombre;
  String avatar;
  int puntos;
  DateTime fechaIngreso;
  List<Medalla> listMedalla = [];
  List<Lider> listProyectoLider = [];
  List<ProyectoAuxiliar> listProyectoAuxiliar = [];

  Usuario(this.nombre, this.avatar, this.puntos, this.fechaIngreso,
      this.listMedalla, this.listProyectoLider, this.listProyectoAuxiliar);

        Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'avatar': avatar,
      'puntos': puntos,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'listMedalla': listMedalla.map((medalla) => medalla.toJson()).toList(),
      'listProyectoLider': listProyectoLider.map((lider) => lider.toJson()).toList(),
      'listProyectoAuxiliar': listProyectoAuxiliar.map((auxiliar) => auxiliar.toJson()).toList(),
    };
  }
}

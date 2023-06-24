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

  Usuario({
    required this.nombre,
    required this.avatar,
    required this.puntos,
    required this.fechaIngreso,
    required this.listMedalla,
    required this.listProyectoLider,
    required this.listProyectoAuxiliar,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'avatar': avatar,
      'puntos': puntos,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'listMedalla': listMedalla.map((medalla) => medalla.toJson()).toList(),
      'listProyectoLider':
          listProyectoLider.map((lider) => lider.toJson()).toList(),
      'listProyectoAuxiliar':
          listProyectoAuxiliar.map((auxiliar) => auxiliar.toJson()).toList(),
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        avatar: json["avatar"],
        puntos: json["puntos"],
        fechaIngreso: json["fechaIngreso"],
        listMedalla: json["listMedalla"],
        listProyectoLider: json["listProyectoLider"],
        listProyectoAuxiliar: json["listProyectoAuxiliar"],
      );
}

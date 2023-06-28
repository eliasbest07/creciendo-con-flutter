import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';

class Usuario {
  String? uid;
  String email;
  String nombre;
  String rol;
  String? avatar;
  int? puntos;
  DateTime fechaRegistro;
  List<String>? listMedalla = [];
  List<ProyectoLider>? listProyectoLider = [];
  List<ProyectoAuxiliar>? listProyectoAuxiliar = [];

  Usuario({
    this.uid,
    required this.email,
    required this.nombre,
    required this.rol,
    this.avatar,
    this.puntos,
    required this.fechaRegistro,
    this.listMedalla,
    this.listProyectoLider,
    this.listProyectoAuxiliar,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'rol': rol,
      'avatar': avatar,
      'puntos': puntos,
      'fechaRegistro': fechaRegistro.toIso8601String(),
      'listMedalla': listMedalla,
      'listProyectoLider': listProyectoLider
          ?.map((proyectoLider) => proyectoLider.toJson())
          .toList(),
      'listProyectoAuxiliar': listProyectoAuxiliar
          ?.map((proyectoAuxiliar) => proyectoAuxiliar.toJson())
          .toList(),
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        uid: json["uid"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
        avatar: json["avatar"],
        puntos: json["puntos"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        listMedalla: json["listMedalla"],
        listProyectoLider: json["listProyectoLider"] != null
            ? List<ProyectoLider>.from(json["listProyectoLider"]
                .map((pyLiderJson) => ProyectoLider.fromJson(pyLiderJson)))
            : null,
        listProyectoAuxiliar: json['listProyectoAuxiliar'] != null
            ? List<ProyectoAuxiliar>.from(json["listProyectoAuxiliar"].map(
                (pyAuxiliarJson) => ProyectoAuxiliar.fromJson(pyAuxiliarJson)))
            : null,
      );
}

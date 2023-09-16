import 'package:TaskFlow/domain/entities/medalla/medalla_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/add_user_project.dart';
import 'package:TaskFlow/domain/entities/usuario/proyectoLider_entity.dart';

class Usuario {
  String? uid;
  String email;
  String nombre;
  String rol;
  String avatar;
  int? puntos;
  DateTime fechaRegistro;
  List<Medalla>? listMedalla = [];
  List<ProyectoLider>? listProyectoLider = [];
  List<AddUserProject>? listProyectoAuxiliar = [];

  Usuario(
      {this.uid,
      required this.email,
      required this.nombre,
      required this.rol,
      required this.avatar,
      required this.puntos,
      required this.fechaRegistro,
      this.listMedalla,
      this.listProyectoLider,
      this.listProyectoAuxiliar});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'rol': rol,
      'avatar': avatar,
      'puntos': puntos,
      'fechaRegistro': fechaRegistro.toIso8601String(),
      'listMedalla': listMedalla?.map((medallas) => medallas.toJson()),
      'listProyectoLider': listProyectoLider
          ?.map((proyectoLider) => proyectoLider.toJson())
          .toList(),
      'listProyectoAuxiliar': listProyectoAuxiliar
          ?.map((proyectoAuxiliar) => proyectoAuxiliar.toJson())
          .toList(),
    };
  }

  factory Usuario.fromJson(Map<dynamic, dynamic> json) => Usuario(
        uid: json["uid"],
        email: json["email"],
        nombre: json["nombre"],
        rol: json["rol"],
        avatar: json["avatar"],
        puntos: json["puntos"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        listMedalla: json["listMedalla"] != null
            ? (json['listMedalla'] as Map<dynamic, dynamic>)
                .values
                .map((listMedallaJson) => Medalla.fromJson(listMedallaJson))
                .toList()
            : null,
        listProyectoLider: json["listProyectoLider"] != null
            ? (json['listProyectoLider'] as Map<dynamic, dynamic>)
                .values
                .map((listProyectoLiderJson) =>
                    ProyectoLider.fromJson(listProyectoLiderJson))
                .toList()
            : null,
        listProyectoAuxiliar: json["listProyectoAuxiliar"] != null
            ? (json['listProyectoAuxiliar'] as Map<dynamic, dynamic>)
                .values
                .map((listProyectoAuxiliarJson) =>
                    AddUserProject.fromJson(listProyectoAuxiliarJson))
                .toList()
            : null,
      );

  bool tieneSuficientesPuntos() {
    return puntos != null && puntos! >= 100;
  }
}

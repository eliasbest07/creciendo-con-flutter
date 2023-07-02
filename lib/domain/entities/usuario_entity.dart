import 'package:TaskFlow/domain/entities/medalla_entity.dart';
import 'package:TaskFlow/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:TaskFlow/domain/entities/proyectoUser_entity.dart';

class Usuario {
  String? uid;
  String email;
  String nombre;
  String rol;
  String? avatar;
  int? puntos;
  DateTime fechaRegistro;
  List<String>? listMedalla = [];
  List<ProyectoUser>? listProyectos = [];

  Usuario(
      {this.uid,
      required this.email,
      required this.nombre,
      required this.rol,
      this.avatar,
      this.puntos,
      required this.fechaRegistro,
      this.listMedalla,
      this.listProyectos});

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
      'listProyectos': listProyectos
          ?.map((proyectosUser) => proyectosUser.toJson())
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
        listMedalla: json["listMedalla"],
        listProyectos: json["listProyectos"] != null
            ? (json['listProyectos'] as Map<dynamic, dynamic>)
                .values
                .map((listProyectosJson) =>
                    ProyectoUser.fromJson(listProyectosJson))
                .toList()
            : null,
      );

  bool tieneSuficientesPuntos() {
    return puntos != null && puntos! >= 100;
  }
}

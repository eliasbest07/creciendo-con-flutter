import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

class Lider extends Usuario {
  String categoria;

  Lider(
      {required String nombre,
      required String avatar,
      required int puntos,
      required DateTime fechaIngreso,
      required List<Medalla> listMedalla,
      required List<Lider> listProyectoLider,
      required List<ProyectoAuxiliar> listProyectoAuxiliar,
      required this.categoria})
      : super(
          nombre: nombre,
          avatar: avatar,
          puntos: puntos,
          fechaIngreso: fechaIngreso,
          listMedalla: listMedalla,
          listProyectoLider: listProyectoLider,
          listProyectoAuxiliar: listProyectoAuxiliar,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Invocar al método toJson() de la clase padre
    json['categoria'] = categoria;
    return json;
  }

  factory Lider.fromJson(Map<String, dynamic> json) {
    return Lider(
      nombre: json['nombre'],
      avatar: json['avatar'],
      puntos: json['puntos'],
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      listMedalla: List<Medalla>.from(
        json['listMedalla'].map((medallaJson) => Medalla.fromJson(medallaJson)),
      ),
      listProyectoLider: List<Lider>.from(
        json['listProyectoLider'].map((liderJson) => Lider.fromJson(liderJson)),
      ),
      listProyectoAuxiliar: List<ProyectoAuxiliar>.from(
        json['listProyectoAuxiliar']
            .map((proyectoJson) => ProyectoAuxiliar.fromJson(proyectoJson)),
      ),
      categoria: json['categoria'],
    );
  }
}

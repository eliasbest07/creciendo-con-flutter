import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

class Lider extends Usuario {
  String categoria;

  Lider(String nombre, String avatar, int puntos, DateTime fechaIngreso,
      List<Medalla> listMedalla, List<Lider> listProyectoLider,
      List<ProyectoAuxiliar> listProyectoAuxiliar, this.categoria)
      : super(nombre, avatar, puntos, fechaIngreso, listMedalla, listProyectoLider, listProyectoAuxiliar);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson(); // Invocar al método toJson() de la clase padre
    json['categoria'] = categoria;
    return json;
  }
}

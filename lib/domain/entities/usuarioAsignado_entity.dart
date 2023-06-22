import 'package:creciendo_con_flutter/domain/entities/lider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/medalla_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoAuxiliar_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/proyectoLider_entity.dart';
import 'package:creciendo_con_flutter/domain/entities/usuario_entity.dart';

class UsuarioAsignado extends Usuario {
  UsuarioAsignado(
    String nombre,
    String avatar,
    int puntos,
    DateTime fechaIngreso,
    List<Medalla> listMedalla,
    List<Lider> listProyectoLider,
    List<ProyectoAuxiliar> listProyectoAuxiliar,
  ) : super(
          nombre,
          avatar,
          puntos,
          fechaIngreso,
          listMedalla,
          listProyectoLider,
          listProyectoAuxiliar,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson(); // Invocar al método toJson() de la clase padre
    // Agregar propiedades adicionales específicas de UsuarioAsignado al mapa JSON
    // ...

    return json;
  }
}

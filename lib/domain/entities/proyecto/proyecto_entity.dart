import 'package:TaskFlow/domain/entities/proyecto/comentario_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/usuarioProyecto_entity.dart';

class Proyecto {
  String? id;
  String icon;
  String nombre;
  List<Meta>? listMeta;
  List<Comentario>? listComentarioPy;
  List<UsuariosProyecto>? listUserProyecto;
  DateTime? fechaInicio;
  DateTime? fechaEstablecida;

  Proyecto(
      {this.id,
      required this.icon,
      required this.nombre,
      this.listMeta,
      this.fechaInicio,
      this.fechaEstablecida,
      this.listComentarioPy,
      this.listUserProyecto});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'nombre': nombre,
      'listMeta': listMeta?.map((meta) => meta.toJson()).toList(),
      'listComentarioPy':
          listComentarioPy?.map((comentario) => comentario.toJson()).toList(),
      'listUserProyecto':
          listUserProyecto?.map((lideres) => lideres.toJson()).toList(),
    };
  }

  factory Proyecto.fromJson(Map<dynamic, dynamic> json) => Proyecto(
        id: json["id"],
        icon: json["icon"],
        nombre: json["nombre"],
        fechaInicio: json["fechaInicio"] != null
            ? DateTime.parse(json["fechaInicio"])
            : null,
            fechaEstablecida: json["fechaEstablecida"] != null ? DateTime.parse(json["fechaEstablecida"]) : null,
        listMeta: json["listMeta"] != null
            ? (json['listMeta'] as Map<dynamic, dynamic>)
                .values
                .map((metaJson) => Meta.fromJson(metaJson))
                .toList()
            : null,
        listComentarioPy: json["listComentarioPy"] != null
            ? (json['listComentarioPy'] as Map<dynamic, dynamic>)
                .values
                .map((comentPyJson) => Comentario.fromJson(comentPyJson))
                .toList()
            : null,
        listUserProyecto: json["listUserProyecto"] != null
            ? (json['listUserProyecto'] as Map<dynamic, dynamic>)
                .values
                .map((listUserProyectoJson) =>
                    UsuariosProyecto.fromJson(listUserProyectoJson))
                .toList()
            : null,
      );
}

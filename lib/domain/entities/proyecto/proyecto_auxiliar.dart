class ListProyectoAuxiliar{
  String? creadoPor;
  String? estado;
  String? icono;
  String? nombreProyecto;
  String? proyectoId;

    ListProyectoAuxiliar({
    required this.creadoPor,
    required this.estado,
    required this.icono,
    required this.nombreProyecto,
    required this.proyectoId
  });

    ListProyectoAuxiliar copyWith({
      String? creadoPor,
      String? estado,
      String? icono,
      String? nombreProyecto,
      String? proyectoId,
  }) =>
      ListProyectoAuxiliar(
        creadoPor: creadoPor ?? this.creadoPor,
        estado: estado ?? this.estado,
        icono: icono ?? this.icono,
        nombreProyecto: nombreProyecto ?? this.nombreProyecto,
        proyectoId: proyectoId ?? this.proyectoId,
      );

  factory ListProyectoAuxiliar.fromJson(Map<dynamic, dynamic> json) =>
      ListProyectoAuxiliar(
        creadoPor: json["creadoPor"],
        estado: json["estado"],
        icono: json["icono"],
        nombreProyecto: json["nombreProyecto"],
        proyectoId: json["proyectoId"],
      );

  Map<dynamic, dynamic> toJson() => {
        "creadoPor": creadoPor,
        "estado": estado,
        "icono": icono,
        "nombreProyecto": nombreProyecto,
        "proyectoId": proyectoId,
      };

}
class ProyectoAuxiliar {
  String proyectoAuxiliarId;

  ProyectoAuxiliar({
    required this.proyectoAuxiliarId,
  });

  ProyectoAuxiliar copyWith({
    String? proyectoAuxiliarId,
  }) =>
      ProyectoAuxiliar(
        proyectoAuxiliarId: proyectoAuxiliarId ?? this.proyectoAuxiliarId,
      );

  factory ProyectoAuxiliar.fromJson(Map<String, dynamic> json) =>
      ProyectoAuxiliar(
        proyectoAuxiliarId: json["proyectoAuxiliarId"],
      );

  Map<String, dynamic> toJson() => {
        "proyectoAuxiliarId": proyectoAuxiliarId,
      };
}

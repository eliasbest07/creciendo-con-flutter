class ProyectoAuxliliar {
  String proyectoAuxiliarId;

  ProyectoAuxliliar({
    required this.proyectoAuxiliarId,
  });

  ProyectoAuxliliar copyWith({
    String? proyectoAuxiliarId,
  }) =>
      ProyectoAuxliliar(
        proyectoAuxiliarId: proyectoAuxiliarId ?? this.proyectoAuxiliarId,
      );

  factory ProyectoAuxliliar.fromJson(Map<dynamic, dynamic> json) =>
      ProyectoAuxliliar(
        proyectoAuxiliarId: json["proyectoAuxiliarId"],
      );

  Map<String, dynamic> toJson() => {
        "proyectoAuxiliarId": proyectoAuxiliarId,
      };
}

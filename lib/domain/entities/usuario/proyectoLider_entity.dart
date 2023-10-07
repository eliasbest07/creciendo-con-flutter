class ProyectoLider {
  String proyectoLiderId;

  ProyectoLider({
    required this.proyectoLiderId,
  });

  ProyectoLider copyWith({
    String? proyectoLiderId,
  }) =>
      ProyectoLider(
        proyectoLiderId: proyectoLiderId ?? this.proyectoLiderId,
      );

  factory ProyectoLider.fromJson(Map<dynamic, dynamic> json) => ProyectoLider(
        //proyectoLiderId: json["proyectoLiderId"],
        proyectoLiderId: json["proyectoId"],
      );

  Map<String, dynamic> toJson() => {
        "proyectoLiderId": proyectoLiderId,
      };
}

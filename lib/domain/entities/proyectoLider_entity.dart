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

  factory ProyectoLider.fromJson(Map<String, dynamic> json) => ProyectoLider(
        proyectoLiderId: json["proyectoLiderId"],
      );

  Map<String, dynamic> toJson() => {
        "proyectoLiderId": proyectoLiderId,
      };
}

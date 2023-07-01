class ProyectoUser {
  String proyectoUserId;

  ProyectoUser({
    required this.proyectoUserId,
  });

  ProyectoUser copyWith({
    String? proyectoUserId,
  }) =>
      ProyectoUser(
        proyectoUserId: proyectoUserId ?? this.proyectoUserId,
      );

  factory ProyectoUser.fromJson(Map<String, dynamic> json) => ProyectoUser(
        proyectoUserId: json["proyectoUserId"],
      );

  Map<String, dynamic> toJson() => {
        "proyectoUserId": proyectoUserId,
      };
}

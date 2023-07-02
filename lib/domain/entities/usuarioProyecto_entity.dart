class UsuariosProyecto {
  String usuarioId;
  String rol;

  UsuariosProyecto({
    required this.usuarioId,
    required this.rol,
  });

  UsuariosProyecto copyWith({
    String? usuarioId,
    String? rol,
  }) =>
      UsuariosProyecto(
        usuarioId: usuarioId ?? this.usuarioId,
        rol: rol ?? this.rol,
      );

  factory UsuariosProyecto.fromJson(Map<dynamic, dynamic> json) =>
      UsuariosProyecto(
        usuarioId: json["usuarioId"],
        rol: json["rol"],
      );

  Map<dynamic, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "rol": rol,
      };
}

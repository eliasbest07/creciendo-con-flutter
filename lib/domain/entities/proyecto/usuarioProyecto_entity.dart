class UsuariosProyecto {
  String usuarioId;
  String rol;
  String nombre;

  UsuariosProyecto({
    required this.usuarioId,
    required this.rol,
      required this.nombre
  });

  UsuariosProyecto copyWith({
    String? usuarioId,
    String? rol,
    String? nombre
  }) =>
      UsuariosProyecto(
        usuarioId: usuarioId ?? this.usuarioId,
        rol: rol ?? this.rol,
        nombre: nombre ?? this.nombre,
      );

  factory UsuariosProyecto.fromJson(Map<dynamic, dynamic> json) =>
      UsuariosProyecto(
        usuarioId: json["usuarioId"],
        rol: json["rol"],
        nombre: json["nombre"]
      );

  Map<dynamic, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "rol": rol,
        "nombre": nombre
      };
}

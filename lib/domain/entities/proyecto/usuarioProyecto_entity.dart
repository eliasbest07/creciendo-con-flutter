class UsuariosProyecto {
  String usuarioId;
  String rol;
  String nombre;
  String avatar;

  UsuariosProyecto({
    required this.usuarioId,
    required this.rol,
    required this.nombre,
    required this.avatar,
  });

  UsuariosProyecto copyWith({
    String? usuarioId,
    String? rol,
    String? nombre,
    String? avatar,
  }) =>
      UsuariosProyecto(
        usuarioId: usuarioId ?? this.usuarioId,
        rol: rol ?? this.rol,
        nombre: nombre ?? this.nombre,
        avatar: avatar ?? this.avatar,
      );

  factory UsuariosProyecto.fromJson(Map<dynamic, dynamic> json) =>
      UsuariosProyecto(
        usuarioId: json["usuarioId"],
        rol: json["rol"],
        nombre: json["nombre"],
        avatar: json["avatar"],
      );

  Map<dynamic, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "rol": rol,
        "nombre": nombre,
        "avatar": avatar,
      };
}

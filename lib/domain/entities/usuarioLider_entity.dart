class UsuarioLider {
  String usuarioLiderId;

  UsuarioLider({
    required this.usuarioLiderId,
  });

  UsuarioLider copyWith({
    String? usuarioLiderId,
  }) =>
      UsuarioLider(
        usuarioLiderId: usuarioLiderId ?? this.usuarioLiderId,
      );

  factory UsuarioLider.fromJson(Map<dynamic, dynamic> json) => UsuarioLider(
        usuarioLiderId: json["usuarioLiderId"],
      );

  Map<String, dynamic> toJson() => {
        "usuarioLiderId": usuarioLiderId,
      };
}

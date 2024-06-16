class Comentario {
  String? id;
  String nombreUsuario;
  String imagenUsuario;
  String contenido;

  Comentario({this.id, required this.imagenUsuario, required this.nombreUsuario, required this.contenido});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreUsuario': nombreUsuario,
      'contenido': contenido,
      'imagenUsuario':imagenUsuario
    };
  }

  factory Comentario.fromJson(Map<dynamic, dynamic> json) {
    return Comentario(
      id: json['id'],
      nombreUsuario: json['nombreUsuario'],
      imagenUsuario: json['imagenUsuario'],
      contenido: json['contenido'],
    );
  }
}

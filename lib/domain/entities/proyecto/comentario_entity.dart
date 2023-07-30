class Comentario {
  String? id;
  String nombre;
  String descripcion;

  Comentario({this.id, required this.nombre, required this.descripcion});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory Comentario.fromJson(Map<dynamic, dynamic> json) {
    return Comentario(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}

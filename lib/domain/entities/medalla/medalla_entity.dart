class Medalla {
  String? id;
  String nombre;
  String img;

  Medalla({
    this.id,
    required this.nombre,
    required this.img,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'img': img,
    };
  }

  factory Medalla.fromJson(Map<String, dynamic> json) => Medalla(
        id: json["id"],
        nombre: json["nombre"],
        img: json["img"],
      );
}

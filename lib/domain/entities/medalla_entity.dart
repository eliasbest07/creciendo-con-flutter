class Medalla {
  int id;
  String nombre;
  String img;

  Medalla(this.id, this.nombre, this.img);

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'img': img,
    };
  }
}

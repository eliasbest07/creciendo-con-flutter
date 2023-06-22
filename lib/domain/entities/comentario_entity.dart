class Comentario {
 int id;
 String nombre;
 String descripcion;

 Comentario(this.id, this.nombre, this.descripcion);

 Map<String, dynamic> toJson() {
 return {
 'id': id,
 'nombre': nombre,
 'descripcion': descripcion, };
 }
}

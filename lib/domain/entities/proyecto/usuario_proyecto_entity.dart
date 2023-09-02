class UsuarioProyecto{
  String nombre='';
  String creadopor='';
  String estado='';
  String icono='';
  String proyectoId='';

  
  UsuarioProyecto({
    required this.nombre,
    required this.creadopor,
    required this.estado,
    required this.icono,
    required this.proyectoId
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'creadopor': creadopor,
      'estado': estado,
      'icono': icono,
      'proyectoId': proyectoId,      
    };
  }

  factory UsuarioProyecto.fromJson(Map<dynamic, dynamic> json) {
    return UsuarioProyecto(
      nombre: json['nombre'],
      creadopor: json['creadopor'],
      estado: json['estado'],
      icono: json['icono'],
      proyectoId: json['proyectoId'],      
    );
  }
}
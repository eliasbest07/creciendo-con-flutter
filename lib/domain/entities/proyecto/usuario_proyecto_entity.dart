class ProyectoByRol{
  String nombre='';
  String creadopor='';
  String estado='';
  String icono='';
  String proyectoId='';

  
  ProyectoByRol({
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

  factory ProyectoByRol.fromJson(Map<dynamic, dynamic> json) {
    return ProyectoByRol(
      nombre: json['nombreProyecto'],
      creadopor: json['creadoPor'],
      estado: json['estado'],
      icono: json['icono'],
      proyectoId: json['proyectoId'],      
    );
  }
}
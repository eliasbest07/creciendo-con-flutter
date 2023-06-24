class ProyectoLider {
  int idUser;

  ProyectoLider({required this.idUser});
  factory ProyectoLider.fromJson(Map<String, dynamic> json) {
    return ProyectoLider(
      idUser: json['idUser'],
    );
  }
}

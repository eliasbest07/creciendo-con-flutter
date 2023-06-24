class ProyectoAuxiliar {
  int idUser;

  ProyectoAuxiliar({required this.idUser});

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
    };
  }

  factory ProyectoAuxiliar.fromJson(Map<String, dynamic> json) {
    return ProyectoAuxiliar(
      idUser: json['idUser'],
    );
  }
}

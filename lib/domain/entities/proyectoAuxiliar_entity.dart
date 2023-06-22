class ProyectoAuxiliar {
  int idUser;

  ProyectoAuxiliar(this.idUser);

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
    };
  }
}

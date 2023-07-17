import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetasController extends StateNotifier<Map<String, List<Meta>>> {
  // Lista de metas del id del proyecto
  TextEditingController nameGoal = TextEditingController();
  String type = '';
  String proyectoActual = '';

  MetasController(super.state);

  // MetasController() super() {
  // state= ['proyectoID'][];
  // }
  void addProyecto(String proyectoID) {
    proyectoActual = proyectoID;
    //state = {proyectoID: []};
    print(state);
  }

  void setType(String typeIn) {
    print(typeIn);
    Meta porDefinir =
        Meta(nombre: '', item: 'item', fechaEstablecida: DateTime.timestamp());
    porDefinir.item = typeIn;
    type = typeIn;
     state = {
      proyectoActual: [porDefinir]
      };
    
  }
}

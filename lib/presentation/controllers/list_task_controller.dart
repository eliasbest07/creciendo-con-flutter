import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto/tarea_entity.dart';

class TaskController extends StateNotifier<Map<String, List<Tarea>>> {
  // Lista de metas del id del proyecto

  DateTime? fechaCreada;
  DateTime? fechaEstablecida;
  String type = '';
  String metaActual = '';
  int prioridad = 0;

  TaskController(super.state);

  // MetasController() super() {
  // state= ['proyectoID'][];
  // }
  void addMeta(String metaID) {
    metaActual = metaID;
    //state = {proyectoID: []};
    print(state);
  }

  void setType(String typeIn) {
    print(typeIn);
    Tarea porDefinir = Tarea(
        nombre: '',
        descripcion: '',
        fechaEstablecida: DateTime.timestamp(),
        estado: '',
        prioridad: prioridad);
    state = {
      metaActual: [porDefinir]
    };
  }
}

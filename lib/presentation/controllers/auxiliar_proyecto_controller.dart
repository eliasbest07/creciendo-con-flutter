import 'package:TaskFlow/domain/entities/proyecto/usuario_proyecto_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProyectoAuxiliar extends StateNotifier<List<ProyectoByRol>>{
  // ProyectoProvider(super.state);
  ProyectoAuxiliar() : super([]);

  bool roleIsLider=false;
  
  
}

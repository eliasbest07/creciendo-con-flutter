import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/proyecto/meta_entity.dart';

class EditGoalController extends StateNotifier<Meta> {
  EditGoalController() : super(Meta(nombre: 'nombre', item: 'item', fechaEstablecida: DateTime.timestamp()));
  
  TextEditingController nameGoal = TextEditingController();
  TextEditingController fechaCreadaController = TextEditingController();
  TextEditingController fechaEstimadaController = TextEditingController();
  
}

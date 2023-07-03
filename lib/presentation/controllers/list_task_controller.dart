import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/proyecto/tarea_entity.dart';

class ListTaskController extends StateNotifier<List<Tarea>> {
  ListTaskController(super.state);
}

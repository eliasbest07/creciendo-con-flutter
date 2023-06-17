import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto_entity.dart';

class ProyectoProvider extends StateNotifier<List<Proyecto>> {
  // ProyectoProvider(super.state);
  ProyectoProvider() : super([]);

  void init() {
    state = List<Proyecto>.empty();

    //state = [...state, Proyecto()]; // correcto --> se redibuja el widget

    //state.add(Proyecto()); // funciona pero no redibuja el widget
  }
}

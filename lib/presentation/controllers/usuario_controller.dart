
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/services/usuario_service.dart';

class UsuarioController extends StateNotifier<int> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UsuarioController(super.state){
    init();
  }

  void init()async{
    state = await UsuarioService().obtenerPuntos().first;
  }
}
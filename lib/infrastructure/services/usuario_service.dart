import 'package:TaskFlow/domain/repositories/usuario_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/exceptions/exceptions.dart';

class UsuarioService implements UsuarioRepository {
  FirebaseDatabase db = FirebaseDatabase.instance;
  @override
  Future<void> gastarPuntos(String userId, int cantidad) async {
    final DatabaseReference usuarioRef = db.ref().child("users").child(userId);

    DatabaseEvent databaseEvent = await usuarioRef.child("puntos").once();
    int puntosActuales = (databaseEvent.snapshot.value as int?) ?? 0;

    if (puntosActuales >= cantidad) {
      int puntosRestantes = puntosActuales - cantidad;
      await usuarioRef.child("puntos").set(puntosRestantes);
    } else {
      throw InsufficientPointsException(
          "El usuario no tiene suficientes puntos.");
    }
  }
}

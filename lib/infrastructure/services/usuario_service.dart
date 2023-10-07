import 'package:TaskFlow/domain/entities/proyecto/usuarioProyecto_entity.dart';
import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/domain/repositories/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/exceptions/exceptions.dart';

class UsuarioService implements UsuarioRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
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

    
  Future<void> eliminarTarea({String? userId, String? tareaID}) async {

    try {
      final DatabaseReference tareaRef = db.ref().child("users").child(userId!).child('listaTareas').child(tareaID!);      
      await tareaRef.remove();  

      print('tarea: $tareaID');

      Fluttertoast.showToast(
        msg: 'Tarea eliminada', // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM, // location
      );    

      //pendiente: si el eliminado es exitoso, se debe restaurar el boton de "asignarme esta tarea"
    } catch (e) {
      print('error al eliminar la tarea '+e.toString());
      Fluttertoast.showToast(
        msg: 'error al eliminar tarea ', // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM, // location
      );    
    }

  }

 
  @override
  Future<bool> verificarPuntosSuficientes() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;
    Usuario usuario = await obtenerUsuarioActual(userId);
    return usuario.tieneSuficientesPuntos();
  }
  // void _eliminarProyect(){

  // }

  Future<Usuario> obtenerUsuarioActual(String userId) async {
    try {
      final DatabaseReference usuarioRef =
          db.ref().child("users").child(userId);
      DatabaseEvent databaseEvent = await usuarioRef.once();
      Map<dynamic, dynamic> userData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>;
      return Usuario.fromJson(userData);
    } catch (e) {
      throw GetUserFailed("Error al obtener el usuario actual: $e");
    }
  }

  Future<Usuario> obtenerUsuario() async {
    // try {
    final DatabaseReference usuarioRef =
        db.ref().child("users").child(auth.currentUser!.uid);
    DatabaseEvent databaseEvent = await usuarioRef.once();
    Map<dynamic, dynamic> userData =
        databaseEvent.snapshot.value as Map<dynamic, dynamic>;

    final modelUsuer = Usuario.fromJson(userData);
    print(modelUsuer);
    return modelUsuer;
    // } catch (e) {
    // throw GetUserFailed("Error al obtener el usuario actual: $e");
    // }
  }

//obtiene lista de todos los usuarios, por ejemlo: auxiliares
  Stream<List<Usuario>> obtenerUsuarios() {
    final DatabaseReference usuariosRef = db.ref().child("users");

    return usuariosRef.onValue.asyncExpand((event) async* {
      final data = event.snapshot.value as Map<dynamic, dynamic>;

      List<Usuario> usuarios = [];
      data.forEach((key, value) {
        usuarios.add(Usuario.fromJson(value));
      });

      yield usuarios;
    });
  }

  //Obtener usuarios del proyecto con ID
  Stream<List<UsuariosProyecto>> obtenerUsuariosProyecto(String id) {
    final DatabaseReference usuariosRef =
        db.ref().child("proyecto").child(id).child('listUserProyecto');

    return usuariosRef.onValue.asyncExpand((event) async* {
      final data = event.snapshot.value as Map<dynamic, dynamic>;

      List<UsuariosProyecto> usuarios = [];
      data.forEach((key, value) {
        usuarios.add(UsuariosProyecto.fromJson(value));
      });

      yield usuarios;
    });
  }

  @override
  Stream<int> obtenerPuntos() async* {
    yield* db // return
        .ref()
        .child("users")
        .child(auth.currentUser!.uid)
        .child('puntos')
        .onValue
        .map((event) {
      final puntos = event.snapshot.value as int;
      //TODO: pasar a riverdpod la variable puntos con el fin de poder operarlos y retornar de nuevo a firebase
      return puntos;
    });
  }
}

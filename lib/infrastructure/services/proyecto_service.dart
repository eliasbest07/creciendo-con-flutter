import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/usuario_proyecto_entity.dart';
import 'package:TaskFlow/domain/entities/usuario/proyectoAuxiliar_entity.dart';
import 'package:TaskFlow/domain/entities/usuario/proyectoLider_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/proyecto_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/usuarioProyecto_entity.dart';
import 'package:TaskFlow/domain/exceptions/exceptions.dart';
import 'package:TaskFlow/domain/repositories/proyecto_repository.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/proyecto/comentario_entity.dart';
import '../../domain/entities/usuario/usuario_entity.dart';

class ProyectoService implements ProyectoRepository {
  FirebaseDatabase db = FirebaseDatabase.instance;

  //Guardar objetos de firebase realtime
  @override
  Future<bool> guardarProyecto(Proyecto proyecto) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final String userId = auth.currentUser!.uid;
      // ignore: unused_local_variable
      bool puntos = false;
      Usuario usuario = await obtenerUsuarioActual(userId);

      puntos = _verificarPuntosSuficientes(usuario);
      if (puntos = true) {
        await UsuarioService().gastarPuntos(userId, 100);

        DatabaseReference proyectoRef = db.ref().child("proyecto").push();
        // Obtener el ID del proyecto creado
        String proyectoId = proyectoRef.key!;

        await _actualizarIDsComentariosProyecto(proyectoRef, proyecto);
        await _actualizarIDsMetasProyecto(proyectoRef, proyecto);

        final UsuariosProyecto userPy = UsuariosProyecto(
            usuarioId: userId, rol: "Lider", nombre: userId, avatar: '');
        final ProyectoLider pyLider =
            ProyectoLider(proyectoLiderId: proyectoId);

        // Actualizar el proyecto con el ID generado
        proyecto.id = proyectoId;
        await _guardarProyecto(proyecto, proyectoRef);
        await _almacenarProyectoUsuario(proyectoRef, userPy, userId, pyLider);

        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<Usuario> obtenerUsuarioActual(String userId) async {
    final DatabaseReference usuarioRef = db.ref().child("users").child(userId);
    DatabaseEvent databaseEvent = await usuarioRef.once();
    Map<dynamic, dynamic> userData =
        databaseEvent.snapshot.value as Map<dynamic, dynamic>;
    return Usuario.fromJson(userData);
  }

  bool _verificarPuntosSuficientes(Usuario usuario) {
    if (usuario.tieneSuficientesPuntos()) {
      return true;
    } else {
      throw InsufficientPointsException(
          "El usuario no tiene los puntos suficientos para crear un proyecto");
    }
  }

  Future<void> _almacenarProyectoUsuario(
      DatabaseReference proyectoRef,
      UsuariosProyecto usuariosProyecto,
      String userId,
      ProyectoLider pyLider) async {
    await proyectoRef
        .child("listUserProyecto")
        .push()
        .set(usuariosProyecto.toJson());

    //Agregar el ID del proyecto a la lista listProyectos del usuario
    final DatabaseReference usuarioRef =
        db.ref().child("users").child(userId).child("listProyecto");
    await usuarioRef.push().set(pyLider.toJson());
  }

  Future<void> _guardarProyecto(
      Proyecto proyecto, DatabaseReference proyectoRef) async {
    try {
      Map<String, dynamic> proyectoMap = proyecto.toJson();

      // Guardar el proyecto actualizado con las IDs generadas
      await proyectoRef.set(proyectoMap);
    } catch (e) {
      throw ProyectStorageFailed("Error al almacenar proyecto: $e");
    }
  }

  @override
  Future<void> guardarMeta(String proyectoId, Meta meta) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference metaRef = proyectoRef.child("listMeta").push();
      //Obtener el ID generado
      String metaId = metaRef.key!;
      //Asignar el ID a la meta
      meta.id = metaId;
      meta.fechaCreada = DateTime.now();
      await metaRef.set(meta.toJson());
    } catch (e) {
      throw MetaStorageFailed("Error al almacenar meta: $e");
    }
  }

  @override
  Future<void> asignarTarea({ required proyectoId,required String  metaId,required String tareaID,required String userId}) async{
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference metaRef = proyectoRef.child("listMeta").child(metaId).child('listTarea').child(tareaID);
      metaRef.child('usuarioAsignado').set(userId);
    } catch (e) {
      throw MetaStorageFailed("Error al asignar usuario a la tarea: $e");
    }
  }

  @override
  Future<void> actualizarTarea(
      String proyectoId, String metaId, Tarea tarea) async {
    try {
      DatabaseReference metaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId);
      DatabaseReference tareaRef = metaRef.child("listTarea").child(tarea.id!);

      await tareaRef.set(tarea.toJson());
    } catch (e) {
      throw TareaStorageFailed("Error al almacenar tarea: $e");
    }
  }

  @override
  Future<void> guardarTarea(
      String proyectoId, String metaId, Tarea tarea) async {
    try {
      DatabaseReference metaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId);
      DatabaseReference tareaRef = metaRef.child("listTarea").push();
      //Obtener el ID generado
      String tareaId = tareaRef.key!;
      //Asignar el ID a la tarea
      tarea.id = tareaId;
      tarea.fechaCreada = DateTime.now();
      await tareaRef.set(tarea.toJson());
    } catch (e) {
      throw TareaStorageFailed("Error al almacenar tarea: $e");
    }
  }

  @override
  Future<void> guardarComentarioProyecto(
      String proyectoId, Comentario comentario) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference comentPyRef =
          proyectoRef.child("listComentarioPy").push();
      //Obtener el ID generado
      String comentPyId = comentPyRef.key!;
      await _guardarComentarioPyConId(comentario, comentPyId, comentPyRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioPyConId(Comentario comentario,
      String comentPyId, DatabaseReference comentPyRef) async {
    try {
      comentario.id = comentPyId;
      await comentPyRef.set(comentario.toJson());
    } catch (e) {
      throw CommentPyStorageFailed(
          "Error al almacenar comentario de proyecto: $e");
    }
  }

  @override
  Future<void> guardarComentarioMeta(
      String proyectoId, String metaId, Comentario comentario) async {
    try {
      DatabaseReference metaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId);
      DatabaseReference comentMetaRef =
          metaRef.child("listComentarioMeta").push();
      //Obtener el ID generado
      String comentMetaId = comentMetaRef.key!;
      await _guardarComentarioMetaConId(
          comentario, comentMetaId, comentMetaRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioMetaConId(Comentario comentario,
      String comentMetaId, DatabaseReference comentMetaRef) async {
    try {
      comentario.id = comentMetaId;
      await comentMetaRef.set(comentario.toJson());
    } catch (e) {
      throw CommentMetaStorageFailed(
          "Error al almacenar comentario de meta: $e");
    }
  }

  @override
  Future<void> guardarComentarioTarea(String proyectoId, String metaId,
      String tareaId, Comentario comentario) async {
    try {
      DatabaseReference tareaRef = db
          .ref()
          .child("proyecto")
          .child(proyectoId)
          .child("listMeta")
          .child(metaId)
          .child("listTarea")
          .child(tareaId);
      DatabaseReference comentTareaRef =
          tareaRef.child("listComentarioTarea").push();
      //Obtener el ID generado
      String comentTareaId = comentTareaRef.key!;
      await _guardarComentarioTareaConId(
          comentario, comentTareaId, comentTareaRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _guardarComentarioTareaConId(Comentario comentario,
      String comentTareaId, DatabaseReference comentTareaRef) async {
    try {
      comentario.id = comentTareaId;
      await comentTareaRef.set(comentario.toJson());
    } catch (e) {
      throw CommentTareaStorageFailed(
          "Error al almacenar comentario de tarea: $e");
    }
  }

  @override
  Future<List<Proyecto>> obtenerTodosProyectos() async {
    try {
      DatabaseReference proyectosRef = db.ref().child("proyecto");
      DatabaseEvent databaseEvent = await proyectosRef.once();

      List<Proyecto> proyectos = [];
      Map<dynamic, dynamic>? proyectosData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>?;

      return _cargarProyectos(proyectosData, proyectos);
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  @override
  Future<List<ProyectoByRol>> obtenerProyectosByRol(String rol) async {

    try {
      DatabaseReference proyectosRef;

      if(rol.contains('Lider')){
        proyectosRef = db.ref().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("listProyectoLider");
      }else{
        proyectosRef = db.ref().child("users").child(FirebaseAuth.instance.currentUser!.uid).child("listProyectoAuxiliar");
      }

      DatabaseEvent databaseEvent = await proyectosRef.once();

      List<ProyectoByRol> proyectos = [];
      Map<dynamic, dynamic>? proyectosData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>?;

      return _cargarProyectosByRol(proyectosData, proyectos);
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

    List<ProyectoByRol> _cargarProyectosByRol(
      Map<dynamic, dynamic>? proyectosData, List<ProyectoByRol> proyectos) {
    try {
      if (proyectosData != null) {
        proyectosData.forEach((proyectoId, proyectoData) {
          ProyectoByRol? proyecto = ProyectoByRol.fromJson(proyectoData);
          proyectos.add(proyecto);
        });
      }
      return proyectos;
    } catch (e) {
      throw GetAllProyectsFailed("Error al cargar proyectos by ID: $e");
    }
  }

  List<Proyecto> _cargarProyectos(
      Map<dynamic, dynamic>? proyectosData, List<Proyecto> proyectos) {
    try {
      if (proyectosData != null) {
        proyectosData.forEach((proyectoId, proyectoData) {
          Proyecto? proyecto = Proyecto.fromJson(proyectoData);
          proyecto.id = proyectoId;
          proyectos.add(proyecto);
        });
      }
      return proyectos;
    } catch (e) {
      throw GetAllProyectsFailed("Error al cargar proyectos: $e");
    }
  }

  @override
  Future<Proyecto?> buscarProyecto(String proyectoId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent = await proyectoRef.once();
      return _procesarProyectoSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<Meta?> buscarMeta(String proyectoId, String metaId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent =
          await proyectoRef.child("listMeta").child(metaId).once();

      return _procesarMetaSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

    @override
  Future<List<Meta>> obtenerMetas(String proyectoId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent =
          await proyectoRef.child("listMeta").once();

      return _procesarTodasMetaSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  @override
  Future<List<Tarea>> obtenerTareas(String metaId, String proyectoID) async{
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoID).child('listMeta').child(metaId);
      DatabaseEvent databaseEvent =
          await proyectoRef.child("listTarea").once();

      return _procesarTodasTareasSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
  @override
  Future<Tarea?> buscarTarea(
      String proyectoId, String metaId, String tareaId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseEvent databaseEvent = await proyectoRef
          .child("listMeta")
          .child(metaId)
          .child("listTarea")
          .child(tareaId)
          .once();
      return _procesarTareaSnapshot(databaseEvent.snapshot);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> _actualizarIDsComentariosProyecto(
      DatabaseReference proyectoRef, Proyecto proyecto) async {
    if (proyecto.listComentarioPy != null) {
      proyecto.listComentarioPy!
          .asMap()
          .forEach((comentarioPyIndex, comentario) {
        final DatabaseReference comentRef =
            proyectoRef.child("listComentarioPy").push();
        final String comentId = comentRef.key!;
        proyecto.listComentarioPy![comentarioPyIndex].id = comentId;
      });
    }
  }

  Future<void> _actualizarIDsMetasProyecto(
      DatabaseReference proyectoRef, Proyecto proyecto) async {
    if (proyecto.listMeta != null) {
      proyecto.listMeta!.asMap().forEach((metaIndex, meta) {
        final DatabaseReference metaRef = proyectoRef.child("listMeta").push();
        final String metaId = metaRef.key!;
        proyecto.listMeta![metaIndex].id = metaId;

        if (meta.listTarea != null) {
          _actualizarIDsTareasMeta(metaRef, proyecto.listMeta![metaIndex]);
        }

        if (meta.listComentarioMeta != null) {
          _actualizarIDsComentariosMeta(metaRef, proyecto.listMeta![metaIndex]);
        }
      });
    }
  }

  void _actualizarIDsTareasMeta(DatabaseReference metaRef, Meta meta) {
    meta.listTarea!.asMap().forEach((tareaIndex, tarea) {
      final DatabaseReference tareaRef = metaRef.child("listTarea").push();
      final String tareaId = tareaRef.key!;
      meta.listTarea![tareaIndex].id = tareaId;

      if (tarea.listComentarioTarea != null) {
        actualizarIDsComentariosTarea(tareaRef, tarea);
      }
    });
  }

  void actualizarIDsComentariosTarea(DatabaseReference tareaRef, Tarea tarea) {
    tarea.listComentarioTarea!.asMap().forEach((comentarioIndex, comentario) {
      final DatabaseReference comentarioRef =
          tareaRef.child("listComentarioTarea").push();
      final String comentarioId = comentarioRef.key!;
      tarea.listComentarioTarea![comentarioIndex].id = comentarioId;
    });
  }

  void _actualizarIDsComentariosMeta(DatabaseReference metaRef, Meta meta) {
    meta.listComentarioMeta!.asMap().forEach((comentarioIndex, comentario) {
      final DatabaseReference comentarioRef =
          metaRef.child("listComentarioMeta").push();
      final String comentarioId = comentarioRef.key!;
      meta.listComentarioMeta![comentarioIndex].id = comentarioId;
    });
  }

  Meta? _procesarMetaSnapshot(DataSnapshot metaSnapshot) {
    try {
      if (metaSnapshot.value != null) {
        Map<dynamic, dynamic> metaData =
            metaSnapshot.value as Map<dynamic, dynamic>;
        return Meta.fromJson(metaData);
      }
      return null;
    } catch (e) {
      throw MetaSearchFailed("Error al buscar meta: $e");
    }
  }

    List<Meta> _procesarTodasMetaSnapshot(DataSnapshot metaSnapshot) {
      List<Meta> responmetas = [];
    try {
      if (metaSnapshot.value != null) {
          Map<dynamic, dynamic>? proyectosData =
          metaSnapshot.value as Map<dynamic, dynamic>?;
          
          
        proyectosData?.forEach((proyectoId, proyectoData) {
          Meta? proyecto = Meta.fromJson(proyectoData);
          //proyecto.id = proyectoId;
          responmetas.add(proyecto);
        });
      }
      return responmetas;
    } catch (e) {
      throw GetAllProyectsFailed("Error al cargar proyectos: $e");
    }
  }

    List<Tarea> _procesarTodasTareasSnapshot(DataSnapshot tareaSnapshot) {
      List<Tarea> responmetas = [];
    try {
      if (tareaSnapshot.value != null) {
          Map<dynamic, dynamic>? metasData =
          tareaSnapshot.value as Map<dynamic, dynamic>?;
                    
        metasData?.forEach((metaId, metaData) {
          Tarea? meta = Tarea.fromJson(metaData);
          //proyecto.id = proyectoId;
          responmetas.add(meta);
        });
      }
      return responmetas;
    } catch (e) {
      throw GetAllProyectsFailed("Error al cargar metas: $e");
    }
  }

  Proyecto? _procesarProyectoSnapshot(DataSnapshot proyectoSnapshot) {
    try {
      if (proyectoSnapshot.value != null) {
        Map<dynamic, dynamic> proyectoData =
            proyectoSnapshot.value as Map<dynamic, dynamic>;
        return Proyecto.fromJson(proyectoData);
      }
    } catch (e) {
      throw ProyectSearchFailed("Error al buscar proyecto: $e");
    }

    return null;
  }

  Tarea? _procesarTareaSnapshot(DataSnapshot tareaSnapshot) {
    try {
      if (tareaSnapshot.value != null) {
        Map<dynamic, dynamic> tareaData =
            tareaSnapshot.value as Map<dynamic, dynamic>;
        return Tarea.fromJson(tareaData);
      }
    } catch (e) {
      throw TareaSearchFailed("Error al buscar tarea: $e");
    }
    return null;
  }

  @override
  Future<void> eliminarProyecto(String proyectoId) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      await _eliminarProyect(proyectoRef);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _eliminarProyect(DatabaseReference proyectoRef) async {
    try {
      await proyectoRef.remove();
    } catch (e) {
      throw ProyectDeleteFailed("Error al eliminar proyecto: $e");
    }
  }

  @override
  Future<bool> ingresarComoAuxiliar(
      String projectId, String userId, String nombre) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(projectId);

      await _verificarProyectoExiste(proyectoRef);
      await _verificarUsuarioProyecto(proyectoRef, userId);

      await _agregarUsuarioAuxiliar(userId, proyectoRef, nombre);
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  @override
  Future<bool> verificarUsuarioEnProyecto(
      String proyectoId, String userId) async {
    try {
      final DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);

      DatabaseEvent databaseEvent = await proyectoRef.once();
      Map<dynamic, dynamic>? proyectoData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>?;

      if (proyectoData != null) {
        if (proyectoData['listUserProyecto'] != null) {
          Map<dynamic, dynamic> listUserProyectoData =
              proyectoData['listUserProyecto'] as Map<dynamic, dynamic>;

          bool usuarioEnProyecto = listUserProyectoData.values.any((userData) {
            return userData['usuarioId'] == userId;
          });

          return usuarioEnProyecto;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<void> _agregarUsuarioAuxiliar(
      String userId, DatabaseReference proyectoRef, String nombre) async {
    //Obtener proyectoId
    String proyectoId = proyectoRef.key!;
    //Almacenar usuario en listUserProyecto
    UsuariosProyecto auxiliar = UsuariosProyecto(
        usuarioId: userId,
        rol: "Auxiliar",
        nombre: nombre,
        avatar:
            'https://img.freepik.com/psd-premium/avatar-dibujos-animados-3d-hombre-barbudo_1020-5121.jpg');
    await proyectoRef.child("listUserProyecto").push().set(auxiliar.toJson());

    //Almacenar usuario en listProyectoAuxiliar
    ProyectoAuxliliar pyAux = ProyectoAuxliliar(proyectoAuxiliarId: proyectoId);
    final DatabaseReference usuarioRef =
        db.ref().child("users").child(userId).child("listProyectoAuxiliar");

    await usuarioRef.push().set(pyAux.toJson());
  }

  Future<void> _verificarUsuarioProyecto(
      DatabaseReference proyectoRef, String userId) async {
    DatabaseEvent databaseEvent = await proyectoRef
        .child("listUserProyecto")
        .orderByChild("usuarioId")
        .equalTo(userId)
        .once();
    if (databaseEvent.snapshot.exists) {
      throw Exception("El usuario ya está en el proyecto");
    }
  }

  Future<void> _verificarProyectoExiste(DatabaseReference proyectoRef) async {
    DatabaseEvent databaseEvent = await proyectoRef.once();
    if (!databaseEvent.snapshot.exists) {
      throw ProyectSearchFailed("El proyecto no existe");
    }
  }

/* Nota : Solo usar estos roles : Lider, Lider_Backend, Lider_UI, Lider_Code, Sublider_Backend,
  Sublider_UI, Sublider_Code, Auxiliar */
  @override
  Future<bool> cambiarRol(
      String proyectoId, String usuarioId, String nuevoRol) async {
    try {
      DatabaseReference proyectoRef =
          db.ref().child("proyecto").child(proyectoId);
      DatabaseReference usuarioProyectoRef =
          proyectoRef.child("listUserProyecto");

      DatabaseEvent databaseEvent = await usuarioProyectoRef.once();
      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> usuarioProyectoData =
            databaseEvent.snapshot.value as Map<dynamic, dynamic>;

        String? usuarioProyectoKey =
            _buscarUsuarioEnProyecto(usuarioProyectoData, usuarioId);
        if (usuarioProyectoKey != null) {
          await _actualizarRolUsuario(
              usuarioProyectoRef, usuarioProyectoKey, nuevoRol);
          await actualizarListasUsuario(usuarioId, nuevoRol, proyectoId);
          return true;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<void> actualizarListasUsuario(
      String usuarioId, String nuevoRol, String proyectoId) async {
    DatabaseReference usuarioRef = db.ref().child("users").child(usuarioId);
    DatabaseEvent usuarioSnapshot = await usuarioRef.once();

    if (usuarioSnapshot.snapshot.value != null) {
      if (esRolLider(nuevoRol) || esRolSublider(nuevoRol)) {
        await _agregarAListaProyectoLider(usuarioId, proyectoId);
        await _eliminarDeListaProyectoAuxiliar(usuarioId, proyectoId);
      } else if (esRolAuxiliar(nuevoRol)) {
        await _agregarAListaProyectoAuxiliar(usuarioId, proyectoId);
        await _eliminarDeListaProyectoLider(usuarioId, proyectoId);
      }
    }
  }

  Future<void> _agregarAListaProyectoLider(
      String usuarioId, String proyectoId) async {
    try {
      final ProyectoLider pyLider = ProyectoLider(proyectoLiderId: proyectoId);
      DatabaseReference listaProyectoLiderRef =
          db.ref().child("users").child(usuarioId).child("listProyectoLider");
      listaProyectoLiderRef.push().set(pyLider.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _agregarAListaProyectoAuxiliar(
      String usuarioId, String proyectoId) async {
    final ProyectoAuxliliar pyAux =
        ProyectoAuxliliar(proyectoAuxiliarId: proyectoId);
    DatabaseReference listaProyectoAuxiliarRef =
        db.ref().child("users").child(usuarioId).child("listProyectoAuxiliar");
    listaProyectoAuxiliarRef.push().set(pyAux.toJson());
  }

  Future<void> _eliminarDeListaProyectoLider(
      String usuarioId, String proyectoId) async {
    DatabaseReference listaProyectoLiderRef =
        db.ref().child("users").child(usuarioId).child("listProyectoLider");
    DatabaseEvent snapshot = await listaProyectoLiderRef.once();

    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> proyectos =
          snapshot.snapshot.value as Map<dynamic, dynamic>;
      String? proyectoKey;
      proyectos.forEach((key, value) {
        if (value["proyectoLiderId"] == proyectoId) {
          proyectoKey = key;
        }
      });
      if (proyectoKey != null) {
        listaProyectoLiderRef.child(proyectoKey!).remove();
      }
    }
  }

  Future<void> _eliminarDeListaProyectoAuxiliar(
      String usuarioId, String proyectoId) async {
    DatabaseReference listaProyectoAuxiliarRef =
        db.ref().child("users").child(usuarioId).child("listProyectoAuxiliar");
    DatabaseEvent snapshot = await listaProyectoAuxiliarRef.once();

    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> proyectos =
          snapshot.snapshot.value as Map<dynamic, dynamic>;
      String? proyectoKey;
      proyectos.forEach((key, value) {
        if (value["proyectoAuxiliarId"] == proyectoId) {
          proyectoKey = key;
        }
      });
      if (proyectoKey != null) {
        listaProyectoAuxiliarRef.child(proyectoKey!).remove();
      }
    }
  }

  bool esRolLider(String rol) {
    return rol == "Lider" ||
        rol == "Lider_Backend" ||
        rol == "Lider_UI" ||
        rol == "Lider_Codigo";
  }

  bool esRolSublider(String rol) {
    return rol == "Sublider_Backend" ||
        rol == "Sublider_UI" ||
        rol == "Sublider_Codigo";
  }

  bool esRolAuxiliar(String rol) {
    return rol == "Auxiliar";
  }

  String? _buscarUsuarioEnProyecto(
      Map<dynamic, dynamic> usuarioProyectoData, String usuarioId) {
    String? usuarioProyectoKey;
    usuarioProyectoData.forEach((key, value) {
      UsuariosProyecto usuariosProyecto = UsuariosProyecto.fromJson(value);
      if (usuariosProyecto.usuarioId == usuarioId) {
        usuarioProyectoKey = key;
      }
    });
    return usuarioProyectoKey;
  }

  Future<void> _actualizarRolUsuario(DatabaseReference usuarioProyectoRef,
      String usuarioProyectoKey, String nuevoRol) async {
    await usuarioProyectoRef
        .child(usuarioProyectoKey)
        .child("rol")
        .set(nuevoRol);
  }
  
  

}

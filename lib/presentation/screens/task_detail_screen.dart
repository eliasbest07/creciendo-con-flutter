import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/proyecto_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_usuario_entity.dart';
import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:TaskFlow/presentation/widgets/home/navbar.dart';
import 'package:TaskFlow/providers/riverpod_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proyecto/tarea_entity.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Tarea tarea;
  final Meta meta;
  //final TareaUsuario tareaUsuario;

// eliminar error de los required aun teniendo el const
  TaskDetailScreen({super.key, required this.meta, required this.tarea});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? colorEstado;
    switch (tarea.estado) {
      case 'En proceso':
        colorEstado = Colors.amber;
        break;
      case 'Revisión':
        colorEstado = Colors.red;
        break;
      case 'Terminado':
        colorEstado = Colors.green;
        break;
      case 'Avanzado':
        colorEstado = Colors.orange;
        break;
      default:
    }

    final tareaInf = ref.watch(tareaDetails.notifier);
    final tareaState = ref.watch(tareaDetails);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF6F9FF),
      appBar: AppBar(
        title: const Text(
          'DETALLES DE LA TAREA',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: NavBar(
        primaryColor: Theme.of(context).primaryColor,
        width: size.width,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // lista de Comentarios
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 46, 46, 46),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 7.0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text('Comentario $index'),
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: tarea.usuarioAsignado == null && tareaState ||
                            !tareaState
                        ? // para que lo re dibuje xd
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return Center(
                                        child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        width: size.width * 0.6,
                                        height: size.height * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    74, 46, 46, 46),
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 7.0,
                                              )
                                            ]),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                '¿Seguro de auto asignarte esta tarea? Si la aceptas, se descontaran 2 pts, si la completas ganaras pts ',
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: size.height * 0.015,),
                                              MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0)),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    //TODO: crea la operación de restar 2 pts por tarea y actualiza a firebase
                                                    restarPuntosTarea();
                                                    tarea.usuarioAsignado =
                                                        tareaInf.currentUserID;
                                                    tarea.estado = 'en proceso';
                                                    ProyectoService()
                                                        .actualizarTarea(
                                                            tareaInf.projectoID,
                                                            tareaInf.goalID,
                                                            tarea);
                                                    ProyectoService()
                                                        .asignarTarea(
                                                            proyectoId: tareaInf
                                                                .projectoID,
                                                            metaId:
                                                                tareaInf.goalID,
                                                            tareaID: tarea.id!,
                                                            userId: tareaInf
                                                                .currentUserID,
                                                            tarea: tarea);
                                                    Navigator.pop(context);
                                                    tareaInf.setUser();
                                                    ref
                                                        .watch(listTareaUsuario
                                                            .notifier)
                                                        .init();
                                                  },
                                                  child: const Text('Si',
                                                      style: TextStyle(
                                                          color: Colors.white)))
                                            ]),
                                      ),
                                    ));
                                  });
                            },
                            child: const Text(
                              'Yo cumpliré con esta tarea',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : FutureBuilder(
                            future: ProyectoService()
                                .obtenerUsuarioActual(tarea.usuarioAsignado!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Usuario user = snapshot.data!;
                                return Row(
                                  children: [
                                    user.avatar != 'vacio'
                                        ? CircleAvatar(
                                            radius: 30,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl: user.avatar,
                                                )))
                                        : const CircleAvatar(
                                            radius: 30,
                                            child: Icon(Icons.person)),
                                    const SizedBox(width: 7),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.nombre,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  'https://cdn-icons-png.flaticon.com/512/625/625394.png',
                                              width: 25,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  'https://cdn-icons-png.flaticon.com/512/625/625393.png',
                                              width: 25,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  'https://cdn-icons-png.flaticon.com/512/625/625393.png',
                                              width: 25,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            tarea.usuarioAsignado != null
                ? tarea.usuarioAsignado! == tareaInf.currentUserID
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: const Text('Notificar avance',
                                  style: TextStyle(color: Colors.white))),
                          MaterialButton(
                              color: Colors.red,
                              onPressed: () async {

                                //abre dialogo de confirmación antes de desistir    
                                //ese                    tarea.id es userTareaId de TareaUsuario         


                                //tarea.id es el id de la tarea dentro del listado de listaTareas de firebase
                                //listaTareas tiene un id, y no es tarea.id
                                //pendiente: se debe buscar ese id de listaTareas en cuestión


                                //segun bing, una de las formas de saber el id de TareaUsuario (padre), 
                                //es a traves de su hijo (cada item de tarea dentro de listaTareas)
                                // ya que, cada item hijo tiene "tareaid", este puede usarse para buscar entre el listado de listaTareas
                                // y trarse ese id padre


                                 

                                //String idTareaUsuario = getIdTareaUsuario(tarea.id);
                                
                                String? idTareaUsuario = await getIdTareaUsuario(tarea.id);


                                print('idTareaUsuario: $idTareaUsuario');


                                showDesistirTareaDialog(context, size, idTareaUsuario);
                              },
                              child: const Text('Desistir',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      )
                    : const SizedBox(width: 10)
                : const SizedBox(width: 10),
            const SizedBox(height: 10),
            Container(
              //height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Estado',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Chip(
                                label: Text(
                                  tarea.estado,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: colorEstado,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Nivel',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  tarea.nivel.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha de creación',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '01/06/2023',
                              ),
                            ],
                          ),
                          const SizedBox(height: 17.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha de culminación',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '27/06/2023',
                              ),
                            ],
                          ),
                        ],
                      )),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Descripción',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Text(tarea.descripcion),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

FirebaseAuth auth = FirebaseAuth.instance;

  void restarPuntosTarea() {    
    UsuarioService().gastarPuntos(auth.currentUser!.uid, 2);
  }
  
  void desistirTarea(tareaID) {   
    UsuarioService().eliminarTarea(userId: auth.currentUser!.uid, tareaID: tareaID,);
  }
  
  void showDesistirTareaDialog(BuildContext context, size, tareaID) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return Center(
                    child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: size.width * 0.6,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(
                                74, 46, 46, 46),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 7.0,
                          )
                        ]),
                    child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿Estás seguro de desistir a esta tarea?',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height * 0.015,),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          6.0)),
                              color: Theme.of(context)
                                  .primaryColor,
                              onPressed: () {
                                //TODO: crea la operación de restar 2 pts por tarea y actualiza a firebase
                                desistirTarea(tareaID);
                                Navigator.pop(context);
                   
                              },
                              child: const Text('Si',
                                  style: TextStyle(
                                      color: Colors.white)))
                        ]),
                  ),
                ));
              });
        
  }

  FirebaseDatabase db = FirebaseDatabase.instance;
  
  Future<String?> getIdTareaUsuario(String? tareaId) async{

    String userId = auth.currentUser!.uid;

    DatabaseReference usersRef = db.ref().child("users").child(userId).child('listaTareas');
    DatabaseEvent databaseEvent = await usersRef.once();

    Map<dynamic, dynamic>? tareasData =
        databaseEvent.snapshot.value as Map<dynamic, dynamic>?;

    if (tareasData != null) {
      String? listaTareaId;
      tareasData.forEach((key, value) {
        if (value['tareaid'] == tareaId) {
          listaTareaId = key;
        }
      });
      return listaTareaId;
    } else {
      return null;
    }     

  }
}

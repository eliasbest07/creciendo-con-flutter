import 'dart:io';
import 'package:TaskFlow/domain/entities/proyecto/add_user_project.dart';
import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/usuarioProyecto_entity.dart';
//import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/acortadores_string.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:TaskFlow/presentation/screens/goal_detail_screen.dart';
import 'package:TaskFlow/presentation/screens/new_goals_screen.dart';
import 'package:TaskFlow/providers/riverpod_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/proyecto/proyecto_entity.dart';
import '../widgets/widgets.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen(
      {Key? key, required this.project, required this.cacheManager})
      : super(key: key);

  final Proyecto project;

  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final primaryColor = Theme.of(context).primaryColor;

    final nombre = ref.watch(showNombre);

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    final tarea = ref.watch(tareaDetails.notifier);
    tarea.currentUserID = userId;
    tarea.projectoID = project.id!;

    final size = MediaQuery.of(context).size;

    List<UsuariosProyecto> listaFiltrada = project.listUserProyecto!
        .where((usuario) => usuario.rol != 'Auxiliar')
        .toList();
    //final List<Usuario> colaboradores = ;

    //instancia del servicio: clase acortador de palabras
    Acortador acortador = Acortador();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 255),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(155.0),
        child: Container(
          height: 155,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 40,
                          width: 250,
                          child: Text(
                            project.nombre,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          )),
                      Row(children: [
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                project.fechaInicio.toString().substring(0, 10),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 255, 235, 59)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                project.fechaEstablecida
                                    .toString()
                                    .substring(0, 10),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 200,
                            width: 160,
                            child: FutureBuilder(
                              future: cacheManager.getSingleFile(
                                project.icon,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<File> snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('No se pudo cargar la imagen'),
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 252, 214, 143),
                                    ),
                                  );
                                }
                                final imageFile = snapshot.data!;
                                return Image.file(imageFile);
                              },
                            ),
                          )))
                ],
              ),
            ),
          ]),
        ),
      ),
      drawer: SizedBox(
          height: height * 0.7,
          width: width * 0.7,
          child: DrawerCustom(size: Size(width, height))),
      // floatingActionButton: NavBar(
      //   primaryColor: primaryColor,
      //   width: width,
      // ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: size.height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Responsables:',
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listaFiltrada.length ?? 0,
                  itemBuilder: (context, index) {
                    //project.listUserProyecto

                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Container(
                        width: size.width * 0.80,
                        height: 130,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(24, 46, 46, 46),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 20.0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    listaFiltrada[index].rol,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1176&q=80'),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        listaFiltrada[index].nombre,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            BotonUnirse(
                project: project,
                userId: userId,
                primaryColor: primaryColor,
                nombre: nombre),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Auxiliares:',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                height: size.height * 0.10,
                width: size.width,
                child: StreamBuilder<List<UsuariosProyecto>>(
                  stream: UsuarioService().obtenerUsuariosProyecto(project.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final usuarios = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = usuarios[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(usuario.avatar),
                                ),
                                Expanded(
                                  child: Text(
                                    acortador.getFirstWord(usuario.nombre),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar usuarios');
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(24, 46, 46, 46),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 20.0,
                  )
                ],
                //color: Color.fromARGB(255, 218, 216, 216),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 0, top: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Metas establecidas',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewGoalScreen(
                                            projectID: project.id!),
                                      ));

                                  /*                               showDialog(
                                      context: context,
                                      builder: (context) => Center(
                                          child: Align(
                                              alignment: Alignment.topCenter,
                                              child: NewMetaDialog(
                                                  context: context, size: size)))); */
                                },
                                icon: const Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  FutureBuilder(
                    future: ProyectoService().obtenerMetas(project.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Meta>? metas = snapshot.data;
                        return SizedBox(
                          height: height * 0.17,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: metas!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (project.listUserProyecto!
                                      .where((element) =>
                                          element.usuarioId == userId)
                                      .isEmpty) {
                                    Fluttertoast.showToast(
                                      msg:
                                          'Para acceder deber tener el rol de auxiliar.', // message
                                      toastLength: Toast.LENGTH_SHORT, // length
                                      gravity: ToastGravity.BOTTOM, // location
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => (GoalDetailScreen(
                                          meta: metas[index],
                                          project: project,
                                        )),
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Container(
                                    width: width * 0.6,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(24, 46, 46, 46),
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0,
                                          )
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.purple,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                metas[index].item,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month_sharp,
                                                  color: Color(0xffB9B9B9),
                                                  size: 15,
                                                ),
                                                Text(
                                                  DateFormat("dd MMM yyyy")
                                                      .format(metas[index]
                                                          .fechaCreada!),
                                                  style: const TextStyle(
                                                    color: Color(0xffB9B9B9),
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Container(
                                                  width: 7,
                                                  height: 7,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.amber,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                metas[index].nombre,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 218, 216, 216),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: 0.7,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    strokeWidth: 6,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 4,
                                                  left: 4,
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '70',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          '%',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 20,
                                          //color: Colors.red,
                                          child: ListView.builder(
                                            itemCount: 3,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              if (index == 0) {
                                                return const CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xffE3E3E3),
                                                  radius: 10,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80',
                                                    ),
                                                    radius: 9,
                                                  ),
                                                );
                                              }

                                              if (index == 1) {
                                                return Transform.translate(
                                                  offset: const Offset(-10, 0),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xffE3E3E3),
                                                    radius: 10,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        'https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80',
                                                      ),
                                                      radius: 9,
                                                    ),
                                                  ),
                                                );
                                              }

                                              if (index == 2) {
                                                return Transform.translate(
                                                  offset: const Offset(-20, 0),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xffE3E3E3),
                                                    radius: 10,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        'https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                                                      ),
                                                      radius: 9,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Text(
                      'Otros detalles',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estado',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Chip(
                                  label: Text(
                                    'En gestión',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fecha de creación',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '27/06/2023',
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Número de participantes',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '6',
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 300),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
          primaryColor: primaryColor,
          width: width,
          goToScreen: (index) {
            ref.read(indexPage.notifier).update((state) => index);
          }),
    );
  }
}

class BotonUnirse extends StatefulWidget {
  const BotonUnirse({
    super.key,
    required this.project,
    required this.userId,
    required this.primaryColor,
    required this.nombre,
  });

  final Proyecto project;
  final String userId;
  final Color primaryColor;
  final String nombre;

  @override
  State<BotonUnirse> createState() => _BotonUnirseState();
}

class _BotonUnirseState extends State<BotonUnirse> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.project.listUserProyecto!
              .where((element) => element.usuarioId == widget.userId)
              .isNotEmpty
          ? false
          : true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: MaterialButton(
            color: widget.primaryColor,
            onPressed: () {
              try {
                final AddUserProject auxiliarUser = AddUserProject(
                    creadoPor: widget.project.creadopor,
                    estado: widget.project.estado,
                    icono: widget.project.icon,
                    nombreProyecto: widget.project.nombre,
                    proyectoId: widget.project.id!);

                ProyectoService().ingresarComoAuxiliar(widget.project.id!,
                    widget.userId, widget.nombre, auxiliarUser);

                widget.project.listUserProyecto!.add(
                  UsuariosProyecto(
                    usuarioId: widget.userId,
                    rol: 'Auxiliar',
                    nombre: widget.nombre,
                    avatar: '',
                  ),
                );

                // agregar al usuario proyecto como auxiliar
                Fluttertoast.showToast(
                  msg: "Te has unido con éxito", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.BOTTOM, // location
                );
              } catch (error) {
                Fluttertoast.showToast(
                  msg: "Error al unirse", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.CENTER, // location
                );
              }

              setState(() {});
            },
            child: const Text(
              'Unirme al proyecto como Auxiliar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

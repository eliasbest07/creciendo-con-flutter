import 'dart:io';
import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/proyecto/tarea_usuario_entity.dart';
import '../../infrastructure/services/local_storage/local_storage.dart';
import '../../infrastructure/services/usuario_service.dart';
import '../../providers/riverpod_provider.dart';
import '../controllers/login_controller.dart';
import '../widgets/home/card_tarea.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final Meta meta;

    final LoginController controller = ref.watch(loginController.notifier);
    final listaProject = ref.watch(listaProyectos);
    final listaTareas = ref.watch(listTareaUsuario);
    // esto es para que se cargue la imagen en cache
    final CacheManager cacheManager = CacheManager(
      Config(
        'my_custom_cache_key', // una clave secreata para el cache
        stalePeriod:
            const Duration(days: 7), // La imagen caducará después de 7 días
      ),
    );

    final primaryColor = Theme.of(context).primaryColor;

    LocalStorage().getNombre().then((value) {
      if (value == 'vacio') {
        UsuarioService().obtenerUsuario().then((value) {
          LocalStorage().setEstatus(value.rol).then((_) {
            ref.read(showEstatus.notifier).state = value.rol;
            ref.read(showNombre.notifier).state = value.nombre;
          });
        });
      } else {
        ref.read(showEstatus.notifier).state = value;
        ref.read(showNombre.notifier).state = value;
      }
    });

    final size = MediaQuery.of(context).size;
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 15.0);
    const titleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF6F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'TASKFLOW',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          // IconButton(
          //   onPressed: () async {
          //     await controller.cerrarSesion();
          //     if (context.mounted) {
          //       Navigator.pushReplacementNamed(context, 'login');
          //     }
          //   },
          //   icon: const Icon(
          //     Icons.exit_to_app,
          //     color: Colors.black,
          //   ),
          // )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            const Padding(
              padding: paddingHorizontal,
              child: Row(
                children: [
                  Text(
                    'Mis tareas asignadas',
                    textAlign: TextAlign.left,
                    style: titleStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            listaTareas.isEmpty
                ? Container(
                    width: double.infinity,
                    height: height * 0.14,
                    padding: paddingHorizontal,
                    child: Lottie.asset('assets/empty_animation.json'),
                  )
                : SizedBox(
                    height: height * 0.14,
                    child: ListView.separated(
                      itemCount: listaTareas.length,
                      scrollDirection: Axis.horizontal,
                      padding: paddingHorizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        final tarea = listaTareas[index];

                        //Separar el widget en otra clase y pasar como parametro
                        //un objeto de tipo TareaUsuario
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailScreen(
                                  tarea: TareaUsuario.convertirTarea(
                                      listaTareas[index]),
                                  lideres: [],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: width * 0.7,
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(10, 155, 155, 155),
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tarea.nombre,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Text(
                                            'Estado: ',
                                            style: TextStyle(
                                              color: Color(0xffB9B9B9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              color: Colors.amber,
                                            ),
                                            child: Text(
                                              tarea.estado,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Transform.scale(
                                  scale: 2,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    activeColor: const Color(0xff0A3567),
                                    visualDensity: VisualDensity.compact,
                                    value: true,
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                    ),
                  ),
            SizedBox(
              height: height * 0.02,
            ),
            const Padding(
              padding: paddingHorizontal,
              child: Row(
                children: [
                  Text(
                    'Proyectos para unirte',
                    textAlign: TextAlign.left,
                    style: titleStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              color: Colors.transparent,
              height: height * 0.15,
              child: ListView.builder(
                itemCount: listaProject.length,
                padding: paddingHorizontal,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final project = listaProject[index];

                  return GestureDetector(
                    onTap: () {
                      listaProject[index].fechaInicio =
                          DateTime.parse("2023-06-06");
                      listaProject[index].fechaEstablecida =
                          DateTime.parse("2023-08-06");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailScreen(
                              cacheManager: cacheManager,
                              project: listaProject[index]),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(10, 155, 155, 155),
                                offset: Offset(0.0, 2.0),
                                blurRadius: 5.0,
                                spreadRadius: 10.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: SizedBox(
                              height: height * 0.10,
                              width: width * 0.22,
                              child: listaProject[index].icon == 'vacio'
                                  ? const Icon(Icons.account_balance_rounded)
                                  : FutureBuilder(
                                      future: cacheManager.getSingleFile(
                                        listaProject[index].icon,
                                      ),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<File> snapshot) {
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                'No se pudo cargar la imagen'),
                                          );
                                        }
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                            ),
                                          );
                                        }
                                        final imageFile = snapshot.data!;
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.file(imageFile),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          project.nombre.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Padding(
              padding: paddingHorizontal,
              child: Row(
                children: [
                  Text(
                    'Noticias',
                    textAlign: TextAlign.left,
                    style: titleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // body: Stack(
      //   children: [
      //     Column(
      //       children: [
      //         SizedBox(
      //           height: height * 0.02,
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.only(left: 10.0),
      //           child: Row(
      //             children: [
      //               Text('Tus tareas asignadas',
      //                   textAlign: TextAlign.left,
      //                   style: TextStyle(
      //                       color: Colors.black,
      //                       fontSize: 22,
      //                       fontWeight: FontWeight.bold)),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: height * 0.02,
      //         ),
      //         listaTareas.isEmpty
      //             ? const Text(
      //                 'Para tener tareas, primero debes unirte a un proyecto')
      //             : SizedBox(
      //                 height: height * 0.2,
      //                 child: ListView.builder(
      //                   scrollDirection: Axis.horizontal,
      //                   itemCount: listaTareas.length,
      //                   itemBuilder: (context, index) {
      //                     return Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: CardTarea(
      //                           size: size,
      //                           listTarea: TareaUsuario.convertirListTarea(
      //                               listaTareas),
      //                           index: index),

      //                       /*
      //               GestureDetector(
      //                 onTap: () {
      //                   // Navigator.push(
      //                   //     context,
      //                   //     MaterialPageRoute(
      //                   //       builder: (context) =>
      //                   //           TaskDetailScreen(tarea: listaTareas[index])),
      //                   //   );
      //                 },
      //                 child: Container(
      //                     width: height * 0.18,
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(20),
      //                       border: const Border.fromBorderSide(
      //                         BorderSide(
      //                           width: 4,
      //                           color: Color.fromARGB(255, 147, 216, 207),
      //                         ),
      //                       ),
      //                     ),
      //                     child: Stack(
      //                       children: [
      //                         Container(
      //                           height: 40,
      //                           decoration: const BoxDecoration(
      //                             color: Color.fromARGB(155, 147, 216, 207),
      //                             borderRadius: BorderRadius.only(
      //                                 topLeft: Radius.circular(10),
      //                                 topRight: Radius.circular(10)),
      //                           ),
      //                           child: Stack(
      //                             children: [
      //                               Container(
      //                                 height: 40,
      //                                 decoration: const BoxDecoration(
      //                                   color:
      //                                       Color.fromARGB(155, 147, 216, 207),
      //                                   borderRadius: BorderRadius.only(
      //                                       topLeft: Radius.circular(10),
      //                                       topRight: Radius.circular(10)),
      //                                 ),
      //                               ),
      //                               Positioned(
      //                                   top: 10,
      //                                   left: 7,
      //                                   child: Text(listaTareas[index].estado)),
      //                               Positioned(
      //                                   top: 50,
      //                                   left: 7,
      //                                   child: SizedBox(
      //                                       width: height * 0.16,
      //                                       height: 55,
      //                                       child: Text(listaTareas[index]
      //                                           .descripcion)))
      //                             ],
      //                           )),
      //                     ),
      //                   );
      //                 },
      //               ),
      //               */
      //                     );
      //                   },
      //                 ),
      //               ),
      //         SizedBox(
      //           height: height * 0.02,
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.only(left: 10.0),
      //           child: Row(
      //             children: [
      //               Text('Proyectos para unirte',
      //                   textAlign: TextAlign.left,
      //                   style: TextStyle(
      //                       color: Colors.black,
      //                       fontSize: 22,
      //                       fontWeight: FontWeight.bold)),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: height * 0.13,
      //           child: ListView.builder(
      //             scrollDirection: Axis.horizontal,
      //             itemCount: listaProject.length,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     listaProject[index].fechaInicio =
      //                         DateTime.parse("2023-06-06");
      //                     listaProject[index].fechaEstablecida =
      //                         DateTime.parse("2023-08-06");
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => ProjectDetailScreen(
      //                             cacheManager: cacheManager,
      //                             project: listaProject[index]),
      //                       ),
      //                     );
      //                   },
      //                   child: Container(
      //                       width: height * 0.11,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                         border: const Border.fromBorderSide(
      //                           BorderSide(
      //                             width: 4,
      //                             color: Color.fromARGB(255, 147, 216, 207),
      //                           ),
      //                         ), // listaProject[index].icon
      //                       ),
      //                       child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(20),
      //                           child: SizedBox(
      //                             height: 200,
      //                             width: 160,
      //                             child: listaProject[index].icon == 'vacio'
      //                                 ? const Icon(
      //                                     Icons.account_balance_rounded)
      //                                 : FutureBuilder(
      //                                     future: cacheManager.getSingleFile(
      //                                       listaProject[index].icon,
      //                                     ),
      //                                     builder: (BuildContext context,
      //                                         AsyncSnapshot<File> snapshot) {
      //                                       if (snapshot.hasError) {
      //                                         return const Center(
      //                                           child: Text(
      //                                               'No se pudo cargar la imagen'),
      //                                         );
      //                                       }
      //                                       if (!snapshot.hasData) {
      //                                         return Center(
      //                                           child:
      //                                               CircularProgressIndicator(
      //                                             color: primaryColor,
      //                                           ),
      //                                         );
      //                                       }
      //                                       final imageFile = snapshot.data!;
      //                                       return Image.file(imageFile);
      //                                     },
      //                                   ),
      //                           ))),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //         SizedBox(
      //           height: height * 0.02,
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.only(left: 10.0),
      //           child: Row(
      //             children: [
      //               Text('Noticias',
      //                   textAlign: TextAlign.left,
      //                   style: TextStyle(
      //                       color: Colors.black,
      //                       fontSize: 22,
      //                       fontWeight: FontWeight.bold)),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      //bottomNavigationBar: NavBar(primaryColor: primaryColor, width: width),
    );
  }
}

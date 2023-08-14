import 'package:TaskFlow/presentation/dialog/new_project_dialog.dart';
import 'package:TaskFlow/presentation/screens/list_goal_screen.dart';
import 'package:TaskFlow/presentation/widgets/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';
import '../widgets/project/list_projects_widget.dart';

class ListProjectScreen extends ConsumerWidget {
  const ListProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaProject = ref.watch(listaProyectos);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 246, 249, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            const Text('Mis proyectos', style: TextStyle(color: Colors.white)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Center(
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: NewProjectDialog(
                                  context: context, size: size))));
                },
                icon: const Icon(
                  Icons.add_box_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: NavBar(
        primaryColor: Theme.of(context).primaryColor,
        width: size.width,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 103, 159, 228),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                            child: Text(
                          'Soy lider',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                            child: Text(
                          'Soy auxiliar',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const ListProjectWidget(),
            // SizedBox(
            //   height: size.height * 0.7,
            //   width: double.infinity,
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: listaProject.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding:
            //             const EdgeInsets.only(top: 10.0, left: 15, right: 15),
            //         child: Container(
            //           height: 158,
            //           width: 100,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: Colors.white,
            //               boxShadow: const [
            //                 BoxShadow(
            //                     offset: Offset(0, 2),
            //                     color: Color.fromARGB(24, 46, 46, 46),
            //                     blurRadius: 5)
            //               ]),
            //           child: Column(children: [
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 8.0, left: 20, right: 20),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       const SizedBox(height: 5),
            //                       Text(
            //                         listaProject[index].nombre,
            //                         style: const TextStyle(
            //                             fontSize: 18,
            //                             fontWeight: FontWeight.w600),
            //                       ),
            //                       const SizedBox(height: 5),
            //                       Row(children: [
            //                         const Text(
            //                           'Estado:',
            //                           style: TextStyle(color: Colors.grey),
            //                         ),
            //                         const SizedBox(width: 10),
            //                         Container(
            //                           height: 25,
            //                           decoration: BoxDecoration(
            //                               borderRadius:
            //                                   BorderRadius.circular(50),
            //                               color: Colors.green),
            //                           child: const Padding(
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal: 10.0),
            //                             child: Center(
            //                               child: Text(
            //                                 'Activo',
            //                                 style:
            //                                     TextStyle(color: Colors.white),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(width: 20),
            //                         Container(
            //                           height: 20,
            //                           decoration: BoxDecoration(
            //                               borderRadius:
            //                                   BorderRadius.circular(50),
            //                               color: Colors.grey),
            //                           child: const Padding(
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal: 10.0),
            //                             child: Center(
            //                               child: Text(
            //                                 '01-09-2023',
            //                                 style:
            //                                     TextStyle(color: Colors.white),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ]),
            //                       const SizedBox(height: 5),
            //                       Row(
            //                         children: [
            //                           const Text('Creado por:',
            //                               style: TextStyle(color: Colors.grey)),
            //                           const SizedBox(width: 10),
            //                           Container(
            //                             height: 25,
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(50),
            //                                 color: Colors.blue),
            //                             child: const Padding(
            //                               padding: EdgeInsets.symmetric(
            //                                   horizontal: 10.0),
            //                               child: Center(
            //                                 child: Text(
            //                                   'Elias Best',
            //                                   style: TextStyle(
            //                                       color: Colors.white),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                   Column(
            //                     children: [
            //                       Container(
            //                         decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(10),
            //                             boxShadow: const [
            //                               BoxShadow(
            //                                 offset: Offset(0, 2),
            //                                 color:
            //                                     Color.fromARGB(24, 46, 46, 46),
            //                                 blurRadius: 5,
            //                               )
            //                             ]),
            //                         height: 55,
            //                         width: 55,
            //                         child: ClipRRect(
            //                             borderRadius: BorderRadius.circular(10),
            //                             child: Image.network(
            //                                 listaProject[index].icon)),
            //                       ),
            //                       const SizedBox(height: 15)
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(height: 15),
            //             // Padding(
            //             //   padding: const EdgeInsets.only(left:20.0),
            //             //   child: SizedBox(
            //             //     height: 70,
            //             //     child: Column(children: [
            //             //       Row(children: [
            //             //         const Text('Estado:',style: TextStyle(color: Colors.grey)),
            //             //         const SizedBox(width: 10),
            //             //         Container(
            //             //           height: 30,
            //             //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue),
            //             //           child: const Padding(
            //             //             padding: EdgeInsets.symmetric(horizontal:10.0),
            //             //             child: Center(child: Text('Activo', style: TextStyle(color: Colors.white),)),
            //             //           ),
            //             //         ),
            //             //         const SizedBox(width: 20),
            //             //         Container(
            //             //           height: 20,
            //             //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey),
            //             //           child: const Padding(
            //             //             padding: EdgeInsets.symmetric(horizontal:10.0),
            //             //             child: Center(child: Text('01-09-2023', style: TextStyle(color: Colors.white),)),
            //             //           ),
            //             //         ),
            //             //       ]),
            //             //       const SizedBox(height: 5),
            //             //       Row(children: [
            //             //         const Text('Creado por:',style: TextStyle(color: Colors.grey)),
            //             //         const SizedBox(width: 10),
            //             //         Container(
            //             //           height: 30,
            //             //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue),
            //             //           child: const Padding(
            //             //             padding: EdgeInsets.symmetric(horizontal:10.0),
            //             //             child: Center(child: Text('Elias Best', style: TextStyle(color: Colors.white),)),
            //             //           ),
            //             //         )
            //             //       ]),
            //             //     ],),
            //             //   ),
            //             // ),
            //             Expanded(
            //               flex: 2,
            //               child: Row(
            //                 children: [
            //                   Expanded(
            //                     flex: 2,
            //                     child: ClipRRect(
            //                       borderRadius: const BorderRadius.only(
            //                           bottomLeft: Radius.circular(20)),
            //                       child: MaterialButton(
            //                           elevation: 0,
            //                           height: 50,
            //                           shape: const Border(
            //                             top: BorderSide(
            //                                 color: Colors
            //                                     .grey), // Borde gris en la parte superior
            //                             right: BorderSide(
            //                                 color: Colors
            //                                     .grey), // Borde gris en el lado derecho
            //                           ),
            //                           color: Colors.white,
            //                           onPressed: () {
            //                             //print('ID Project ${listaProject[index].id }');
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                   builder: (context) =>
            //                                       ListGoalScreen(
            //                                           projectID:
            //                                               listaProject[index]
            //                                                       .id ??
            //                                                   'null'),
            //                                 ));
            //                             // Navigator.pushNamed(context, 'ListGoals');
            //                           },
            //                           child: const Text(
            //                             'ir a  Metas',
            //                             style: TextStyle(color: Colors.black),
            //                           )),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 2,
            //                     child: ClipRRect(
            //                       borderRadius: const BorderRadius.only(
            //                           bottomRight: Radius.circular(20)),
            //                       child: MaterialButton(
            //                         height: 50,
            //                         elevation: 0,
            //                         shape: const Border(
            //                             top: BorderSide(color: Colors.grey)),
            //                         color: Colors.white,
            //                         onPressed: () {},
            //                         child: const Text('Configuraciones',
            //                             style: TextStyle(color: Colors.black)),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ]),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class Drawer extends StatelessWidget {
  const Drawer({
    Key? key,
    this.size,
  }) : super(key: key);
  final size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: size.width * 0.7,
      color: Colors.white,
      child: const Column(children: [
        Header(),
        SizedBox(height: 10),
        Divider(),
        /* 
      
      
      IconButton(onPressed: (){

      }, icon: Row( children: [
        Icon(Icons.poll_rounded),
        Text('Proyectos')
      ]
      )),*/
        //Ti
        // Title(color: Colors.white, child:const  Text('Proyectos')),
        ListTile(
          leading: Icon(Icons.poll_rounded),
          title: Text('Proyectos'),
        )
      ]),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.blue,
      child: Center(
          child: Container(
        height: 90,
        width: 90,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      )),
    );
  }
}

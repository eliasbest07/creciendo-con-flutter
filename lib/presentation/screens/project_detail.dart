import 'package:flutter/material.dart';

import '../../domain/entities/proyecto_entity.dart';

class ProjectDetailScreen extends StatelessWidget {

  const ProjectDetailScreen({Key? key, required this.project}) : super(key: key);
  final Proyecto project;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F9FF),
      appBar: AppBar(
        title: const Text(
          'DETALLE DE PROYECTO',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Container(
                width: double.infinity,
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
                child: Row(
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
                        const Text(
                          'JORGE MORENO GIRALDO',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/625/625394.png',
                              width: 25,
                            ),
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/625/625393.png',
                              width: 25,
                            ),
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/512/625/625393.png',
                              width: 25,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Container(
                width: double.infinity,
                //padding: const EdgeInsets.all(15),
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
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                  title: const Row(
                    children: [
                      Icon(Icons.person_search_rounded),
                      SizedBox(width: 5),
                      Text(
                        'Colaboradores',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(
                      itemCount: 10,//collaborators.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // final collaborator = collaborators[index];

                        // Color? colorEstado;
                        // switch (collaborator['role']) {
                        //   case 'Sublíder':
                        //     colorEstado = Colors.red;
                        //     break;
                        //   case 'Auxiliar':
                        //     colorEstado = Colors.blue;
                        //     break;
                        //   default:
                        // }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   radius: 15,
                              //   backgroundImage:
                              //       NetworkImage(collaborator['photoProfile']),
                              // ),
                              const SizedBox(width: 5),
                              Text('collaboratorname'),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  // color: colorEstado,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text( 'role',
                                  // collaborator['role'],
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Text(
                      'Metas establecidas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                          ),
                          alignment: Alignment.center,
                          child: Text('Meta #$index'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                      itemCount: 6,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Divider(),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Comentarios',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(height: 7),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orangeAccent,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('Comentario #$index'),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 10);
                              },
                              itemCount: 6,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
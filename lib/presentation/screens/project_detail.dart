import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../domain/entities/proyecto/proyecto_entity.dart';
import '../widgets/widgets.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen(
      {Key? key, required this.project, required this.cacheManager})
      : super(key: key);

  final Proyecto project;
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: const Color(0xffF6F9FF),
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
                              color: Colors.yellow),
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
      floatingActionButton: NavBar(
        primaryColor: primaryColor,
        width: width,
      ),
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
              const Padding(
                padding: EdgeInsets.only(left:20.0),
                child: Text('Responsables:',style: TextStyle(fontSize: 16),),
              ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    width: 300,
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
                            child: Text('Lider de Backend',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
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
                                const Text(
                                  'Hugo Grados Changanaqui',
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
                      ],
                    ),
                  ),
                );}
              ),
            ),
                const Padding(
                padding: EdgeInsets.only(left:20.0,top: 20),
                child: Text('Auxiliares:',style: TextStyle(fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Column(
                        children: [
                          CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1176&q=80'),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 60,
                                      child: Text('Nombre Nombre Nombre Nombre'))
                        ],
                      ),
                    );
                  },)
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
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                          ),
                          alignment: Alignment.center,
                          child: Stack(
                            children:  [
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  height:30,
                                  width: double.infinity,
                                  decoration:const BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft:  Radius.circular(20), topRight: Radius.circular(20)),
                                    color: Color.fromARGB(255, 102, 180, 106),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0,top:5 ),
                                    child: Text('2023-06-06'),
                                  ),
                                  ),
                                  SizedBox(height: 30,child: Padding(
                                    padding: const EdgeInsets.only(left:10.0, top:5),
                                    child: Text('2023-07-01'),
                                  ),),
                              ],
                            ), 
                              Positioned(
                                right: 5,
                                top: 5,
                                child: Container(height: 50, width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle, 
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    value: 0.7,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                ),
                              ) 
                            ]
                          )
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
                      const SizedBox(height: 300),
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

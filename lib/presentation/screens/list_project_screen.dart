import 'package:TaskFlow/presentation/dialog/new_project_dialog.dart';
import 'package:TaskFlow/presentation/screens/list_goal_screen.dart';
import 'package:TaskFlow/presentation/widgets/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';

class ListProjectScreen extends ConsumerWidget {
  const ListProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaProject = ref.watch(listaProyectos);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis proyectos'),
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
      floatingActionButton: NavBar(
        primaryColor: Theme.of(context).primaryColor,
        width: size.width,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 103, 159, 228),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                      child: Text(
                    'Soy Lider',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                      child: Text(
                    'Soy Auxiliar',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: size.height * 0.7,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listaProject.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 240, 237, 237),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              offset: Offset(1, 2),
                              color: Color.fromARGB(136, 0, 0, 0))
                        ]),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(listaProject[index].nombre),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.yellow),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                print('ID Project ${listaProject[index].id }');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListGoalScreen(
                                          projectID:
                                              listaProject[index].id ?? 'null'),
                                    ));

                                // Navigator.pushNamed(context, 'ListGoals');
                              },
                              child: const Text(
                                'ir a  Metas',
                                style: TextStyle(color: Colors.white),
                              )),
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: const Text('Configuraciones',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ]),
                  ),
                );
              },
            ),
          ),
        ]),
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

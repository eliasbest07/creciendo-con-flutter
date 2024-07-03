import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/presentation/drawables/filter_icon.dart';
//import 'package:TaskFlow/presentation/screens/goal_detail_screen.dart';
import 'package:TaskFlow/presentation/screens/new_goals_screen.dart';
import 'package:TaskFlow/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';
import 'edit_goals_screen.dart';

class ListGoalScreen extends ConsumerWidget {
  const ListGoalScreen({Key? key, required this.projectID}) : super(key: key);
  final String projectID;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapMeta = ref.watch(listaMetasMyProyecto);

    ProyectoService proyecto = ProyectoService();

    //proyecto.buscarMeta();
    //proyecto.obtenerMetasProyecto(projectID);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 246, 249, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'LISTA DE METAS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewGoalScreen(projectID: projectID),
                    ));
                //Navigator.pushNamed(context, 'newGoal');
              },
              icon: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      // bottomNavigationBar: NavBar(
      //   primaryColor: Theme.of(context).primaryColor,
      //   width: size.width,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Resultados encontrados 05',
                        style: TextStyle(color: Colors.grey)),
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: FilterIcon(),
                        ),
                      ),
                    )
                  ],
                )),
            FutureBuilder(
              // se obtienen las metas del proyecto desde firebase y se guardan en el mapa de riverpod
              future: proyecto.obtenerMetas(projectID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  mapMeta[projectID] = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: mapMeta[projectID]?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // mapMeta[projectID][index]
                                      builder: (context) => EditGoalScreen(
                                          projectID: projectID,
                                          porEditar: mapMeta[projectID]![
                                              index]) // goalID: mapMeta[projectID]?[index].id ?? '',),
                                      ),
                                );
                              },
                              child: Container(
                                width: size.width * 0.8,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(24, 46, 46, 46),
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 5.0,
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.purple,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'UX/UI',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_month_sharp,
                                              color: Color(0xffB9B9B9),
                                              size: 15,
                                            ),
                                            Text(
                                              '00-00-00',
                                              style: TextStyle(
                                                color: Color(0xffB9B9B9),
                                                fontSize: 11,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Container(
                                              width: 7,
                                              height: 7,
                                              decoration: const BoxDecoration(
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
                                            mapMeta[projectID]![index].nombre,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 218, 216, 216),
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
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
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 45,
                                      //color: Colors.red,
                                      child: ListView.builder(
                                        itemCount: 10,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return const CircleAvatar(
                                            backgroundColor: Color(0xffE3E3E3),
                                            radius: 30,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                'https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80',
                                              ),
                                              radius: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}


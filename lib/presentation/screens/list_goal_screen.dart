import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
//import 'package:TaskFlow/presentation/screens/goal_detail_screen.dart';
import 'package:TaskFlow/presentation/screens/new_goals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';
import 'edit_goals_screen.dart';

class ListGoalScreen extends ConsumerWidget {
  const ListGoalScreen({Key? key, required this.projectID}) : super(key: key);
  final String projectID;
  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    final mapMeta = ref.watch(listaMetasMyProyecto);

    ProyectoService proyecto = ProyectoService();

    //proyecto.buscarMeta();
    //proyecto.obtenerMetasProyecto(projectID);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Metas'),
        centerTitle: true,
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
      body: Column(children: [
        const SizedBox(height: 20),
        FutureBuilder( // se obtienen las metas del proyecto desde firebase y se guardan en el mapa de riverpod
          future: proyecto.obtenerMetas(projectID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              mapMeta[projectID]=snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: mapMeta[projectID]?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute( // mapMeta[projectID][index]
                                builder: (context) =>  EditGoalScreen(projectID: projectID,porEditar: mapMeta[projectID]![index])// goalID: mapMeta[projectID]?[index].id ?? '',),
                              ),
                            );
                      },
                      child:Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 255, 245, 216)),child: Text(mapMeta[projectID]?[index].nombre ?? 'No hay metas')
                    ), 
                    )
                  );
                },
              ),
            );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
      ),],),
    );
  }
}

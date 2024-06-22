import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/presentation/screens/new_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/proyecto/meta_entity.dart';
import '../../providers/riverpod_provider.dart';

class EditGoalScreen extends ConsumerWidget {
  const EditGoalScreen(
      {Key? key, required this.projectID, required this.porEditar})
      : super(key: key);
  final String projectID;
  final Meta porEditar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapTarea = ref.watch(listaTareaMyMeta);

    ProyectoService proyecto = ProyectoService();
    print('porEditar: ${porEditar.id}');

    final controllerEdita = ref.watch(editGoal.notifier);
    controllerEdita.nameGoal.text = porEditar.nombre;
    controllerEdita.fechaCreadaController.text =
        porEditar.fechaCreada.toString();
    controllerEdita.fechaEstimadaController.text =
        porEditar.fechaEstablecida.toString();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDITAR META',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lista de Tareas'),
            const Text(
              'Nombre:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              controller: controllerEdita.nameGoal,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                hintText: 'Ingresar nombre',
                suffixIcon: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Tipo:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   activeUI = !activeUI;
                      //   activeFront = false;
                      //   activeBack = false;
                      // });
                      // controllerMeta.setType('UI');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: true //listMeta?.last.item == 'UI'
                              ? Colors.blue
                              : Colors
                                  .transparent, // TODO este es el campo, se obtiene de una lista desde el backend
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('UI'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // controllerMeta.setType('FRONT');
                      // setState(() {
                      //   activeUI = false;
                      //   activeFront = !activeFront;
                      //   activeBack = false;
                      // });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: true //listMeta?.last.item == 'FRONT'
                              ? Colors.blue
                              : Colors
                                  .transparent, // TODO este es el campo, se obtiene de una lista desde el backend
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('FRONT'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //controllerMeta.setType('BACK');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: true //listMeta?.last.item == 'BACK'
                              ? Colors.blue
                              : Colors
                                  .transparent, // TODO este es el campo, se obtiene de una lista desde el backend
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('BACK'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Fecha de creación:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              controller: controllerEdita.fechaCreadaController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                  // setState(() {
                  //   _fechaInicioController.text=formattedDate.toString();
                  // });
                } //when click we have to show the datepicker
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Fecha de culminación:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              controller: controllerEdita.fechaEstimadaController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                  // setState(() {
                  //   _fechaInicioController.text=formattedDate.toString();
                  // });
                } //when click we have to show the datepicker
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Lista de tareas:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            SizedBox(
              height: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTaskScreen(
                              descripcion: '',
                              fechaEstablecida: null,
                              fechaInicio: null,
                              metaId: porEditar.id!,
                              name: '',
                              prioridad: 0,
                              proyectoId: projectID,
                            ) // goalID: mapMeta[projectID]?[index].id ?? '',),
                        ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 65, 170, 255),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'AGREGAR',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: size.height * 0.15,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FutureBuilder(
                    // se obtienen las tareas de la meta desde firebase y se guardan en el mapa de riverpod
                    future: proyecto.obtenerTareas(
                        porEditar.id!, projectID), // porEditar
                    builder: (context, snapshot) {
                      print('data : $snapshot');
                      if (snapshot.hasData) {
                        mapTarea[porEditar.id!] = snapshot.data!;
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mapTarea[porEditar.id!]?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          // mapMeta[projectID][index]
                                          //al tocar en una tarea, abro pantalla con los datos cargados de esa tarea
                                          //al ser una lista de tareas, los valores serán respecto al index de esa lista de tareas

                                          //hay que estimar como pasar estos datos, que ya me entrega firebase
                                          builder: (context) => NewTaskScreen(
                                            descripcion:
                                                mapTarea[porEditar.id!]![index]
                                                    .descripcion,
                                            proyectoId: projectID,
                                            name:
                                                mapTarea[porEditar.id!]![index]
                                                    .nombre,
                                            fechaEstablecida:
                                                mapTarea[porEditar.id!]![index]
                                                    .fechaEstablecida,
                                            fechaInicio:
                                                mapTarea[porEditar.id!]![index]
                                                    .fechaCreada,
                                            metaId: porEditar.id!,
                                            prioridad:
                                                mapTarea[porEditar.id!]![index]
                                                    .prioridad,
                                            isEdit: true,
                                            fromMeta: porEditar,
                                            tareaId:
                                                mapTarea[porEditar.id!]![index]
                                                    .id!,
                                          ),
                                          //descripcion: mapTarea[projectID]![index].descripcion , fechaEstablecida: mapTarea[projectID]![index].fechaEstablecida , fechaInicio: mapTarea[projectID]![index].fechaCreada, metaId: porEditar.id!, name: mapTarea[projectID]![index].nombre, prioridad: mapTarea[projectID]![index].nivel , proyectoId: projectID,)// goalID: mapMeta[projectID]?[index].id ?? '',),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        height: 100,
                                        width: 250,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Color.fromARGB(
                                                255, 255, 245, 216)),
                                        child: Text(mapTarea[porEditar.id!]
                                                    ?[index]
                                                .nombre ??
                                            'No hay metas')),
                                  ));
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "${snapshot.error}",
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
              /* ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        
                        width: 150,
                        color: Colors.red,
                        child: Column(children: [
                      /*     //nommbre, 
                                    Text(
                        'Nombre: \n${controllerEdita.nameGoal}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                     //fecha establecida, 

                       Text(
                        'Fecha de creación:\n${controllerEdita.fechaCreadaController}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      //fecha final
                       Text(
                          'Fecha de culminación:${controllerEdita.fechaEstimadaController}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ), */
                      ],)
                      ),
                    );
                  },
                ) */
            ),
          ],
        ),
      ),
    );
  }
}

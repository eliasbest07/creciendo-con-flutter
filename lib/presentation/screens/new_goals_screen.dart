//import 'package:TaskFlow/domain/repositories/proyecto_repository.dart';
import 'package:TaskFlow/infrastructure/services/acortadores_string.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/presentation/screens/list_task_screen.dart';
import 'package:TaskFlow/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/proyecto/meta_entity.dart';
import '../../domain/entities/proyecto/tarea_entity.dart';
import '../../providers/riverpod_provider.dart';

class NewGoalScreen extends ConsumerWidget {
  const NewGoalScreen({Key? key, required this.projectID}) : super(key: key);
  final String projectID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerMeta = ref.watch(listaMetasMyProyecto.notifier);
    final mapMeta = ref.watch(listaMetasMyProyecto);
    final listTarea = ref.watch(listaTareasNueMeta);
    controllerMeta.addProyecto(projectID);
    if (mapMeta[projectID] == null) {
      mapMeta[projectID] != [];
    }
    final listMeta = mapMeta[projectID];

    ProyectoService proyecto = ProyectoService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NUEVA META',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //saving goal object
              // validar que ingreso un nombre
              // validar que selecion un tipo controllerMeta.type
              // validar que selecion una fecha de comienzo
              // validar que selecion una fecha de fin

              bool camposCompletos = false;

              if (controllerMeta.nameGoal.text.isEmpty ||
                  controllerMeta.type == '' ||
                  controllerMeta.fechaCreada == null ||
                  controllerMeta.fechaEstablecida == null) {
                camposCompletos = false;
                Fluttertoast.showToast(
                  msg: "Debes llenar todos los campos", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.BOTTOM, // location
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Meta guardada con éxito", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.BOTTOM, // location
                );
                Navigator.pop(context);
                camposCompletos = true;
              }

              if (camposCompletos) {
                Meta meta = Meta(
                    nombre: controllerMeta.nameGoal.text,
                    item: controllerMeta.type,
                    proyectoID: projectID,
                    fechaCreada: controllerMeta.fechaCreada,
                    fechaEstablecida: controllerMeta.fechaEstablecida,
                    listTarea: listTarea
                    // [
                    //   Tarea(
                    //     id: 'IDTareaEliasBest',
                    //     nombre: 'Tarea 1',
                    //     descripcion: 'Tarea 1 de prueba',
                    //     listComentarioTarea: [],
                    //     usuarioAsignado: '',
                    //     fechaCreada: DateTime.now(),
                    //     fechaEstablecida: DateTime.now(),
                    //     estado: 'En espera',
                    //     nivel: 2,
                    //   ),
                    //   Tarea(
                    //     id: 'IDTareaEliasBest2',
                    //     nombre: 'Tarea 2',
                    //     descripcion: 'Tarea 2 de prueba',
                    //     listComentarioTarea: [],
                    //     usuarioAsignado: '',
                    //     fechaCreada: DateTime.now(),
                    //     fechaEstablecida: DateTime.now(),
                    //     estado: 'En espera',
                    //     nivel: 1,
                    //   ),
                    // ],
                    );
                listMeta?.add(meta);
                proyecto.guardarMeta(projectID, meta);
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              controller: controllerMeta.nameGoal,
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
                      controllerMeta.setType('UI');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: listMeta?.last.item == 'UI'
                              ? Colors.blue
                              : Colors.transparent,
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
                      controllerMeta.setType('FRONT');
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
                          color: listMeta?.last.item == 'FRONT'
                              ? Colors.blue
                              : Colors.transparent,
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
                      controllerMeta.setType('BACK');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: listMeta?.last.item == 'BACK'
                              ? Colors.blue
                              : Colors.transparent,
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
              controller: controllerMeta.fechaCreadaController,
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
                  controllerMeta.fechaCreada = pickedDate;
                  controllerMeta.fechaCreadaController.text =
                      controllerMeta.fechaCreada.toString();
                } //when click we have to show the datepickpickedDateer
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
              controller: controllerMeta.fechaEstimadaController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  Acortador acortarFecha = Acortador();
                  controllerMeta.fechaEstablecida = pickedDate;
                  // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                  // setState(() {
                  //   _fechaInicioController.text=formattedDate.toString();
                  // });
                  controllerMeta.fechaEstimadaController.text = acortarFecha
                      .getFirstWord(controllerMeta.fechaEstablecida.toString());
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
                        proyectoId: projectID,
                      ), // metaID: metaID
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ListTaskScreen(), // metaID: metaID
                  //   ),
                  // );
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
/*             const SizedBox(height: 15),
            const Text(
              'Lista de comentarios:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            SizedBox(
              child: true
                  ? Container(
                      height: 60,
                      width: double.infinity,
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
                    )
                  // ignore: dead_code
                  : SizedBox(
                      height: 80,
                      child: ListView.separated(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container(
                              height: 90,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                // borderRadius: borderRadius,
                                color: Color.fromARGB(255, 65, 170, 255),
                              ),
                              child: const Column(
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
                            );
                          }
                          return GestureDetector(
                            onLongPress: () {
                              // setState(() {
                              // comentarios.removeAt(index - 1);
                              // });
                              // print(comentarios.length);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                // borderRadius: borderRadius,
                                color: Color(0xfff0f0f0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Comentario $index :'),
                                  const SizedBox(height: 5),
                                  // Text(comentarios[index - 1], maxLines: 2),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                      ),
                    ),
            ),
           */
          ],
        ),
      ),
    );
  }
}

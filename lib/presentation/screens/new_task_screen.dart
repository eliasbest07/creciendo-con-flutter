import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/riverpod_provider.dart';

class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen(
      {Key? key, required this.proyectoId, required this.metaId, required this.name, required this.descripcion, required this.fechaInicio, required this.fechaEstablecida, required this.prioridad})
      : super(key: key);
  final String proyectoId;
  final String metaId;
  final String name;
  final String descripcion;
  final DateTime? fechaInicio;
  final DateTime? fechaEstablecida;
  final int prioridad;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTaskController = ref.watch(newTask.notifier);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController controllerNombre = TextEditingController();
    final TextEditingController controllerDescription = TextEditingController();
    final TextEditingController controllerPrioridad =
        TextEditingController(); // por cambiar

    ProyectoService proyecto = ProyectoService();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nueva Tarea',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('true');
                  crearTarea(
                          _formKey,
                          context,
                          controllerNombre.text,
                          controllerDescription.text,
                          newTaskController.convertirFecha(
                              newTaskController.controllerFechaInicio.text),
                          newTaskController.convertirFecha(newTaskController
                              .controllerFechaEstablecida.text),
                          int.parse(controllerPrioridad.text));
                }
              },
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: controllerNombre,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.task),
                      hintText: 'Ingrese un nombre.',
                      labelText: 'Nombre *',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa el nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controllerDescription,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Ingrese una descripción.',
                      labelText: 'Descripción *',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa una descripcion';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: newTaskController.controllerFechaInicio,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese una Fecha de Inicio';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.date_range), //icon of text field
                        labelText: 'Fecha Inicio *',
                        hintText: 'Seleccione una fecha' //label text of field
                        ),

                    readOnly: true, // when true user cannot edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat("dd/MM/yyyy").format(pickedDate);
                        newTaskController.controllerFechaInicio.text =
                            formattedDate.toString();
                        newTaskController.actualizarEstado(true); //setState
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                      controller: newTaskController.controllerFechaEstablecida,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese una Fecha de Culminacion';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.date_range), //icon of text field
                          labelText: 'Fecha Establecida *',
                          hintText: 'Seleccione una fecha' //label text of field
                          ),
                      readOnly: true, // when true user cannot edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                            String formattedDate =
                            DateFormat("dd/MM/yyyy").format(pickedDate);
                        newTaskController.controllerFechaEstablecida.text =
                            formattedDate.toString();
                        newTaskController.actualizarEstado(true); //setState
                        } //when click we have to show the datepicker
                      }),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   controller: TextEditingController(),//_estadoController,
                  //   decoration: const InputDecoration(
                  //     icon: Icon(Icons.check_box),
                  //     labelText: 'Estado',
                  //     hintText: 'Ingrese estado.',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Por favor, seleccione un estado';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: controllerPrioridad,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.rocket_launch),
                      labelText: 'Prioridad',
                      hintText: 'Ingrese un nivel.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese un nivel';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 26.0),
                  ElevatedButton(
                    onPressed: () {
                      crearTarea(
                          _formKey,
                          context,
                          controllerNombre.text,
                          controllerDescription.text,
                          newTaskController.convertirFecha(
                              newTaskController.controllerFechaInicio.text),
                          newTaskController.convertirFecha(newTaskController
                              .controllerFechaEstablecida.text),
                          int.parse(controllerPrioridad.text));
                    },
                    child: const Text('Crear Tarea'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void crearTarea(
      formKey,
      BuildContext context,
      String nombreTarea,
      String descripcion,
      DateTime fechaInicio,
      DateTime fechaEstablecida,
      int nivel) {

        final size = MediaQuery.of(context).size;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      //enviar datos a firebase
      ProyectoService proyecto = ProyectoService();

      Tarea tarea = Tarea(
          nombre: nombreTarea,
          descripcion: descripcion,
          fechaCreada: fechaInicio,
          fechaEstablecida: fechaEstablecida,
          estado: 'nueva',
          nivel: nivel);

      proyecto.guardarTarea(proyectoId, metaId, tarea);

      /*
                Meta meta = Meta(
                  nombre: controllerMeta.nameGoal.text,
                  item: controllerMeta.type,
                  proyectoID: projectID,
                  fechaCreada: controllerMeta.fechaCreada,
                  fechaEstablecida: controllerMeta.fechaEstablecida,
                );
                listMeta?.add(meta);
                proyecto.guardarMeta(projectID, meta);

      */
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
              child: Align(
                  alignment: Alignment.center,
                  child: Material(
                    child: Container(
                      width: size.width*0.45,
                      height: size.height*0.15,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child:  Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¡Se creo la tarea! '),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: MaterialButton(
                                  elevation: 3,
                                  color:Theme.of(context).primaryColor,
                                onPressed: (){Navigator.pop(context); Navigator.pop(context);},
                                child: const Text('Continuar', style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))));
    }
  }
}

import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/presentation/screens/edit_goals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/riverpod_provider.dart';

class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen(
      {Key? key,
      required this.proyectoId,
      this.metaId,
      this.name,
      this.descripcion,
      this.fechaInicio,
      this.fechaEstablecida,
      this.prioridad,
      this.isEdit = false,
      this.tareaId = '',
      this.fromMeta})
      : super(key: key);

  final String proyectoId;
  final String? metaId;
  final String? name;
  final String? descripcion;
  final DateTime? fechaInicio;
  final DateTime? fechaEstablecida;
  final int? prioridad;
  final bool isEdit;
  final Meta? fromMeta;
  final String tareaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTaskController = ref.watch(newTask.notifier);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController controllerNombre = TextEditingController();
    final TextEditingController controllerDescription = TextEditingController();
    final TextEditingController controllerPrioridad =
        TextEditingController(); // por cambiar
    final listTarea = ref.watch(listaTareasNueMeta);

    print('este es el ID de una nueva META aun no guardad $metaId');

    if (isEdit) {
      controllerNombre.text = name!;
      controllerDescription.text = descripcion!;
      controllerPrioridad.text = '$prioridad';

      newTaskController.controllerFechaInicio.text = fechaInicio.toString();
      newTaskController.controllerFechaEstablecida.text =
          fechaEstablecida.toString();
    } else {
      String comienzo = DateFormat('d/M/yyyy h:mm a').format(DateTime.now());
      String fechafinal = DateFormat('d/M/yyyy h:mm a')
          .format(DateTime.now().add(const Duration(hours: 1)));
      newTaskController.controllerFechaInicio.text = comienzo;
      newTaskController.controllerFechaEstablecida.text = fechafinal;
    }

    //ProyectoService proyecto = ProyectoService();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? 'Editar Tarea' : 'Nueva Tarea',
            style: const TextStyle(
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
                  // verificar si la meta se esta creando nueva

                  if (metaId == null) {
                    ref.read(listaTareasNueMeta.notifier).update(
                          (state) => [
                            Tarea(
                              nombre: controllerNombre.text,
                              descripcion: controllerDescription.text,
                              fechaCreada: newTaskController.convertirFecha(
                                  newTaskController.controllerFechaInicio.text),
                              fechaEstablecida: newTaskController
                                  .convertirFecha(newTaskController
                                      .controllerFechaEstablecida.text),
                              estado: 'nueva',
                              nivel: int.parse(controllerPrioridad.text),
                            ),
                            ...state
                          ],
                        );
                  } else {
                    crearTarea(
                        _formKey,
                        context,
                        controllerNombre.text,
                        controllerDescription.text,
                        newTaskController.convertirFecha(
                            newTaskController.controllerFechaInicio.text),
                        newTaskController.convertirFecha(
                            newTaskController.controllerFechaEstablecida.text),
                        int.parse(controllerPrioridad.text));
                  }

                  //  = [ ,...listTarea];
                  // listTarea.add();
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
                      if (isEdit) {
                        Tarea tarea = Tarea(
                            id: tareaId,
                            nombre: controllerNombre.text,
                            descripcion: controllerDescription.text,
                            fechaCreada: DateTime.parse(
                                newTaskController.controllerFechaInicio.text),
                            fechaEstablecida: DateTime.parse(newTaskController
                                .controllerFechaEstablecida.text),
                            estado: 'nueva',
                            nivel: int.parse(controllerPrioridad.text));

                        actualizarTarea(tarea, context);
                      } else {
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
                    child: Text(isEdit ? 'Actualizar' : 'Crear'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void actualizarTarea(
    Tarea tarea,
    BuildContext context,
  ) {
    ProyectoService proyecto = ProyectoService();
    proyecto.actualizarTarea(proyectoId, metaId!, tarea);

    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: Align(
                alignment: Alignment.center,
                child: Material(
                    child: Container(
                        width: size.width * 0.45,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('¡Se Actualizo la tarea! '),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: MaterialButton(
                                              elevation: 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                //Navigator.pop(context); se hace push replacement para llegar a la pantalla de editar meta con valores actualizados
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditGoalScreen(
                                                              projectID:
                                                                  proyectoId,
                                                              porEditar:
                                                                  fromMeta!),
                                                    ));
                                              },
                                              child: const Text('Continuar',
                                                  style: TextStyle(
                                                      color: Colors.white))))
                                    ]))))))));
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
        nivel: nivel,
      );
      print('este es el ID de una nueva META aun no guardad $metaId');
      proyecto.guardarTarea(proyectoId, metaId!, tarea);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
              child: Align(
                  alignment: Alignment.center,
                  child: Material(
                    child: Container(
                      width: size.width * 0.45,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
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
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Continuar',
                                    style: TextStyle(color: Colors.white),
                                  ),
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

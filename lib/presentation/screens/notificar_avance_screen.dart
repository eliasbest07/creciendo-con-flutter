import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:TaskFlow/domain/entities/proyecto/usuarioProyecto_entity.dart';
import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:TaskFlow/providers/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificarAvanceScreen extends ConsumerWidget {
  final Tarea actualizarTarea;
  final Meta meta;
  final List<UsuariosProyecto> listaLideres;

  NotificarAvanceScreen(
      {super.key,
      required this.listaLideres,
      required this.meta,
      required this.actualizarTarea});

  final List<String> estadosList = [
    'Recién creada',
    'Tomada',
    'En pausa',
    'Desistida',
    'Avanzada',
    'Terminada',
  ];

  final TextEditingController descripInput = TextEditingController();

  //TODO: La variable estadoSelected debe inicialzarse a como esté en firebase

  String estadoSelected = 'Recién creada';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actualizarEstadoTarea = ref.watch(tareaEstado);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Notificar avance',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Al Lider:'),
              DropdownButton<String>(
                isExpanded: true,
                value: listaLideres[0].nombre,
                icon: const Icon(Icons.arrow_circle_down_sharp,
                    color: Colors.black), // Cambia el color del ícono a negro
                elevation: 8,
                style: TextStyle(
                    color: Colors.black), // Cambia el color del texto a negro
                onChanged: (String? value) {},
                items: listaLideres.map((user) {
                  return DropdownMenuItem(
                    value: user.nombre,
                    child: Text(user.nombre),
                  );
                }).toList(),
                // items:
                //     liderProyecto.map<DropdownMenuItem<String>>((String value) {
                //   return DropdownMenuItem<String>(
                //     value: value,
                //     child: Text(value),
                //   );
                // }).toList(),
              ),
              // FutureBuilder(
              //   future: ProyectoService().obtenerLiderProyecto(
              //       tareaUsuario == null
              //           ? poryectID!
              //           : tareaUsuario!.proyectoId),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       print(snapshot.error);
              //     }
              //     if (snapshot.hasData) {
              //       print('snapshot.data');
              //       print(snapshot.data);
              //       return Container(
              //         padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              //         decoration: BoxDecoration(
              //           color:
              //               Colors.white, // Cambia el color de fondo a blanco
              //           border: Border.all(
              //               color:
              //                   Colors.black), // Añade un borde de color negro
              //           borderRadius: BorderRadius.circular(
              //               10), // Añade bordes redondeados
              //         ),
              //         child: DropdownButtonHideUnderline(
              //           // Oculta la línea subrayada
              //           child: DropdownButton<String>(
              //             isExpanded: true,
              //             value: liderProyecto[0],
              //             icon: const Icon(Icons.arrow_circle_down_sharp,
              //                 color: Colors
              //                     .black), // Cambia el color del ícono a negro
              //             elevation: 8,
              //             style: TextStyle(
              //                 color: Colors
              //                     .black), // Cambia el color del texto a negro
              //             onChanged: (String? value) {},
              //             items: liderProyecto
              //                 .map<DropdownMenuItem<String>>((String value) {
              //               return DropdownMenuItem<String>(
              //                 value: value,
              //                 child: Text(value),
              //               );
              //             }).toList(),
              //           ),
              //         ),
              //       );
              //     }

              //     return const Center(child: CircularProgressIndicator());
              //   },
              // ),
              DropdownButtonFormField<String>(
                value: estadoSelected,
                onChanged: (newValue) {
                  //para que se redibuje
                  ref.read(tareaEstado.notifier).state = newValue!;
                },
                items: estadosList.map((estado) {
                  return DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  icon: Icon(Icons.star_rate),
                  labelText: 'Estado',
                  hintText: 'Elige un estado',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona un estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text('Mensaje:'),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descripInput,
                maxLines: 5,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        actualizarTarea.estado = actualizarEstadoTarea;
                        ProyectoService proyecto = ProyectoService();
                        proyecto.actualizarTarea(
                            meta.proyectoID, meta.id!, actualizarTarea);

                        // crear metodo para actualizar en proyecto/idproyecto/listMeta/idmeta/listTarea/idtarea

                        Fluttertoast.showToast(
                          msg: 'Avance notificado',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

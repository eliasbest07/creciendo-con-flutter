import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/proyecto/tarea_usuario_entity.dart';
import '../../infrastructure/services/proyecto_service.dart';

class NotificarAvanceScreen extends ConsumerWidget {
  const NotificarAvanceScreen({super.key, this.tareaUsuario, this.poryectID});
  final TareaUsuario? tareaUsuario;
  final String? poryectID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<String> liderProyecto = <String>[
      'Carlos',
      'Elias',
      'Jorg',
      'Hugo'
    ];
    final TextEditingController descripInput = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Notificar avance',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Al Lider:'),
              FutureBuilder(
                future: ProyectoService().obtenerLiderProyecto(
                    tareaUsuario == null
                        ? poryectID!
                        : tareaUsuario!.proyectoId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    print('snapshot.data');
                    print(snapshot.data);
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Cambia el color de fondo a blanco
                        border: Border.all(
                            color:
                                Colors.black), // Añade un borde de color negro
                        borderRadius: BorderRadius.circular(
                            10), // Añade bordes redondeados
                      ),
                      child: DropdownButtonHideUnderline(
                        // Oculta la línea subrayada
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: liderProyecto[0],
                          icon: const Icon(Icons.arrow_circle_down_sharp,
                              color: Colors
                                  .black), // Cambia el color del ícono a negro
                          elevation: 8,
                          style: TextStyle(
                              color: Colors
                                  .black), // Cambia el color del texto a negro
                          onChanged: (String? value) {},
                          items: liderProyecto
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
             
                  return const Center(child: CircularProgressIndicator());
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
                      onPressed: () {},
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

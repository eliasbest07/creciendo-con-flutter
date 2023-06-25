import 'package:flutter/material.dart';

import '../../domain/entities/tarea_entity.dart';

class TaskDetailScreen extends StatelessWidget {
  final Tarea tarea;

  const TaskDetailScreen({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
    Color? colorEstado;
    switch (tarea.estado) {
      case 'En proceso':
        colorEstado = Colors.amber;
        break;
      case 'Revisión':
        colorEstado = Colors.red;
        break;
      case 'Terminado':
        colorEstado = Colors.green;
        break;
      case 'Avanzado':
        colorEstado = Colors.orange;
        break;
      default:
    }

    return Scaffold(
      backgroundColor: const Color(0xffF6F9FF),
      appBar: AppBar(
        title: Text(
          'DETALLES DE ${tarea.nombre.toUpperCase()}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const CircleAvatar(
                            child: Icon(Icons.person), radius: 30),
                        const SizedBox(width: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'JORGE MORENO GIRALDO',
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              //height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Estado',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Chip(
                                label: Text(
                                  tarea.estado,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: colorEstado,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Nivel',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  tarea.nivel.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha de creación',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '01/06/2023',
                              ),
                            ],
                          ),
                          const SizedBox(height: 17.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fecha de culminación',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '27/06/2023',
                              ),
                            ],
                          ),
                        ],
                      )),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Descripción',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Text(tarea.descripcion),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15.0),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: 300,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Text('COMENTARIO $index'),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}

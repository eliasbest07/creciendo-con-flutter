import 'package:flutter/material.dart';

import '../../domain/entities/proyecto/tarea_entity.dart';
import 'screens.dart';

class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF6F9FF),
      appBar: AppBar(
        title: const Text(
          'DETALLES DE META',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Otros elementos de Detalle de Meta
            const Placeholder(
              fallbackHeight: 300,
            ),
            // Otros elementos de Detalle de Meta
            const SizedBox(height: 20),
            //Título mis tareas
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'MIS TAREAS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            //Lista de tareas de la meta
            SizedBox(
              height: size.height * .16,
              child: ListView.separated(
                itemCount: Tarea.listaTarea.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15.0),
                itemBuilder: (_, index) {
                  final tarea = Tarea.listaTarea[index];

                  return TaskCardWidget(
                    size: size,
                    tarea: tarea,
                    //colorEstado: colorEstado,
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

class TaskCardWidget extends StatelessWidget {
  final Size size;
  final Tarea tarea;

  const TaskCardWidget({
    super.key,
    required this.size,
    required this.tarea,
  });

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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(tarea: tarea),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: size.width * .7,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tarea.nombre),
                  Text(
                    tarea.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          tarea.estado,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: colorEstado,
                      ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 15,
                        child: Text(
                          tarea.nivel.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
              padding: const EdgeInsets.only(left: 5),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

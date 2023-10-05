import 'package:TaskFlow/domain/entities/proyecto/tarea_entity.dart';
import 'package:flutter/material.dart';

class CardTarea extends StatelessWidget {
  const CardTarea({
    super.key,
    required this.size,
    required this.listTarea, required this.index,
  });

  final Size size;
  final List<Tarea> listTarea;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(74, 46, 46, 46),
              offset: Offset(0.0, 2.0),
              blurRadius: 7.0,
            )
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 8.0, right: 20, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.75,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listTarea[index].nombre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text('Estado:',
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 10),
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 2, left: 10, bottom: 2, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: listTarea[index].estado == 'en proceso'
                                      ? const Color.fromARGB(255, 190, 113, 25)
                                      : Theme.of(context).primaryColor),
                              child: Text(
                                listTarea[index].estado,
                                style: const TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    ]),
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      shape: BoxShape.circle),
                ),
              )
            ],
          ),
        ));
  }
}
import 'package:flutter/material.dart';

class ListTaskScreen extends StatelessWidget {
  const ListTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'newTask');
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
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.green,
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}

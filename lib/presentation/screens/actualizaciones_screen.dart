import 'package:flutter/material.dart';

class Actualizaciones extends StatelessWidget {
  const Actualizaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('ACTUALIZACIONES',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: const Column(
          children: [Text('Estos son los ultimos mensajes recibidos')],
        ));
  }
}

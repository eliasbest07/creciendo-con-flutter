//import 'package:TaskFlow/infrastructure/services/proyecto_service.dart';
import 'package:flutter/material.dart';

import '../../controllers/animation_controller.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({
    super.key,
    required this.size,
    required this.controllerAnim,
  });

  final Size size;
  final AnimController controllerAnim;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.12,
        ),
        const Text(
          'TaskFlow',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.08,
        ),
        SizedBox(height: size.height * 0.05),
        MaterialButton(
          onPressed: () {
            controllerAnim.controllerLogin.reset();
            controllerAnim.controllerLogin.forward();
          },
          color: Colors.white,
          elevation: 5,
          child: const Text('Iniciar Sesión'),
        ),
        SizedBox(height: size.height * 0.05),
        const Text('¿No estás registrado aún?'),
        SizedBox(height: size.height * 0.001),
        TextButton(
            onPressed: () async {
              controllerAnim.controllerRegister.reset();
              controllerAnim.controllerRegister.forward();
            },
            child: const Text('Regístrate aquí'))
      ],
    );
  }
}

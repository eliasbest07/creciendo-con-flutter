import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../controllers/animation_controller.dart';

class MensajeError extends StatelessWidget {
  const MensajeError({
    super.key,
    required this.controllerAnim,
    required this.mensajeError,
  });

  final AnimController controllerAnim;
  final String mensajeError;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      animate: false,
      controller: (controller) {
        controllerAnim.showMensaje = controller;
      },
      child: Container(
        color: const Color.fromARGB(105, 0, 0, 0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(mensajeError),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.black,
                  onPressed: () {
                    controllerAnim.showMensaje.reverse();
                  },
                  child: const Text(
                    'ok',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../controllers/animation_controller.dart';

class Cargando extends StatelessWidget {
  const Cargando({
    super.key,
    required this.controllerAnim,
  });

  final AnimController controllerAnim;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      animate: false,
      controller: (controller) {
        controllerAnim.showalerta = controller;
      },
      child: Container(
        color: const Color.fromARGB(105, 0, 0, 0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

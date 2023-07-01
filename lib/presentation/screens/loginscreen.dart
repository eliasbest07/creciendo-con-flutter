import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/animation_controller.dart';
import '../controllers/login_controller.dart';
import '../../providers/riverpod_provider.dart';
import '../widgets/widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final LoginController controllerLogin =
        ref.watch(loginController.notifier); //Riverpod
    final AnimController controllerAnim = ref.watch(animationController
        .notifier); // Riverpod clase de los objetos de animacion
    final bool verClave = ref.watch(
        showClave); // Riverpod primitiva para mostrar la clave Inicio Sesion
    final String mostrarMensaje =
        ref.watch(showMensaje); // Riverpod para el mensaje dinamico de error
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          // es un Stack porque se muestra por encima el widget que contiene los inptus
          Background(
              size:
                  size), // en registro y login, se muestran por una animacion del paquete anime_do 2.1.0
          BackdropFilter(
              // efecto Glassmorphismo del fondo
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SingleChildScrollView(
                // es para evitar overflow
                physics:
                    const NeverScrollableScrollPhysics(), // para que no haga scroll
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    alignment: AlignmentDirectional.center, // que este centrado
                    children: [
                      PantallaPrincipal(
                          // aqui esta el titulo y los botones del comienzo
                          size: size,
                          controllerAnim: controllerAnim),
                      CuadroInicioSesion(
                          // esto es lo que aparece al darle al boton de Iniciar Sesion
                          ref: ref,
                          verClave: verClave,
                          controllerAnim:
                              controllerAnim, // control de animacion ( apertura y cierre )
                          size: size,
                          controllerLogin: controllerLogin),
                      CuadroRegistro(
                          // esto es lo que aparece al darle al boton de Registrar
                          ref: ref,
                          controllerAnim:
                              controllerAnim, // control de animacion ( apertura y cierre )
                          size: size,
                          controllerLogin: controllerLogin),
                      Cargando(
                          // aqui se muestra el Circula Progress y se quita si hay un error
                          controllerAnim: controllerAnim), // Cuadro de cargando
                      MensajeError(
                          // este es el mensaje que aparece con un boton de ok para cerrar
                          mensajeError: mostrarMensaje,
                          controllerAnim: controllerAnim)
                    ],
                  ),
                ),
              )),
        ]));
  }

}

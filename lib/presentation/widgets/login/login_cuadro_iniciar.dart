import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/riverpod_provider.dart';
import '../../controllers/animation_controller.dart';
import '../../controllers/login_controller.dart';

class CuadroInicioSesion extends StatelessWidget {
  const CuadroInicioSesion({
    super.key,
    required this.controllerAnim,
    required this.size,
    required this.controllerLogin,
    required this.verClave,
    required this.ref,
  });

  final AnimController controllerAnim;
  final Size size;
  final LoginController controllerLogin;
  final bool verClave;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: FadeInUpBig(
        animate: false,
        controller: (animacionControl) {
          controllerAnim.controllerLogin = animacionControl;
        },
        child: Container(
          height: size.height * 0.78,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(155, 118, 118, 118),
                  offset: Offset(-2, -2),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.015),
                CerrarCuadroInicioSesion(controllerAnim: controllerAnim),
                SizedBox(height: size.height * 0.020),
                const Text('Iniciar Sesión', style: TextStyle(fontSize: 20)),
                SizedBox(height: size.height * 0.040),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 81, 80, 80),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 118, 118, 118),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          offset: Offset(-1, -1),
                          blurRadius: 3,
                          spreadRadius: 3,
                        )
                      ]),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                            controller: controllerLogin.inputControllerEmail,
                            maxLines: 1,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Correo'),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.030),
                Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 61, 60, 60),
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 118, 118, 118),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset(-1, -1),
                            blurRadius: 3,
                            spreadRadius: 3,
                          )
                        ]),
                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 20.0),
                          child: SizedBox(
                            width: 185,
                            child: TextFormField(
                                controller:
                                    controllerLogin.inputControllerPassword,
                                maxLines: 1,
                                autocorrect: false,
                                obscureText: verClave,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Clave'),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                )),
                          ),
                        ),
                        Positioned(
                          right: 2,
                          child: IconButton(
                            splashRadius: 20,
                            icon: verClave
                                ? const Icon(Icons.remove_red_eye_sharp)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              ref.read(showClave.notifier).state = !verClave;
                            },
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: size.height * 0.040),
                MaterialButton(
                  color: Colors.black,
                  splashColor: Colors.white,
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    //controller.inicio(context);
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(controllerLogin.inputControllerEmail.text)) {
                      ref.read(showMensaje.notifier).state =
                          'No es un correo valido';
                      controllerAnim.showMensaje.reset();
                      controllerAnim.showMensaje.forward();
                      return;
                    }
                    if (controllerLogin.inputControllerPassword.text.length <
                        6) {
                      ref.read(showMensaje.notifier).state =
                          'La clave debe ser mayor a 6 digitos 🧐';
                      controllerAnim.showMensaje.reset();
                      controllerAnim.showMensaje.forward();
                      return;
                    }
                    controllerAnim.showalerta.reset(); //desde el inicio
                    controllerAnim.showalerta
                        .forward(); // comienza la animacion de cargando
                    final isLogin = await controllerLogin.inciarSesion();
                    if (context.mounted && isLogin) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      if (!isLogin) {
                        controllerAnim.showalerta.reverse();
                        ref.read(showMensaje.notifier).state =
                            'Usuario o clave incorrectos 🚿';
                        controllerAnim.showMensaje.reset();
                        controllerAnim.showMensaje.forward();
                      } else {
                        controllerAnim.showalerta.reverse();
                        ref.read(showMensaje.notifier).state =
                            'Sucedió un error, Intenta de nuevo 😉';
                        controllerAnim.showMensaje.reset();
                        controllerAnim.showMensaje.forward();
                      }
                    }
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: size.height * 0.030),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 40,
                      color: const Color.fromARGB(155, 61, 60, 60),
                    ),
                    const Text('tambien puedes iniciar con'),
                    Container(
                      height: 1,
                      width: 40,
                      color: const Color.fromARGB(155, 61, 60, 60),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.030),
                GestureDetector(
                  onTap: () async {
                    controllerAnim.showalerta.reset(); //desde el inicio
                    controllerAnim.showalerta.forward();
                    try {
                      await controllerLogin.iniciarConGoogle();
                    } catch (e) {
                      controllerAnim.showalerta.reverse();
                      ref.read(showMensaje.notifier).state = e.toString();
                      controllerAnim.showMensaje.reset();
                      controllerAnim.showMensaje.forward();
                    }

                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, 'home');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 61, 60, 60),
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 118, 118, 118),
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset(-1, -1),
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Center(child: Image.asset('assets/google_logo.png')),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.050),
                const Text('Al iniciar sesión, aceptas nuestros'),
                SizedBox(height: size.height * 0.001),
                TextButton(
                    onPressed: () {},
                    child: const Text('Términos y Condiciones')),
                const SizedBox(height: 350)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CerrarCuadroInicioSesion extends StatelessWidget {
  const CerrarCuadroInicioSesion({
    super.key,
    required this.controllerAnim,
  });

  final AnimController controllerAnim;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          height: 60,
          shape: const CircleBorder(),
          onPressed: () {
            controllerAnim.controllerLogin.reverse();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const Icon(
            Icons.close_rounded,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

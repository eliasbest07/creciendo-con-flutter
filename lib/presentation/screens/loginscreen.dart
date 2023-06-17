import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:creciendo_con_flutter/presentation/widgets/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/animation_controller.dart';
import '../controllers/login_controller.dart';
import '../../providers/riverpod_provider.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    // final bool isLoading = ref.watch(loadingProvider); // int , bool, string

    // final inputController = ref.watch(loginController);

    final LoginController controllerLogin = ref.watch(loginController.notifier);
    final AnimController controllerAnim =
        ref.watch(animationController.notifier);
    // AnimationController controllerAnim.controllerLogin = controllerAnim.controllerLogin;
    // AnimationController controllerAnim.controllerRegister = controllerAnim.controllerRegister;

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // print('current user: ${auth.currentUser?.email}');

    // late AnimationController inRegister;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Background(size: size),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.12,
                          ),
                          const Text(
                            'TaskFlow',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                              onPressed: () {
                                controllerAnim.controllerRegister.reset();
                                controllerAnim.controllerRegister.forward();
                              },
                              child: const Text('Regístrate aquí'))
                        ],
                      ),
                      Positioned(
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
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
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
                                  Row(
                                    children: [
                                      MaterialButton(
                                        height: 60,
                                        shape: const CircleBorder(),
                                        onPressed: () {
                                          controllerAnim.controllerLogin
                                              .reverse();
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.020),
                                  const Text('Iniciar Sesión',
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(height: size.height * 0.040),
                                  Container(
                                    height: 50,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 81, 80, 80),
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                            offset: Offset(1, 1),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
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
                                              controller: controllerLogin
                                                  .inputControllerEmail,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Correo'),
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 61, 60, 60),
                                            width: 2,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 118, 118, 118),
                                              offset: Offset(1, 1),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
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
                                            width: 185,
                                            child: TextFormField(
                                                controller: controllerLogin
                                                    .inputControllerPassword,
                                                maxLines: 1,
                                                autocorrect: false,
                                                obscureText:
                                                    controllerLogin.verClave,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        hintText: 'Clave'),
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 18,
                                                )),
                                          ),
                                          SizedBox(
                                              width: 20,
                                              child: IconButton(
                                                splashRadius: 20,
                                                icon: controllerLogin.verClave
                                                    ? const Icon(Icons
                                                        .remove_red_eye_sharp)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                                onPressed: () {
                                                  controllerLogin.verClave =
                                                      !controllerLogin.verClave;
                                                },
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )),
                                  SizedBox(height: size.height * 0.040),
                                  MaterialButton(
                                    color: Colors.black,
                                    splashColor: Colors.white,
                                    onPressed: () {
                                      // controller.inicio(context);
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
                                        color: const Color.fromARGB(
                                            155, 61, 60, 60),
                                      ),
                                      const Text('tambien puedes iniciar con'),
                                      Container(
                                        height: 1,
                                        width: 40,
                                        color: const Color.fromARGB(
                                            155, 61, 60, 60),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.030),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 61, 60, 60),
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                            offset: Offset(1, 1),
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            offset: Offset(-1, -1),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Image.asset(
                                              'assets/google_logo.png')),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.050),
                                  const Text(
                                      'Al iniciar sesión, aceptas nuestros'),
                                  SizedBox(height: size.height * 0.001),
                                  TextButton(
                                      onPressed: () {},
                                      child:
                                          const Text('Términos y Condiciones'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: FadeInUpBig(
                          animate: false,
                          controller: (animacionControl) {
                            controllerAnim.controllerRegister =
                                animacionControl;
                          },
                          child: Container(
                            height: size.height * 0.78,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(155, 118, 118, 118),
                                    offset: Offset(-2, -2),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.015),
                                Row(
                                  children: [
                                    MaterialButton(
                                      height: 60,
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        controllerAnim.controllerRegister
                                            .reverse();
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.020),
                                const Text('Nuevo Usuario',
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(height: size.height * 0.040),
                                Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 81, 80, 80),
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 118, 118, 118),
                                          offset: Offset(1, 1),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                            controller: controllerLogin
                                                .inputControllerEmail,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintText: 'Correo'),
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                          color: const Color.fromARGB(
                                              255, 61, 60, 60),
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                            offset: Offset(1, 1),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
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
                                          width: 185,
                                          child: TextFormField(
                                              controller: controllerLogin
                                                  .inputControllerPassword,
                                              autocorrect: false,
                                              obscureText:
                                                  controllerLogin.verClave,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Clave'),
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                              )),
                                        ),
                                        SizedBox(
                                            width: 20,
                                            child: IconButton(
                                              splashRadius: 20,
                                              icon: controllerLogin.verClave
                                                  ? const Icon(Icons
                                                      .remove_red_eye_sharp)
                                                  : const Icon(
                                                      Icons.visibility_off),
                                              onPressed: () {
                                                controllerLogin.verClave =
                                                    controllerLogin.verClave;
                                              },
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )),
                                SizedBox(height: size.height * 0.040),
                                MaterialButton(
                                  color: Colors.black,
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    // controller.registro(context);
                                  },
                                  child: const Text(
                                    'Registrar',
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
                                      color:
                                          const Color.fromARGB(155, 61, 60, 60),
                                    ),
                                    const Text('tambien puedes iniciar con'),
                                    Container(
                                      height: 1,
                                      width: 40,
                                      color:
                                          const Color.fromARGB(155, 61, 60, 60),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.030),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 61, 60, 60),
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 118, 118, 118),
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                        ),
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          offset: Offset(-1, -1),
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/google_logo.png')),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.050),
                                const Text('Si te registras, aceptas nuestros'),
                                SizedBox(height: size.height * 0.001),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Términos y Condiciones'))
                              ],
                            ),
                          ),
                        ),
                      ),
                      ZoomIn(
                        animate: false,
                        controller: (p0) {
                          // controller.showalerta = p0;
                        },
                        child: Container(
                          color: const Color.fromARGB(105, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 250,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 118, 118, 118),
                                    offset: Offset(1, 1),
                                    blurRadius: 5,
                                    spreadRadius: 3,
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    offset: Offset(-1, -1),
                                    blurRadius: 3,
                                    spreadRadius: 3,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Text(controller.mensaje.value,
                                  //     textAlign: TextAlign.center),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MaterialButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      // controller.showalerta.reverse();
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
                      )
                    ],
                  ),
                ),
              )),
        ]));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 255, 123, 1),
              Color.fromARGB(255, 255, 170, 1),
            ])));
  }

  Widget _textAppName() {
    return Text(
      'Delivery',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _boxForm(BuildContext context, LoginController controllerLogin) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.40, left: 20, right: 20),
      // decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
      //   BoxShadow(
      //       color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
      // ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textFieldEmail(controllerLogin),
            _textFieldPassword(controllerLogin),
            _buttonLogin(controllerLogin),
            _textForgotPassword(),
            _lineDivider(),
            _buttonGoogle()
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail(LoginController controllerLogin) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller:
            controllerLogin.inputControllerEmail, // con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Email',
            prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget _textFieldPassword(LoginController controllerLogin) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controllerLogin.inputControllerPassword,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock)),
      ),
    );
  }

  Widget _buttonLogin(LoginController controllerLogin) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          controllerLogin.inciarSesion();
          // aqui se conecta el backend firebv
        }, //=> TextEditingController(),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 15),
            primary: Color.fromRGBO(1, 61, 115, 0.6)),
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _textForgotPassword() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: () => {},
          child:
              Text('Forgot Password?', style: TextStyle(color: Colors.white)),
        ));
  }

  Widget _textDontHaveAccount() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 7,
          ),
          GestureDetector(
            onTap: () => {}, //con.goToRegisterPage(),
            child: Text(
              'Create An Account',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  // Widget _imageCover() {
  //   return SafeArea(
  //     child: Container(
  //         margin: EdgeInsets.only(top: 60, bottom: 20),
  //         alignment: Alignment.center,
  //         child: Image.asset(
  //           'assets/img/happyvolts.png',
  //           width: 160,
  //         )),
  //   );
  // }

  Widget _lineDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(children: <Widget>[
        Expanded(
            child: Divider(
          thickness: 1.5,
        )),
        SizedBox(
          width: 10,
        ),
        Text(
          "OR",
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Divider(thickness: 1.5)),
      ]),
    );
  }

  Widget _buttonGoogle() {
    return Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          color: Colors.red,
        )
        // SignInButton(
        //   Buttons.GoogleDark,
        //   padding: EdgeInsets.symmetric(horizontal: 30),
        //   shape: StadiumBorder(),
        //   text: 'Continue with Google',
        //   onPressed: () async {
        //     con.signInWithGoogle();
        //   },
        // ),
        );
  }

  // Widget _avatarCircleLogo() {
  //   return Image(
  //     image: AssetImage(
  //       'assets/img/Group_329.png',
  //     ),
  //   );
  // }
}

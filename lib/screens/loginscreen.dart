import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/login_controller.dart';
import '../providers/riverpod_provider.dart';


// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isLoading = ref.watch(loadingProvider); // int , bool, string 

    // final inputController = ref.watch(loginController);

    final LoginController controllerLogin = ref.watch(loginController.notifier);
    final FirebaseAuth auth = FirebaseAuth.instance;
    print('current user: ${auth.currentUser?.email}');

    
    return Scaffold(
      body: isLoading ?  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                ref.read(loadingProvider.notifier).state = false; // String, int 
              },
              child: const Text('Cambiar A TRUE '),
            ),
            const CircularProgressIndicator(),
          ],
        )
        ) : Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context, controllerLogin),
          MaterialButton(
              onPressed: () {
                controllerLogin.cerrarSesion();
              },
              child: const Text('Cerrar sesion'),
            ),
          Column(
            children: [
              // _imageCover(),
              // _avatarCircleLogo(),
              _textDontHaveAccount()
            ],
          ),
        ],
      ),
    );
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
        controller: controllerLogin.inputControllerEmail, // con.emailController,
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
            prefixIcon:const Icon(Icons.lock)),
      ),
    );
  }

  Widget _buttonLogin(LoginController controllerLogin) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          'Login',
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
            onTap: () => {},//con.goToRegisterPage(),
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
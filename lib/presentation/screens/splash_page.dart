// ignore_for_file: sort_child_properties_last

import 'package:creciendo_con_flutter/presentation/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    timeNext();
    super.initState();
  }

  Future<void> timeNext() async {
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               SizedBox(),
               Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: Image(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
              Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Cargando...'),
                ],
              )
            ]),
      ),
    );
  }
}

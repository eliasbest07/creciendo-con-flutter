import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
        Container(width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0,2)
            )
          ] ),
          child:const Center(child: Text('Creciendo con Flutter',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),)),
          )
      ],)
    );
  }
}
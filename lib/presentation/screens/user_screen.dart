import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Opciones de Usuario',style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)),
      ),
      body: Column(children: [
        const SizedBox(height: 20),
        Text('Nombre de Usuario'),
      ],)
    );
  }
}
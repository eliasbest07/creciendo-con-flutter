import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final usuarioService = UsuarioService();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title:const Text('Opciones de Usuario',style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)),
      ),
      body: Column(
  children: [
    const SizedBox(height: 20),
    FutureBuilder<Usuario>(
      future: usuarioService.obtenerUsuarioActual(userId), // Reemplaza 'userId' con el ID de usuario apropiado
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final usuario = snapshot.data!;
            return Text(usuario.nombre);
          } else if (snapshot.hasError) {
            return Text('Error al obtener el nombre del usuario');
          }
        }
        return CircularProgressIndicator();
      },
    ),
  ],
),

    );
  }
}
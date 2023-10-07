import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioService = UsuarioService();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'MI PERFIL',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        actions: [
          //Acción para editar los datos del usuario usando un bottomSheet
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            //Avatar e icono de editar foto
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 82,
                    width: 82,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 103, 159, 228)),
                    child: Image.asset('assets/avatar.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffD9D9D9),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Color(0xff0A3567),
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 15),

            //Nombre del usuario
            Center(
              child: FutureBuilder<Usuario>(
                future: usuarioService.obtenerUsuarioActual(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final usuario = snapshot.data!;
                      return Text(
                        usuario.nombre,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),

            const SizedBox(height: 25),

            //Información de medallas, puntos y aportaciones
            Container(
              width: double.infinity,
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(10, 155, 155, 155),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  InfoCardUserWidget(
                      title: 'MEDALLAS', info: '12', icon: Icons.flag),
                  InfoCardUserWidget(
                      title: 'APORTACIOENS', info: '454', icon: Icons.check),
                  InfoCardUserWidget(
                      title: 'PUNTOS', info: '5K', icon: Icons.star_outlined),
                ],
              ),
            ),

            const SizedBox(height: 35),

            //Título de la sección de Preferencias
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferencias',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  OptionsProfileWidget(
                    title: 'Notificaciones',
                    icon: Icons.notifications_active_outlined,
                    widget: CupertinoSwitch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  OptionsProfileWidget(
                    title: 'Modo oscuro',
                    icon: Icons.mode_night_outlined,
                    widget: CupertinoSwitch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //Título de la sección de soporte e información
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soporte e información',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  OptionsProfileWidget(
                    title: 'Ayuda',
                    icon: Icons.help_outline_sharp,
                    widget: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  OptionsProfileWidget(
                    title: 'Términos y condiciones',
                    icon: Icons.warning_amber_rounded,
                    widget: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //Cerrar sesión
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionsProfileWidget(
                title: 'Cerrar sesión',
                icon: Icons.exit_to_app_rounded,
                colorTextAndIcon: const Color(0xffE41919),
                widget: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCardUserWidget extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;

  const InfoCardUserWidget({
    super.key,
    required this.title,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        info,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        icon,
                        color: const Color(0xffFFC700),
                        size: 20,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class OptionsProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget widget;
  final Color? colorTextAndIcon;

  const OptionsProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.widget,
    this.colorTextAndIcon = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: Color(0xffDCDCDC),
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10), //, vertical: 15
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: colorTextAndIcon,
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  color: colorTextAndIcon,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          widget,
        ],
      ),
    );
  }
}

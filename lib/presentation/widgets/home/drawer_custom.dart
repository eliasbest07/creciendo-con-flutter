import 'package:TaskFlow/domain/entities/usuario/usuario_entity.dart';
import 'package:TaskFlow/infrastructure/services/usuario_service.dart';
import 'package:TaskFlow/presentation/screens/profile_screen.dart';
import 'package:TaskFlow/providers/riverpod_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerCustom extends ConsumerWidget {
  const DrawerCustom({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(showEstatus);

    final usuarioService = UsuarioService();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    return Container(
      height: size.height,
      width: size.width * 0.6,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: Theme.of(context).primaryColor),
      child: Column(children: [
        //  const Header(),
        SizedBox(height: size.height * 0.05),
        const Divider(),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            ref.read(indexPage.notifier).update((state) => 2);
            Navigator.pop(context);
            // Navigator.pushNamed(context, 'ListProject');
          },
          child: const ListTile(
              leading: Icon(
                Icons.poll_rounded,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                'Proyectos',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),

        const Divider(),

        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            // Navigator.pushNamed(context,'ListProject');
          },
          child: const ListTile(
              leading: Icon(
                Icons.chat,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                'Hilo de Comentarios',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),

        const Divider(),

        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            // Navigator.pushNamed(context,'ListProject');
          },
          child: const ListTile(
              leading: Icon(
                Icons.trending_up_outlined,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                'Ranking',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),

        const Divider(),

        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            // Navigator.pushNamed(context,'ListProject');
          },
          child: const ListTile(
              leading: Icon(
                Icons.task,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                'Lista de Tareas',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),

        const Divider(),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  // Navigator.pushNamed(context,'ListProject');
                },
                child: FutureBuilder<Usuario>(
                  future: usuarioService.obtenerUsuarioActual(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final usuario = snapshot.data!;
                        return ListTile(
                          leading: const Icon(
                            Icons.person_pin,
                            color: Colors.white,
                            size: 35,
                          ),
                          title: Text(
                            usuario.nombre,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ProfileScreen()));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error.toString()}');
                      }
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'estatus: $status',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.blue,
      child: Center(
          child: Container(
        height: 90,
        width: 90,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      )),
    );
  }
}

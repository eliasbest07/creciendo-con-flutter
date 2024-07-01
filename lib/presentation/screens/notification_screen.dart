import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        // TODO: Mostrar lista de notificaciones de los usuarios
        // segun cada lider
        // el lider puede eliminar la notificacion

        child: Text('NotificationScreen'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';

class NewProjectDialog extends ConsumerWidget {
  const NewProjectDialog({super.key, required this.size, required this.context});
  final Size size;
  final BuildContext context;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerProyecto = ref.watch(listaProyectos.notifier);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: size.height*0.3,
        width: size.width*0.7,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(children: [
          const SizedBox(height: 30,),
         const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Ingresa el nombre del Nuevo Proyecto'),
          ),
         Padding(
           padding: const EdgeInsets.all(25.0),
           child: SizedBox(
             height: 40,
             width: double.infinity,
             child: TextField(controller: controllerProyecto.inputName),
           ),
         ),
         const SizedBox(height: 30,),
         MaterialButton(
           color: Colors.blue,
           onPressed: (){
             controllerProyecto.agregarProyecto();
          Navigator.pop(context);
          // Firebase.guardar nuevo proyecto ( proyecto(nombre: TextEditingController() ) )
         },child:const Text('Crear',style: TextStyle(color:Colors.white),),)
        ]),
      ),
    );
  }
}
import 'package:TaskFlow/presentation/screens/list_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/proyecto/meta_entity.dart';
import '../../providers/riverpod_provider.dart';

class EditGoalScreen extends ConsumerWidget {
  const EditGoalScreen( {Key? key, required this.projectID,required this.porEditar}) : super(key: key);
  final String projectID;
  final Meta porEditar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('porEditar: ${porEditar.nombre}');
    final controllerMeta = ref.watch(listaMetasMyProyecto.notifier);
    final mapMeta = ref.watch(listaMetasMyProyecto);
    controllerMeta.addProyecto(projectID);
    final listMeta = mapMeta[projectID];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDITAR META',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lista de Tareas'),
            const Text(
              'Nombre:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                hintText: 'Ingresar nombre',
                suffixIcon: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Tipo:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   activeUI = !activeUI;
                      //   activeFront = false;
                      //   activeBack = false;
                      // });
                      controllerMeta.setType('UI');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: listMeta?.last.item == 'UI'
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('UI'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controllerMeta.setType('FRONT');
                      // setState(() {
                      //   activeUI = false;
                      //   activeFront = !activeFront;
                      //   activeBack = false;
                      // });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: listMeta?.last.item == 'FRONT'
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('FRONT'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controllerMeta.setType('BACK');
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: listMeta?.last.item == 'BACK'
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('BACK'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Fecha de creación:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                  // setState(() {
                  //   _fechaInicioController.text=formattedDate.toString();
                  // });
                } //when click we have to show the datepicker
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Fecha de culminación:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                  // setState(() {
                  //   _fechaInicioController.text=formattedDate.toString();
                  // });
                } //when click we have to show the datepicker
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(11),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff455A64)),
                  borderRadius: BorderRadius.circular(11),
                ),
                filled: true,
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Lista de tareas:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            SizedBox(
              height: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListTaskScreen(), // metaID: metaID
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 65, 170, 255),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'AGREGAR',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 7.0),
          ],
        ),
      ),
    );
  }
}

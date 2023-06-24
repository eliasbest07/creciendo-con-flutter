import 'package:flutter/material.dart';

class NewGoalScreen extends StatelessWidget {

  const NewGoalScreen({Key? key}) : super(key: key);
  
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NUEVA META',
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
                  borderSide: const BorderSide(
                      width: 2, color: const Color(0xff455A64)),
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
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: true ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('UI'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
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
                          color: true ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('FRONT'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   activeUI = false;
                      //   activeFront = false;
                      //   activeBack = !activeBack;
                      // });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: true ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('BACK'),
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
                  borderSide: const BorderSide(
                      width: 2, color: const Color(0xff455A64)),
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
                  borderSide: const BorderSide(
                      width: 2, color: const Color(0xff455A64)),
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
            const SizedBox(height: 15),
            const Text(
              'Lista de comentarios:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7.0),
            SizedBox(
              child: true
                  ? Container(
                      height: 60,
                      width: double.infinity,
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
                    )
                  : SizedBox(
                      height: 80,
                      child: ListView.separated(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container(
                              height: 90,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // borderRadius: borderRadius,
                                color: const Color.fromARGB(255, 65, 170, 255),
                              ),
                              child: const Column(
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
                            );
                          }
                          return GestureDetector(
                            onLongPress: () {
                              // setState(() {
                                // comentarios.removeAt(index - 1);
                              // });
                              // print(comentarios.length);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // borderRadius: borderRadius,
                                color: const Color(0xfff0f0f0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Comentario $index :'),
                                  const SizedBox(height: 5),
                                  // Text(comentarios[index - 1], maxLines: 2),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
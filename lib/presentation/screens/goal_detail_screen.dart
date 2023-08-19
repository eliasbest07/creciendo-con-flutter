import 'package:TaskFlow/domain/entities/proyecto/meta_entity.dart';
import 'package:TaskFlow/presentation/drawables/filter_icon.dart';
import 'package:TaskFlow/presentation/widgets/home/navbar.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/proyecto/tarea_entity.dart';
import 'screens.dart';

class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({super.key, required this.meta});
  final Meta meta;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ScrollController listTask = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 246, 249, 255),
      appBar: AppBar(
        title: const Text(
          'META',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right:10.0, top: 10, bottom: 10),
            height: 20,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2,color: Colors.white)),
            child: const Center(child:  Padding(
              padding: EdgeInsets.symmetric(horizontal:9.0),
              child: Text('Sugerir Tarea',style: TextStyle(color: Colors.white),),
            )),
          )
        ],
      ),
            floatingActionButton: NavBar(
        primaryColor: Theme.of(context).primaryColor,
        width: size.width,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // lista de Comentarios
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(74, 46, 46, 46),
                                offset: Offset(0.0, 2.0),
                                blurRadius: 7.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text('Comentario $index'),
                          ),
                        ));
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Lista de Tareas 05',style: TextStyle(color: Colors.grey)),
                      IconButton(
                        onPressed: (){
              
                        }, 
                        icon: SizedBox(
                          height: 20,
                          width: 20,
                          child: CustomPaint(
                              size: Size.infinite,
                              painter: FilterIcon()
                          )
                        )
                      )
                    ],
                  ),
              ),
              SizedBox(
                height: size.height*0.62,
                child: ListView.builder(
                  controller: listTask,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index==4 ? const EdgeInsets.only(bottom:320.0,top: 8,left: 8,right: 8) : const EdgeInsets.all(8.0),
                      child: Container( 
                        height: 125,  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(74, 46, 46, 46),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 7.0,
                            )
                          ],
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(top:8.0,left: 8.0, right: 20, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            SizedBox(
                              width: size.width*0.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('Nombre de la tarea Nombre de la tarea Nombre de la tareaNombre de la tarea Nombre de la tarea', maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Text('Estado:',style: TextStyle(color: Colors.grey)),
                                    const SizedBox(width: 10),
                                    MaterialButton(
                                    
                                      color: Theme.of(context).primaryColor,
                                      shape: const StadiumBorder(),
                                      onPressed: (){},
                                    child: const Center( child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal:8.0),
                                  
                                      child: Text('Auto Asignar', style: TextStyle(color: Colors.white),),
                                    ))
                                      
                                      )
                                  ],
                                )
                              ]),
                            ),
                              Center(child: Container( 
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), shape: BoxShape.circle),),)
                          ],),
                        )
                      ),
                    );
                  }
                )
              )
            
            ],
          ),
          Positioned(
            bottom: 135,
            left: 0,
            right: 0,
            child: ListTasks(meta: meta, scrollController: listTask,maximoTamanio: 200, minimoTamanio: 100,)
          )
        ],
      ),
    );
  }
}

class ListTasks extends StatefulWidget {
  const ListTasks({
    super.key,
    required this.meta, required this.scrollController, required this.maximoTamanio, required this.minimoTamanio,
  });

  final ScrollController scrollController;
  final double maximoTamanio;
  final double minimoTamanio;
  final Meta meta;

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  double tamanio =0;
  @override
  void initState() {
    super.initState();
    tamanio =widget.maximoTamanio;
    widget.scrollController.addListener(() { 

      if( tamanio > 100){
        tamanio=tamanio-(widget.scrollController.position.pixels)*0.02;
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          tamanio=widget.maximoTamanio;
        });
      },
      child: Container(
        height: tamanio,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(10),
          color: Theme.of(context).primaryColor
        ), 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(100),
                        color: Colors.purple,
                      ),
                      alignment: Alignment.center,
                      child:Text(
                        widget.meta.item,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Text('Tareas completadas 4/6',style: TextStyle(color: Color.fromARGB(255, 136, 188, 249))),
                            const SizedBox(width: 5),
                            Text('75%',style: TextStyle(color: Colors.white))
                          ]
                        ),
                        SizedBox(
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: LinearProgressIndicator(
                              value: 0.8,
                              color: Color.fromARGB(255, 63, 255, 70),)),
                        )
                      ]
                    )
                  
                  ]
                ),
                const SizedBox(height: 5),
                Text( widget.meta.nombre, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: Colors.white),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Creada por:', style: TextStyle(color:  Color.fromARGB(255, 136, 188, 249))),
                    Row(children: [
                      Container(height: 40, width: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),),
                      const SizedBox(width: 5),
                      Text('Nombre del usuario ', style: TextStyle(color: Colors.white),)
                    ],),
                    const Text('Fecha de Inicio:', style: TextStyle(color:  Color.fromARGB(255, 136, 188, 249))),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white),
                        const SizedBox(width: 5),
                        Text('12 Oct 2023 ', style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Participantes:', style: TextStyle(color:  Color.fromARGB(255, 136, 188, 249))),
                      const SizedBox(height: 7),
                    Row(children: [
                      Text('6', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 7),
                      Container(
                        height: 25, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color:const Color.fromARGB(255, 136, 188, 249)),
                        child: Center(child: Text('  Visualizar  ', style: TextStyle(color: Theme.of(context).primaryColor),))
                      ),
                    ],),
                    const SizedBox(height: 5),
                    const Text('Fecha Establecida:', style: TextStyle(color:  Color.fromARGB(255, 136, 188, 249))),
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.white),
                        const SizedBox(width: 5),
                        Text('12 Oct 2023 ', style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ])
                ])

              ]
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  final Size size;
  final Tarea tarea;

  const TaskCardWidget({
    super.key,
    required this.size,
    required this.tarea,
  });

  @override
  Widget build(BuildContext context) {
    Color? colorEstado;

    switch (tarea.estado) {
      case 'En proceso':
        colorEstado = Colors.amber;
        break;
      case 'Revisión':
        colorEstado = Colors.red;
        break;
      case 'Terminado':
        colorEstado = Colors.green;
        break;
      case 'Avanzado':
        colorEstado = Colors.orange;
        break;
      default:
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(tarea: tarea),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: size.width * .7,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tarea.nombre),
                  Text(
                    tarea.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          tarea.estado,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: colorEstado,
                      ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 15,
                        child: Text(
                          tarea.nivel.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
              padding: const EdgeInsets.only(left: 5),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

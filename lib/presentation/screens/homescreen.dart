
import 'package:TaskFlow/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/services/usuario_service.dart';
import '../../providers/riverpod_provider.dart';
import '../controllers/login_controller.dart';
import '../drawables/nav_bar.dart';
import '../widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final LoginController controller = ref.watch(loginController.notifier);
    final listaProject = ref.watch(listaProyectos);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor:Colors.white ,
        title: Text('TaskFlow',style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await controller.cerrarSesion();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, 'login');
              }
            },
            icon: Icon(Icons.exit_to_app, color: Colors.black,),
          )
          ]
      ),
      drawer: SizedBox(
        height: height * 0.7,
          width: width * 0.7,
          child: DrawerCustom(
            size: Size(height, width),
          )),
      body: Stack(
        children: [   Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
          const Padding(
            padding:  EdgeInsets.only(left: 10.0),
            child: Row(
                children:  [
                  Text('Tus Metas y tareas', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoalDetailScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: height * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            border:const Border.fromBorderSide(
                              BorderSide(
                                width: 4,
                                color:   Color.fromARGB(255, 147, 216, 207),
                              ),
                            ),
                        ),
                        child: Stack(children: [
                          Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(155, 147, 216, 207),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            ),
                        ),
                        ],)
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Padding(
            padding:  EdgeInsets.only(left: 10.0),
            child: Row(
                children:  [
                  Text('Proyectos para unirte', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
          SizedBox(
              height: height * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listaProject.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(project: listaProject[index]),
                          ),
                        );
                      },
                      child: Container(
                        width: height * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            border:const Border.fromBorderSide(
                              BorderSide(
                                width: 4,
                                color:   Color.fromARGB(255, 147, 216, 207),
                              ),
                            ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(listaProject[index].icon))
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Padding(
            padding:  EdgeInsets.only(left: 10.0),
            child: Row(
                children:  [
                  Text('Noticias', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
          ),
          ],
          
        ), 
        Positioned(
          bottom: 120,
          right: 10,
          child: Container(height: 40, width: width*0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
          )),
          )
        ]
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
          height: 150,
          width: double.infinity,
          child: Stack(children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: CustomPaint(
                    size: Size.infinite,
                    painter:
                        NavBar(primaryColor: Theme.of(context).primaryColor)),
              ),
            ),
            Positioned(
              bottom: 40,
              left: width * 0.125,
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: (){
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: 78,
                      width: 78,
                      decoration:
                        const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 103, 159, 228)),
                        child: Image.asset('assets/avatar.png'),
                    ),
                  );
                }
              ),
            ),
            Positioned(
              bottom: 7,
              left: 0,
              child: Container(
                height: 30,
                width: 60,
              decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 103, 159, 228),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              child: StreamBuilder(
                stream: UsuarioService().obtenerPuntos(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  return Center(child: Text(snapshot.data.toString()));
                  }
                  else{
                    return const Center(child:  CircularProgressIndicator());
                  }
                },
                ),)),
            Positioned(
              left: width * 0.8,
              bottom: 20,
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const  Icon(Icons.home, color: Colors.white, size: 30,)
              ),
            ),
            Positioned(
              left: width * 0.6,
              bottom: 20,
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:const Color.fromARGB(255, 103, 159, 228),
                    width: 2,
                  ), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const  Icon(Icons.calendar_month, color: Color.fromARGB(155, 103, 159, 228), size: 30,)
              ),
            ),
            Positioned(
              left: width * 0.4,
              bottom: 20,
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:const Color.fromARGB(155, 103, 159, 228),
                    width: 2,
                  ), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const  Icon(Icons.notifications, color: Color.fromARGB(255, 103, 159, 228), size: 30,)
              ),
            )
          ])),
    );
  }
}

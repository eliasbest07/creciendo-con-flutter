import 'package:flutter/material.dart';

import '../../../infrastructure/services/usuario_service.dart';
import '../../drawables/nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.primaryColor, required this.width,
  });

  final Color primaryColor;
  final double width;

  @override
  Widget build(BuildContext context) {

    return Container(
          height: 150,
          width: double.infinity,
          color: Colors.transparent,
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
              NavBarShape(primaryColor: primaryColor)))
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
                    return Center(child:  Container(
                      height: 50, width:50,
                      color: Colors.transparent,
                      child:const Padding(
                        padding:  EdgeInsets.symmetric(horizontal:5.0),
                        child:  CircularProgressIndicator(),
                      )));
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
                  // border: Border.all(
                  //   color: Colors.white,
                  //   width: 2,
                  // ), 
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
                  // border: Border.all(
                  //   color:const Color.fromARGB(255, 103, 159, 228),
                  //   width: 2,
                  // ), 
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
                  // border: Border.all(
                  //   color:const Color.fromARGB(155, 103, 159, 228),
                  //   width: 2,
                  // ), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const  Icon(Icons.notifications, color: Color.fromARGB(255, 103, 159, 228), size: 30,)
              ),
            ),
            Positioned(
              top: 22,
              right: 10,
              child: Container(height: 40, width: width*0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              )),
            )
          ]));
  }
}
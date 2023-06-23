import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    Key? key, required this.size,
  }) : super(key: key);
final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(height: double.infinity,width: size.width*0.7, color: Colors.white,
    child: Column(children:const [
      Header(),
      SizedBox(height: 10),
      Divider(), 
     ListTile(leading: Icon(Icons.poll_rounded),title: Text('Proyectos'),)
    ]),);
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 200,width: double.infinity,
    color: Colors.blue,
  
    child: Center(child: Container(height: 90,width: 90,decoration: BoxDecoration(color: Colors.white,shape:BoxShape.circle ),)),);
  }
}
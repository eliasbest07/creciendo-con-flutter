import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    Key? key, required this.size,
  }) : super(key: key);
final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(height: size.height,width: size.width*0.5, 
    decoration:  BoxDecoration(
      borderRadius:const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)), color: Theme.of(context).primaryColor),
    child: Column(children: [
    //  const Header(),
      const SizedBox(height: 10),
      const Divider(), 
      Padding(
        padding: const EdgeInsets.only(left:15.0),
        child: ListTile(leading: const Icon(Icons.poll_rounded,color: Colors.white, size: 40,),title: const Text('Proyectos',style: TextStyle(color:Colors.white, fontSize: 20),), onTap: (){
          Navigator.pushNamed(context,'ListProject');
        },),
      )
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
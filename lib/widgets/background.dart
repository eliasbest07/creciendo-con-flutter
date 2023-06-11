import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Size size;
  const Background({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(children: [
          Positioned(
            top: size.height*0.1,
            right: size.width*0.3,
            child:const Circulo(color:Color.fromARGB(225, 160, 212, 234),height: 50, width: 50, )),
          Positioned(
            top: size.height*0.3,
            right: size.width*0.1,
            child:const Circulo(color:Color.fromARGB(225, 160, 234, 207),height: 90, width: 90, )),
          Positioned(
            top: size.height*0.6,
            right: size.width*0.25, child: const Circulo(color:Color.fromARGB(225, 1, 72, 114),height: 170, width: 170, )),
          Positioned(
            top: size.height*0.8,
            right: size.width*0.7,
            child: const Circulo(color:Color.fromARGB(225, 123, 205, 243),height: 300, width: 300, )),
        ]),
    );
  }
}

class Circulo extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  const Circulo({
    super.key, required this.color, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
      shape: BoxShape.circle, 
      gradient: LinearGradient(
        colors: [
          color,
          const Color.fromARGB(0, 255, 255, 255),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,)
      ),
    );
  }
}
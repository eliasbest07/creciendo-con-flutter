import 'package:flutter/material.dart';

class NavBar extends CustomPainter {
  final primaryColor;

  NavBar({ required this.primaryColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color =primaryColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 1);

    // path.quadraticBezierTo(size.width * 0.35, 0.5, size.width * 0.35, 0);
    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.395, 18); //primera curba
    path.lineTo(size.width * 0.1, 0);
    path.arcToPoint( Offset(size.width * 0.35, 0), clockwise: false, radius: const  Radius.circular(2));
    // path.quadraticBezierTo(size.width * 0.20, size.height * 0.52,
    //     size.width * 0.45, size.height * 0.50);

    // path.lineTo(size.width * 0.53, size.height * 0.50);

    // path.quadraticBezierTo(size.width * 0.58, size.height * 0.52,
    //     size.width * 0.58, size.height * 0.40);

    // path.lineTo(size.width * 0.58, 18);
    // path.quadraticBezierTo(
    //     size.width * 0.58, size.height * 0, size.width * 0.62, size.height * 0);

    path.lineTo(size.width * 1, size.height * 0); // parte de abajo
    path.lineTo(size.width * 1, size.height * 1);
    path.lineTo(size.width * 0, size.height * 1);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NavBar oldDelegate) => oldDelegate != this;
}
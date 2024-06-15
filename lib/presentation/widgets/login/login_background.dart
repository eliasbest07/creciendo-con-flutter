import 'package:flutter/material.dart';
import 'dart:math';
class Background extends StatefulWidget {
  final Size size;
  const Background({super.key, required this.size});

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final center = Offset(widget.size.width / 2, widget.size.height / 2);
    final radius = widget.size.width * 0.7;

    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              _buildAnimatedCirculo(
                center,
                radius,
                0,
                const Color.fromARGB(225, 160, 212, 234),
                50,
                50,
              ),
              _buildAnimatedCirculo(
                center,
                radius,
                1,
                const Color.fromARGB(225, 160, 234, 207),
                90,
                90,
              ),
              _buildAnimatedCirculo(
                center,
                radius,
                2,
                const Color.fromARGB(225, 1, 72, 114),
                170,
                170,
              ),
              _buildAnimatedCirculo(
                center,
                radius,
                3,
                const Color.fromARGB(225, 123, 205, 243),
                300,
                300,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCirculo(Offset center, double radius, int index, Color color,
      double height, double width) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = (_controller.value * -2 * 3.1415926535897932) + (index * (3.1415926535897932 / 2));
        final offset = Offset(
          center.dx + radius * cos(angle) - width- 100 ,
          center.dy + radius * sin(angle) - height / 2,
        );

        //double rotation = 0.0;
        // if (angle >= 4 * pi / 2 || angle <= pi / 2) {
        //   double adjustedAngle = angle;
        //   if (angle >= 3 * pi / 2) {
        //     adjustedAngle = angle - 2 * pi;
        //   }
        //  scale = 1 - (0.9 * (adjustedAngle + pi / 2) / pi);
         double rotation = (0.5 * (angle + pi / 2) / pi) * pi; // Rotación en el mismo rango
        // }
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child:  Transform.rotate(
            angle: rotation,
            child: Circulo(
              color: color,
              height: height,
              width: width,
            ),
          ),
        );
      },
    );
  }
}

class Circulo extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  const Circulo({
    super.key,
    required this.color,
    required this.height,
    required this.width,
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
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
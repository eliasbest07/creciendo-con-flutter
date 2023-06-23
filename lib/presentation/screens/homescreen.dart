import 'package:creciendo_con_flutter/presentation/drawables/nav_bar.dart';
import 'package:creciendo_con_flutter/presentation/widgets/drawer_custom.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerCustom (size: Size(height,width),),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TaskFlow'),
                IconButton(onPressed: () {}, icon: const Icon(Icons.chat))
              ],
            ),
          ),
          SizedBox(
            height: height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 147, 216, 207)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          height: 150,
          width: double.infinity,
          child: Stack(children: [
            Positioned(
              bottom: 40,
              left: width * 0.125,
              child: Container(
                height: 78,
                width: 78,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: CustomPaint(size: Size.infinite, painter: NavBar()),
              ),
            ),
          ])),
    );
  }
}

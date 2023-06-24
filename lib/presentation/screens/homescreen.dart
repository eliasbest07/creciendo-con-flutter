import 'package:creciendo_con_flutter/presentation/drawables/nav_bar.dart';
import 'package:creciendo_con_flutter/presentation/widgets/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';
import '../controllers/login_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final LoginController controller = ref.watch(loginController.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SizedBox(
        width: width * 0.6,
        child: DrawerCustom (size: Size(height,width),)),
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
                IconButton(
                  onPressed: () async {
                    await controller.cerrarSesion();
                    Navigator.pushNamed(context, 'login');
                  },
                  icon: const Icon(Icons.exit_to_app),
                ),
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
                      color: const Color.fromARGB(255, 147, 216, 207),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
                child: CustomPaint(size: Size.infinite, painter: NavBar(primaryColor: Theme.of(context).primaryColor)),
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
                        const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                    ),
                  );
                }
              ),
            ),
          ])),
    );
  }
}

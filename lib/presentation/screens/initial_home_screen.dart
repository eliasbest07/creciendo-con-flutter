import 'package:TaskFlow/presentation/screens/notification_screen.dart';
import 'package:TaskFlow/presentation/screens/screens.dart';
import 'package:TaskFlow/presentation/widgets/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/riverpod_provider.dart';
import '../widgets/home/drawer_custom.dart';

class InitialHomeScreen extends ConsumerWidget {
  const InitialHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexPage);

    final List<Widget> listWidget = const [
      HomeScreen(),
      NotificationScreen(),
      ListProjectScreen()
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      drawer: SizedBox(
          height: height * 0.7,
          width: width * 0.7,
          child: DrawerCustom(
            size: Size(height, width),
          )),
      body: listWidget[index],
      //body: listWidget[index],
      bottomNavigationBar: NavBar(
          primaryColor: primaryColor,
          width: width,
          goToScreen: (index) {
            ref.read(indexPage.notifier).update((state) => index);
          }),
    );
  }
}

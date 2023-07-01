import 'package:TaskFlow/presentation/screens/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
} // para usar Riverpod

Future initilizeApp(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow', //Titulo
      initialRoute: auth.currentUser == null
          ? 'login'
          : 'home', // inicial rutas y screens.dart
      routes: {
        'home': (_) => const HomeScreen(),
        'ListProject':  (_) => const ListProjectScreen(),
        'ListGoals':  (_) => const ListGoalScreen(),
        'ListTasks': (_) => const  ListTaskScreen(),
        'newGoal': (_) => const  NewGoalScreen(),
        'newTask': (_) => const  NewTaskScreen(),
        'login': (_) => const SplashPage()
      },
      theme: Theme.of(context).copyWith(
        primaryColor:
            const Color.fromARGB(255, 10, 53, 103), // primari Color theme
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 10, 53, 103),
            ),
      ),
    );
  }
}

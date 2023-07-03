import 'package:TaskFlow/presentation/screens/splash_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'infrastructure/services/local_storage/local_storage.dart';
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
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {

    //final LocalStorage localStorage = LocalStorage();
    // //final FirebaseAuth auth = FirebaseAuth.instance;
    // return FutureBuilder<bool>(
    //   future: localStorage.isLoggedIn(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       // Muestra un indicador de carga mientras se espera el resultado
    //       return CircularProgressIndicator();
    //     } else if (snapshot.hasError) {
    //       // Muestra un mensaje de error si ocurrió un error durante la operación
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       final isLoggedIn = snapshot.data ?? false;
    //       print('usuario logeado? : $isLoggedIn');
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

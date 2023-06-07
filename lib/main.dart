import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppTitle ', //Titulo
      initialRoute: 'home', // inicial rutas y screens.dart
      routes: {
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
      },
    );
  }
}

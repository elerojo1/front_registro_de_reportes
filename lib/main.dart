// main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart'; // Asegúrate de importar tu nueva pantalla

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(), // Registramos la ruta del listado
        // '/registro': (context) => const RegistroScreen(), // La crearemos pronto
      },
    );
  }
}
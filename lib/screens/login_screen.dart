import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    
    // Obtenemos el ID del usuario
    int? userId = await _authService.login(_userController.text, _passController.text);

    setState(() => _isLoading = false);

    if (userId != null) {
      // Navegamos al Home pasando el ID como argumento
      Navigator.pushReplacementNamed(
        context, 
        '/home', 
        arguments: userId
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Credenciales incorrectas"),
          behavior: SnackBarBehavior.floating, // Hace que el mensaje flote
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bordes redondeados
          margin: const EdgeInsets.only(
            bottom: 300, // Ajusta esta altura a tu gusto
            right: 20,
            left: 20,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ingreso al Sistema")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: InputDecoration(labelText: "Usuario")),
            TextField(controller: _passController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            SizedBox(height: 20),
            _isLoading 
              ? CircularProgressIndicator() 
              : ElevatedButton(
                onPressed: () {
                  print("Botón presionado");
                  _handleLogin();
                }, 
                child: Text("Ingresar")
              )
          ],
        ),
      ),
    );
  }
}
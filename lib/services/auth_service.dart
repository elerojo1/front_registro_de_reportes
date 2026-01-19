import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Cambiamos localhost por 10.0.2.2 y usamos tu puerto HTTP 5192
  final String _baseUrl = "http://10.0.2.2:5192/api/Usuarios";

  Future<int?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombreUsuario': username,
          'contra': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['usuarioId']; // Retornamos el ID directamente
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
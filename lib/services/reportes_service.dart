import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reporte_model.dart';
import 'package:path/path.dart';
import 'dart:io';

class ReportesService {
  // Usamos la misma base que el login (HTTP y IP 10.0.2.2 para el emulador)
  final String _baseUrl = "http://10.0.2.2:5192/api/Reportes";

  Future<List<Reporte>> obtenerReportesPorUsuario(int idUsuario) async {
    try {
      // Endpoint: /api/Reportes/GetReportePorUsuario/{idUsuario}
      final url = Uri.parse('$_baseUrl/GetReportePorUsuario/$idUsuario');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // La API regresa una lista de reportes
        List<dynamic> body = jsonDecode(response.body);
        
        // Convertimos el JSON a nuestra lista de objetos Reporte
        return body.map((dynamic item) => Reporte.fromJson(item)).toList();
      } else {
        print("Error al obtener reportes: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error de conexión en reportes: $e");
      return [];
    }
  }

  Future<bool> guardarReporte({
    required String titulo,
    required String descripcion,
    required int idUsuario,
    required File imagen,
  }) async {
    try {
      // Endpoint para guardar
      var request = http.MultipartRequest(
        'POST', 
        Uri.parse('http://10.0.2.2:5192/api/Reportes/Guardar')
      );

      // Agregamos los campos de texto
      request.fields['titulo'] = titulo;
      request.fields['descripcion'] = descripcion;
      request.fields['idUsuario'] = idUsuario.toString();
      request.fields['estatus'] = 'Pendiente'; // Estatus inicial

      // Agregamos el archivo de imagen
      var stream = http.ByteStream(imagen.openRead());
      var length = await imagen.length();
      var multipartFile = http.MultipartFile(
        'archivoImagen', // Este nombre debe coincidir con el parámetro en tu C#
        stream, 
        length,
        filename: basename(imagen.path)
      );

      request.files.add(multipartFile);

      // Enviamos la petición
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Reporte guardado con éxito");
        return true;
      } else {
        print("Error al guardar: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error de conexión al guardar: $e");
      return false;
    }
  }
}
import 'package:flutter/material.dart';
import '../models/reporte_model.dart';

class DetalleReporteScreen extends StatelessWidget {
  const DetalleReporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibimos el reporte completo como argumento
    final Reporte reporte = ModalRoute.of(context)!.settings.arguments as Reporte;

    return Scaffold(
      appBar: AppBar(title: Text("Detalle Folio: ${reporte.id}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSeccion("Título", reporte.titulo),
            _buildInfoSeccion("Descripción", reporte.descripcion),
            _buildInfoSeccion("Fecha de Registro", reporte.fechaRegistroFormateada),
            _buildInfoSeccion("Estatus", reporte.estatus, color: reporte.colorEstatus),
            
            const SizedBox(height: 20),
            const Text("Imagen del Reporte:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Renderizado de imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://10.0.2.2:5192/${reporte.rutaImagen}", // URL hacia tu carpeta uploads
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      Text("Imagen no disponible"),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(height: 40),
            _buildInfoSeccion("Fecha y Usuario de respuesta", "${reporte.fechaAutorizacionFormateada} - ${reporte.nombreCompleto ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSeccion(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color)),
        ],
      ),
    );
  }
}
import 'dart:io';
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
            _buildInfoSeccion("Fecha de Registro", reporte.fechaRegistro),
            _buildInfoSeccion("Estatus", reporte.estatus, color: reporte.colorEstatus),
            
            const SizedBox(height: 20),
            const Text("Imagen del Reporte:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Renderizado de imagen
            reporte.rutaImagen != null 
              ? Image.file(File(reporte.rutaImagen!), 
                  height: 250, 
                  width: double.infinity, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.broken_image, size: 100, color: Colors.grey))
              : const Text("No hay imagen adjunta"),

            const Divider(height: 40),
            const Text("Información de Resolución:", style: TextStyle(fontWeight: FontWeight.bold)),
            _buildInfoSeccion("Fecha y Usuario de respuesta", "Pendiente de procesar"),
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
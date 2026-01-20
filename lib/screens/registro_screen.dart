import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/reportes_service.dart';


class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final ReportesService _reportesService = ReportesService();
  final _tituloController = TextEditingController();
  final _descController = TextEditingController();
  File? _imagenSeleccionada;
  final ImagePicker _picker = ImagePicker();
  bool _cargando = false;

  // Función para capturar la foto con la cámara
  Future<void> _tomarFoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera, // Abre la cámara directamente
      imageQuality: 80, // Comprime un poco para no saturar el servidor
    );

    if (photo != null) {
      setState(() {
        _imagenSeleccionada = File(photo.path);
      });
    }
  }

  void _enviarReporte() async {
    // Recuperamos el ID del usuario actual (pasado por argumentos)
    final dynamic args = ModalRoute.of(context)!.settings.arguments;
    final int userId = args is int ? args : 0;

    if (_tituloController.text.isEmpty || _descController.text.isEmpty || _imagenSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complete todos los campos")),
      );
      return;
    }

    setState(() => _cargando = true);

    bool guardado = await _reportesService.guardarReporte(
      titulo: _tituloController.text,
      descripcion: _descController.text,
      idUsuario: userId,
      imagen: _imagenSeleccionada!,
    );

    setState(() => _cargando = false);

    if (guardado) {
      Navigator.pop(context); // Regresamos al listado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reporte enviado correctamente")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al enviar el reporte")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nuevo Reporte")), // Cambiado de app_appBar a appBar
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: "Título del Reporte"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
            const SizedBox(height: 25),
            
            // Contenedor de la foto
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _imagenSeleccionada == null
                  ? const Center(child: Text("No se ha tomado ninguna foto"))
                  : Image.file(_imagenSeleccionada!, fit: BoxFit.cover),
            ),
            
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _tomarFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Tomar Foto"),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                onPressed: _enviarReporte,
                child: const Text("ENVIAR REPORTE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
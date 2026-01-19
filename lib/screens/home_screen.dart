// screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/reporte_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo (Luego la traeremos de tu API)
    final List<Reporte> misReportes = [
      Reporte(folio: "001", titulo: "Falla de red", estatus: "Pendiente", descripcion: "No hay internet"),
      Reporte(folio: "002", titulo: "Equipo dañado", estatus: "Aceptado", descripcion: "Monitor roto"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Listado de Reporte")),
      body: ListView.builder(
        itemCount: misReportes.length,
        itemBuilder: (context, index) {
          final item = misReportes[index];
          return ListTile(
            leading: CircleAvatar(backgroundColor: item.colorEstatus, radius: 8),
            title: Text("Folio: ${item.folio}"),
            subtitle: Text(item.titulo),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Aquí irá el detalle del reporte
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/registro'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
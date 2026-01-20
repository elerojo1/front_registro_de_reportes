import 'package:flutter/material.dart';
import '../models/reporte_model.dart';
import '../services/reportes_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ReportesService _reportesService = ReportesService();

  @override
  Widget build(BuildContext context) {
    // Recuperamos el ID del usuario enviado desde el Login
    final int userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: const Text("Listado de Reporte")),
      body: FutureBuilder<List<Reporte>>(
        future: _reportesService.obtenerReportesPorUsuario(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar reportes"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tienes reportes registrados"));
          }

          final reportes = snapshot.data!;

          return ListView.builder(
            itemCount: reportes.length,
            itemBuilder: (context, index) {
              final item = reportes[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: item.colorEstatus, 
                  radius: 8
                ),
                title: Text("Folio: ${item.id} - ${item.titulo}"),
                subtitle: Text("Fecha: ${item.fechaRegistro.split('T')[0]}"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navegamos pasando el objeto 'item' completo
                  Navigator.pushNamed(
                    context, 
                    '/detalle', 
                    arguments: item
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/registro', arguments: userId),
        child: const Icon(Icons.add),
        tooltip: "Nuevo Reporte",
      ),
    );
  }
}
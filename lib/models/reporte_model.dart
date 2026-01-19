import 'package:flutter/material.dart';

class Reporte {
  final String folio;
  final String titulo;
  final String estatus; // "Pendiente", "Aceptado", "Rechazado"
  final String descripcion;

  Reporte({
    required this.folio, 
    required this.titulo, 
    required this.estatus, 
    required this.descripcion
  });

  // El color azul para pendientes que solicitaste
  Color get colorEstatus {
    switch (estatus.toLowerCase()) {
      case 'pendiente': return Colors.blue;
      case 'aceptado': return Colors.green;
      case 'rechazado': return Colors.red;
      default: return Colors.grey;
    }
  }

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      folio: json['id'].toString(),
      titulo: json['titulo'],
      estatus: json['estatus'],
      descripcion: json['descripcion'],
    );
  }
}
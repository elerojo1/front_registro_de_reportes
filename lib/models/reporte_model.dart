import 'package:flutter/material.dart';

class Reporte {
  final int id;
  final String titulo;
  final String descripcion;
  final String estatus;
  final String fechaRegistro;
  final String? rutaImagen;

  Reporte({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.estatus,
    required this.fechaRegistro,
    this.rutaImagen,
  });

  // Indicador de color: Azul para Pendiente, Verde para Aceptado, Rojo para Rechazado
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
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      estatus: json['estatus'] ?? 'Pendiente',
      fechaRegistro: json['fechaRegistro'] ?? '',
      // Accedemos al objeto anidado de la imagen para sacar la ruta
      rutaImagen: json['imagen'] != null ? json['imagen']['ruta'] : null,
    );
  }
}
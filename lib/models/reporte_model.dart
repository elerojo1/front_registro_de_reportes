import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reporte {
  final int id;
  final String titulo;
  final String descripcion;
  final String estatus;
  final String fechaRegistro;
  final String? rutaImagen;
  final String? nombreCompleto;
  final String? fechaAutorizacion;

  Reporte({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.estatus,
    required this.fechaRegistro,
    this.rutaImagen,
    this.nombreCompleto,
    this.fechaAutorizacion,
  });

  String get fechaRegistroFormateada {
    if (fechaRegistro.isEmpty) return "Sin fecha";
    DateTime dt = DateTime.parse(fechaRegistro);
    return DateFormat('dd/MM/yyyy - HH:mm').format(dt);
  }

  // Para la fecha de autorización (que es opcional)
String get fechaAutorizacionFormateada {
  if (fechaAutorizacion == null || fechaAutorizacion!.isEmpty) return "Pendiente";
  DateTime dt = DateTime.parse(fechaAutorizacion!);
  return DateFormat('dd/MM/yyyy').format(dt);
}

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
      nombreCompleto: json['nombreCompleto'],
      fechaAutorizacion: json['fechaAutorización'],
    );
  }
}
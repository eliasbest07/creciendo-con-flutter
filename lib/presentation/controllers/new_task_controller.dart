import 'package:TaskFlow/infrastructure/services/acortadores_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/services/acortadores_string.dart' show Acortador;

class NewTaskController extends StateNotifier<bool> {
  NewTaskController() : super(false);

  Acortador acortarFecha = Acortador();
  final TextEditingController controllerFechaInicio = TextEditingController();
  final TextEditingController controllerFechaEstablecida =
      TextEditingController();

  void actualizarEstado(bool stado) {
    state = stado; // para que se redibujen los widget xD
  }

  // he creado un nuevo metodo de actualizar estado ya que el estado de una tarea es una lista y no un bool: creada, tomada, en pausa, desistida, avanzada, terminada
  // recibe un nuevoEstado para actualizar en firebase el estado actualizado de dicha tarea
  void updateEstado(String nuevoEstado) {
    //TODO: actualizar a firebase
  }

// controllerDescription.text

  DateTime convertirFecha(String fechaStr) {
    print('Fecha string recibida a convertir: $fechaStr');
    print('Fecha string convertida: ${acortarFecha.getFixDate(fechaStr)}');
    const String formatoEsperado = 'dd/MM/yyyy';

    try {
      DateTime fecha = DateFormat(formatoEsperado)
          .parseStrict(acortarFecha.getFixDate(fechaStr));
      Fluttertoast.showToast(msg: 'Fecha convertida: $fecha');
      print('Fecha string convertida: $fechaStr');
      return fecha;
    } catch (e) {
      print('Error al convertir fecha: $e');
      Fluttertoast.showToast(
        msg: 'Error al convertir fecha de String a DateTime: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return DateTime
          .now(); // Puedes ajustar esto para devolver un valor predeterminado en caso de error.
    }
  }

/*   String _formatearFecha(String fechaStr, String formatoEsperado) {
  // Trunca o rellena la cadena de fecha para ajustarla al formato esperado
  String fechaFormateada = fechaStr.padRight(formatoEsperado.length, '0').substring(0, formatoEsperado.length);
print('Fecha formateada: $fechaFormateada');
  return fechaFormateada;
} */
}

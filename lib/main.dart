import 'package:flutter/material.dart';

import 'data/redondeo_exacto.dart';
import 'data/redondeo_hacia_arriba.dart';
import 'domain/calcular_division.dart';
import 'domain/validar_entrada.dart';
import 'presentation/divisor_controller.dart';
import 'presentation/formateador_moneda.dart';
import 'presentation/pantalla_divisor.dart';

void main() => runApp(crearApp());

/// Único punto de composición de dependencias de producción.
Widget crearApp() {
  final controlador = DivisorController(
    validar: const ValidarEntrada(),
    calcular: const CalcularDivision(),
    formateador: const FormateadorMoneda(),
    opciones: [
      OpcionRedondeo(
        id: 'exacto',
        etiqueta: 'Exacto',
        estrategia: RedondeoExacto(),
      ),
      OpcionRedondeo(
        id: 'arriba',
        etiqueta: 'Hacia arriba',
        estrategia: RedondeoHaciaArriba(),
      ),
    ],
  );
  final colores = ColorScheme.fromSeed(
    seedColor: const Color(0xFF176B58),
    brightness: Brightness.light,
  );
  return MaterialApp(
    title: 'Cuenta Clara',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: colores,
      scaffoldBackgroundColor: const Color(0xFFF8FAF7),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colores.outlineVariant),
        ),
      ),
    ),
    home: PantallaDivisor(controller: controlador),
  );
}

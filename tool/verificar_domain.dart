// Se ejecuta con Dart, sin importar Flutter ni su runner de pruebas.
import 'dart:io';

import 'package:divisor_cuenta/domain/cuenta.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';

import '../test/casos_de_prueba.dart';

void main() {
  const validar = ValidarEntrada();
  const calcular = CalcularDivision();
  final estrategias = <String, EstrategiaRedondeo>{
    'exacto': RedondeoExacto(),
    'arriba': RedondeoHaciaArriba(),
  };
  for (final caso in casos) {
    final cuenta = Cuenta(
      monto: caso.monto,
      personas: caso.personas,
      propina: caso.propina,
    );
    final error = validar.ejecutar(cuenta);
    if (error != caso.errorEsperado) {
      throw StateError('${caso.nombre}: error inesperado $error');
    }
    if (error == null) {
      final resultado = calcular
          .ejecutar(cuenta, estrategias[caso.modo]!)
          .porPersona;
      if ((resultado - caso.esperado!).abs() > 0.001) {
        throw StateError('${caso.nombre}: se obtuvo $resultado');
      }
    }
    stdout.writeln('OK ${caso.nombre}');
  }
  stdout.writeln('6/6 casos verificados con Dart puro.');
}

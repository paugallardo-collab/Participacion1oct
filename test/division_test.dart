import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/domain/cuenta.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';

import 'casos_de_prueba.dart';

// Solo fixture: demuestra una extensión sin modificar el caso de uso.
class RedondeoMultiploCinco implements EstrategiaRedondeo {
  @override
  double aplicar(double valor) => (valor / 5).round() * 5.0;
}

void main() {
  const validar = ValidarEntrada();
  const calcular = CalcularDivision();
  final estrategias = <String, EstrategiaRedondeo>{
    'exacto': RedondeoExacto(),
    'arriba': RedondeoHaciaArriba(),
  };
  for (final caso in casos) {
    test(caso.nombre, () {
      final cuenta = Cuenta(
        monto: caso.monto,
        personas: caso.personas,
        propina: caso.propina,
      );
      final error = validar.ejecutar(cuenta);
      if (caso.errorEsperado != null) {
        expect(error, caso.errorEsperado);
        return; // No se ejecuta el cálculo para entradas inválidas.
      }
      expect(error, isNull);
      expect(
        calcular.ejecutar(cuenta, estrategias[caso.modo]!).porPersona,
        closeTo(caso.esperado!, 0.001),
      );
    });
  }
  test('LSP: un mismo cálculo admite ambas estrategias sin if ni cast', () {
    const cuenta = Cuenta(monto: 10, personas: 3, propina: 0);
    final ejemplos = <(EstrategiaRedondeo, double)>[
      (RedondeoExacto(), 3.33),
      (RedondeoHaciaArriba(), 4),
    ];
    for (final ejemplo in ejemplos) {
      expect(
        calcular.ejecutar(cuenta, ejemplo.$1).porPersona,
        closeTo(ejemplo.$2, 0.001),
      );
    }
  });
  test('OCP: tercera estrategia sin cambiar CalcularDivision', () {
    expect(
      calcular
          .ejecutar(
            const Cuenta(monto: 24, personas: 2, propina: 0),
            RedondeoMultiploCinco(),
          )
          .porPersona,
      10,
    );
  });
}

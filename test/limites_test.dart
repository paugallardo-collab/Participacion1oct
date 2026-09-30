import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/domain/cuenta.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';
import 'package:divisor_cuenta/presentation/divisor_controller.dart';
import 'package:divisor_cuenta/presentation/formateador_moneda.dart';

class EstrategiaEspia implements EstrategiaRedondeo {
  int llamadas = 0;
  @override
  double aplicar(double valor) {
    llamadas++;
    return valor;
  }
}

void main() {
  const validar = ValidarEntrada();
  for (final monto in [-1.0, double.nan, double.infinity, 1000000001.0]) {
    test(
      'Rechaza monto $monto',
      () => expect(
        validar.ejecutar(Cuenta(monto: monto, personas: 2, propina: 0)),
        'Monto inválido',
      ),
    );
  }
  for (final propina in [-1.0, double.nan, double.infinity, 101.0]) {
    test(
      'Rechaza propina $propina',
      () => expect(
        validar.ejecutar(Cuenta(monto: 100, personas: 2, propina: propina)),
        'Propina inválida',
      ),
    );
  }
  test('Cero monto y extremos permitidos', () {
    expect(
      validar.ejecutar(const Cuenta(monto: 0, personas: 1, propina: 0)),
      isNull,
    );
    expect(
      validar.ejecutar(
        const Cuenta(monto: 1e9, personas: 1000000, propina: 100),
      ),
      isNull,
    );
    expect(
      validar.ejecutar(const Cuenta(monto: 1, personas: 1000001, propina: 0)),
      'Máximo 1000000 personas',
    );
  });
  test('Mitad de centavo, entero, cero y formato', () {
    expect(RedondeoExacto().aplicar(1.005), 1.01);
    expect(RedondeoHaciaArriba().aplicar(4), 4);
    expect(RedondeoHaciaArriba().aplicar(0), 0);
    expect(const FormateadorMoneda().formatear(4), '4.00');
  });
  test('Controlador no llama estrategia ante errores y recupera el estado', () {
    final espia = EstrategiaEspia();
    final controlador = DivisorController(
      validar: validar,
      calcular: const CalcularDivision(),
      formateador: const FormateadorMoneda(),
      opciones: [
        OpcionRedondeo(id: 'exacto', etiqueta: 'Exacto', estrategia: espia),
      ],
    );
    for (final datos in [
      ('abc', '2', '0'),
      ('50', '0', '0'),
      ('50', '1.5', '0'),
      ('50', '2', ''),
      ('', '2', '0'),
      ('50', '2', '101'),
    ]) {
      controlador.calcular(
        monto: datos.$1,
        personas: datos.$2,
        propina: datos.$3,
      );
      expect(controlador.error, isNotNull);
      expect(controlador.resultado, isNull);
    }
    expect(espia.llamadas, 0);
    controlador.calcular(monto: ' 100,00 ', personas: '4', propina: '10');
    expect(espia.llamadas, 1);
    expect(controlador.error, isNull);
    expect(controlador.resultado, '27.50');
    controlador.limpiar();
    expect(controlador.resultado, isNull);
  });
}

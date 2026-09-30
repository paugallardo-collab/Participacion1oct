import '../domain/cuenta.dart';
import '../domain/calcular_division.dart';
import '../domain/validar_entrada.dart';
import '../domain/estrategia_redondeo.dart';
import 'formateador_moneda.dart';

/// Identidad y etiqueta de una estrategia; permite construir el selector.
class OpcionRedondeo {
  final String id;
  final String etiqueta;
  final EstrategiaRedondeo estrategia;
  const OpcionRedondeo({
    required this.id,
    required this.etiqueta,
    required this.estrategia,
  });
}

class DivisorController {
  final ValidarEntrada _validar;
  final CalcularDivision _calcular;
  final FormateadorMoneda _formateador;
  final List<OpcionRedondeo> opciones;
  late OpcionRedondeo _seleccion;
  String? resultado;
  String? error;

  DivisorController({
    required this._validar,
    required this._calcular,
    required this._formateador,
    required List<OpcionRedondeo> opciones,
  }) : opciones = List.unmodifiable(opciones) {
    if (opciones.isEmpty) {
      throw ArgumentError('Debe existir un modo de redondeo');
    }
    _seleccion = opciones.first;
  }

  String get modo => _seleccion.id;

  void seleccionar(String id) {
    _seleccion = opciones.firstWhere((opcion) => opcion.id == id);
    limpiar();
  }

  void limpiar() {
    resultado = null;
    error = null;
  }

  double _numero(String texto) =>
      double.tryParse(texto.trim().replaceAll(',', '.')) ?? double.nan;

  void calcular({
    required String monto,
    required String personas,
    required String propina,
  }) {
    limpiar();
    final cuenta = Cuenta(
      monto: _numero(monto),
      personas: int.tryParse(personas.trim()) ?? 0,
      propina: _numero(propina),
    );
    error = _validar.ejecutar(cuenta);
    if (error != null) return;
    final division = _calcular.ejecutar(cuenta, _seleccion.estrategia);
    resultado = _formateador.formatear(division.porPersona);
  }
}

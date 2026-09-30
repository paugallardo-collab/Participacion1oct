import 'cuenta.dart';
import 'resultado.dart';
import 'estrategia_redondeo.dart';

class CalcularDivision {
  const CalcularDivision();

  /// Requiere una cuenta previamente validada. No valida ni formatea.
  Resultado ejecutar(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    final total = cuenta.monto * (1 + cuenta.propina / 100);
    return Resultado(porPersona: estrategia.aplicar(total / cuenta.personas));
  }
}

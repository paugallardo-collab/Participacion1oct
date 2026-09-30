import 'cuenta.dart';

class ValidarEntrada {
  const ValidarEntrada();

  /// null indica éxito; el primer error determina el mensaje de la pantalla.
  String? ejecutar(Cuenta cuenta) {
    if (!cuenta.monto.isFinite || cuenta.monto < 0 || cuenta.monto > 1e9) {
      return 'Monto inválido';
    }
    if (cuenta.personas < 1) return 'Debe haber al menos una persona';
    if (cuenta.personas > 1000000) return 'Máximo 1000000 personas';
    if (!cuenta.propina.isFinite ||
        cuenta.propina < 0 ||
        cuenta.propina > 100) {
      return 'Propina inválida';
    }
    return null;
  }
}

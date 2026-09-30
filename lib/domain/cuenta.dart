/// Datos de entrada. La validación pertenece a ValidarEntrada.
class Cuenta {
  final double monto;
  final int personas;
  final double propina;
  const Cuenta({
    required this.monto,
    required this.personas,
    required this.propina,
  });
}

import '../domain/estrategia_redondeo.dart';

class RedondeoExacto implements EstrategiaRedondeo {
  @override
  double aplicar(double valor) => (valor * 100 + 0.000001).round() / 100;
}

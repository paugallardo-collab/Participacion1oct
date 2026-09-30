# Instrucciones del proyecto

App Flutter de una sola pantalla para dividir una cuenta, sin conexión.

- Capas: lib/presentation -> lib/domain <- lib/data. Domain es Dart puro: nunca importa package:flutter.
- Null safety, nombres propios en español, sin dependencias externas de ejecución.
- main.dart compone e inyecta las implementaciones de redondeo; presentation usa abstracciones de domain.
- Consulta .specify/memory/constitution.md y specs/001-divisor-cuenta/ antes de cambiar funcionalidad.
- No modificar test/ sin solicitud. La actividad actual autoriza crear sus pruebas; una vez fijados los seis casos, corrige lib/ ante fallos.
- No agregar dependencias al pubspec sin avisar. No editar android/ ni ios/.
- Comandos: flutter pub get, flutter run, flutter analyze, flutter test.
- Toda función debe poder explicarse: propósito, entradas, salida y errores.

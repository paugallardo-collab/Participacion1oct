import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/main.dart';

void main() {
  const casos = [
    ('100', '4', '10', false, '27.50', false),
    ('90', '3', '0', false, '30.00', false),
    ('50', '0', '0', false, 'Debe haber al menos una persona', true),
    ('abc', '4', '0', false, 'Monto inválido', true),
    ('10', '3', '0', false, '3.33', false),
    ('10', '3', '0', true, '4.00', false),
  ];
  for (var i = 0; i < casos.length; i++) {
    final caso = casos[i];
    testWidgets('Aceptación ${i + 1}: ${caso.$5}', (tester) async {
      await tester.pumpWidget(const DivisorApp());
      await tester.enterText(find.byKey(const Key('monto')), caso.$1);
      await tester.enterText(find.byKey(const Key('personas')), caso.$2);
      await tester.enterText(find.byKey(const Key('propina')), caso.$3);
      if (caso.$4) {
        await tester.tap(find.byKey(const Key('modo_arriba')));
        await tester.pump();
      }
      await tester.tap(find.text('Calcular'));
      await tester.pump();
      expect(find.text(caso.$5), findsOneWidget);
      if (caso.$6) expect(find.byKey(const Key('resultado')), findsNothing);
    });
  }
}

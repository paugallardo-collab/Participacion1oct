import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/main.dart';

Future<void> ingresar(
  WidgetTester tester,
  String monto,
  String personas,
  String propina,
) async {
  await tester.enterText(find.byKey(const Key('monto')), monto);
  await tester.enterText(find.byKey(const Key('personas')), personas);
  await tester.enterText(find.byKey(const Key('propina')), propina);
}

Future<void> calcular(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Calcular'));
  await tester.tap(find.text('Calcular'));
  await tester.pump();
}

void main() {
  const escenarios = [
    ('100', '4', '10', false, '27.50', false),
    ('90', '3', '0', false, '30.00', false),
    ('50', '0', '0', false, 'Debe haber al menos una persona', true),
    ('abc', '4', '0', false, 'Monto inválido', true),
    ('10', '3', '0', false, '3.33', false),
    ('10', '3', '0', true, '4.00', false),
  ];
  for (var i = 0; i < escenarios.length; i++) {
    final caso = escenarios[i];
    testWidgets('Pantalla: escenario ${i + 1}', (tester) async {
      await tester.pumpWidget(crearApp());
      await ingresar(tester, caso.$1, caso.$2, caso.$3);
      if (caso.$4) {
        await tester.ensureVisible(find.byKey(const Key('modo_arriba')));
        await tester.tap(find.byKey(const Key('modo_arriba')));
        await tester.pump();
      }
      await calcular(tester);
      expect(find.text(caso.$5), findsOneWidget);
      if (caso.$6) expect(find.byKey(const Key('resultado')), findsNothing);
    });
  }
  testWidgets('Editar borra el resultado y un error no lo recupera', (
    tester,
  ) async {
    await tester.pumpWidget(crearApp());
    await ingresar(tester, '100', '4', '10');
    await calcular(tester);
    expect(find.text('27.50'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('personas')), '0');
    await tester.pump();
    expect(find.byKey(const Key('resultado')), findsNothing);
    await calcular(tester);
    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(find.byKey(const Key('resultado')), findsNothing);
  });
  testWidgets('Cambiar modo borra resultado; acepta coma decimal', (
    tester,
  ) async {
    await tester.pumpWidget(crearApp());
    await ingresar(tester, '10,00', '3', '0');
    await calcular(tester);
    expect(find.text('3.33'), findsOneWidget);
    await tester.tap(find.byKey(const Key('modo_arriba')));
    await tester.pump();
    expect(find.byKey(const Key('resultado')), findsNothing);
    await calcular(tester);
    expect(find.text('4.00'), findsOneWidget);
  });
  testWidgets('Pantalla estrecha y texto grande sin desbordamiento', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
        child: crearApp(),
      ),
    );
    await ingresar(tester, '100', '4', '10');
    await calcular(tester);
    expect(find.text('27.50'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

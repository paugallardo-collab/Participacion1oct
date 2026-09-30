import 'package:flutter/material.dart';

void main() => runApp(const DivisorApp());

class DivisorApp extends StatelessWidget {
  const DivisorApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Divisor de cuenta',
    theme: ThemeData(colorSchemeSeed: const Color(0xFF176B58)),
    home: const PantallaCuenta(),
  );
}

class PantallaCuenta extends StatefulWidget {
  const PantallaCuenta({super.key});
  @override
  State<PantallaCuenta> createState() => _PantallaCuentaState();
}

class _PantallaCuentaState extends State<PantallaCuenta> {
  final _monto = TextEditingController();
  final _personas = TextEditingController(text: '2');
  final _propina = TextEditingController(text: '0');
  bool _arriba = false;
  String? _resultado;
  String? _error;

  void _limpiar() => setState(() {
    _resultado = null;
    _error = null;
  });

  void _calcular() {
    final monto = double.tryParse(_monto.text.trim().replaceAll(',', '.'));
    final personas = int.tryParse(_personas.text.trim());
    final propina = double.tryParse(_propina.text.trim().replaceAll(',', '.'));
    setState(() {
      _resultado = null;
      _error = null;
      if (monto == null || !monto.isFinite || monto < 0) {
        _error = 'Monto inválido';
      } else if (personas == null || personas < 1) {
        _error = 'Debe haber al menos una persona';
      } else if (propina == null || !propina.isFinite || propina < 0) {
        _error = 'Propina inválida';
      } else {
        final valor = monto * (1 + propina / 100) / personas;
        if (!valor.isFinite) {
          _error = 'Monto inválido';
          return;
        }
        _resultado = (_arriba ? valor.ceilToDouble() : valor).toStringAsFixed(
          2,
        );
      }
    });
  }

  @override
  void dispose() {
    _monto.dispose();
    _personas.dispose();
    _propina.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Divisor de cuenta')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Comparte la cuenta',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              key: const Key('monto'),
              controller: _monto,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Monto total',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _limpiar(),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('personas'),
              controller: _personas,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Personas',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _limpiar(),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('propina'),
              controller: _propina,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Propina (%)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _limpiar(),
            ),
            SwitchListTile(
              key: const Key('modo_arriba'),
              title: const Text('Redondear hacia arriba'),
              subtitle: const Text('Desactivado: exacto, con dos decimales'),
              value: _arriba,
              onChanged: (valor) {
                _limpiar();
                setState(() => _arriba = valor);
              },
            ),
            FilledButton(onPressed: _calcular, child: const Text('Calcular')),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_resultado != null) ...[
              const SizedBox(height: 24),
              const Text('Cada persona paga'),
              Text(
                _resultado!,
                key: const Key('resultado'),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import 'divisor_controller.dart';

class PantallaDivisor extends StatefulWidget {
  final DivisorController controller;
  const PantallaDivisor({super.key, required this.controller});
  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _monto = TextEditingController();
  final _personas = TextEditingController(text: '2');
  final _propina = TextEditingController(text: '0');

  void _calcular() {
    FocusScope.of(context).unfocus();
    setState(
      () => widget.controller.calcular(
        monto: _monto.text,
        personas: _personas.text,
        propina: _propina.text,
      ),
    );
  }

  @override
  void dispose() {
    _monto.dispose();
    _personas.dispose();
    _propina.dispose();
    super.dispose();
  }

  Widget _campo(
    String id,
    String etiqueta,
    TextEditingController control, {
    String? ayuda,
    bool entero = false,
    bool ultimo = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: TextField(
      key: Key(id),
      controller: control,
      keyboardType: TextInputType.numberWithOptions(decimal: !entero),
      textInputAction: ultimo ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(labelText: etiqueta, helperText: ayuda),
      onChanged: (_) => setState(widget.controller.limpiar),
      onSubmitted: ultimo ? (_) => _calcular() : null,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final controlador = widget.controller;
    final colores = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long_rounded, color: colores.primary),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'CUENTA CLARA',
                          style: TextStyle(
                            color: colores.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Divide la cuenta.',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Un cálculo sencillo para compartir la mesa.',
                    style: TextStyle(
                      fontSize: 16,
                      color: colores.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _campo(
                    'monto',
                    'Monto total',
                    _monto,
                    ayuda: 'Sin propina · usa punto o coma decimal',
                  ),
                  _campo('personas', 'Personas', _personas, entero: true),
                  _campo(
                    'propina',
                    'Propina (%)',
                    _propina,
                    ayuda: 'De 0 a 100 %',
                    ultimo: true,
                  ),
                  const Text(
                    'Redondeo',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      for (final opcion in controlador.opciones)
                        ChoiceChip(
                          key: Key('modo_${opcion.id}'),
                          label: Text(opcion.etiqueta),
                          selected: controlador.modo == opcion.id,
                          onSelected: (_) => setState(
                            () => controlador.seleccionar(opcion.id),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Exacto: dos decimales. Hacia arriba: siguiente entero.',
                    style: TextStyle(
                      fontSize: 12,
                      color: colores.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _calcular,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Calcular'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Semantics(
                    liveRegion: true,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: controlador.error != null
                            ? colores.errorContainer
                            : colores.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: controlador.error != null
                          ? Text(
                              controlador.error!,
                              style: TextStyle(
                                color: colores.onErrorContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cada persona paga',
                                  style: TextStyle(
                                    color: colores.onPrimaryContainer,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (controlador.resultado != null)
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      controlador.resultado!,
                                      key: const Key('resultado'),
                                      style: TextStyle(
                                        fontSize: 44,
                                        fontWeight: FontWeight.w800,
                                        color: colores.onPrimaryContainer,
                                      ),
                                    ),
                                  )
                                else
                                  Text(
                                    'Completa los datos y toca Calcular.',
                                    style: TextStyle(
                                      color: colores.onPrimaryContainer,
                                    ),
                                  ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

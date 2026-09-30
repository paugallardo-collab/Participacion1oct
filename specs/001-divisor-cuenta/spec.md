# Feature Specification: Divisor de cuenta

**Feature Branch**: `sdd`
**Created**: 2026-09-30
**Status**: Ready for planning
**Input**: Una pantalla para dividir una cuenta entre personas, con propina y dos modos de redondeo.

## User Scenarios & Testing

### User Story 1 - Repartir una cuenta (Priority: P1)

Como comensal, ingreso monto, personas y porcentaje de propina y veo cuánto paga cada persona.
**Why this priority**: es la necesidad central del producto.
**Independent Test**: ingresar los datos y tocar Calcular.

**Acceptance Scenarios**:
1. **Given** 100.00, 4 personas, 10%, exacto, **When** calculo, **Then** veo 27.50.
2. **Given** 90.00, 3 personas, 0%, exacto, **When** calculo, **Then** veo 30.00.

### User Story 2 - Corregir entradas inválidas (Priority: P1)

Como comensal, veo un mensaje comprensible y ningún resultado si la entrada no se puede calcular.
**Why this priority**: evita mostrar valores engañosos.
**Independent Test**: enviar un monto inválido o cero personas.

**Acceptance Scenarios**:
3. **Given** 50.00 y 0 personas, **When** calculo, **Then** veo "Debe haber al menos una persona" y ningún resultado.
4. **Given** monto "abc", **When** calculo, **Then** veo "Monto inválido" y ningún resultado.

### User Story 3 - Elegir redondeo (Priority: P2)

Como comensal, elijo exacto o hacia arriba al entero más cercano.
**Why this priority**: da las dos formas de reparto solicitadas.
**Independent Test**: cambiar el modo con la misma cuenta.

**Acceptance Scenarios**:
5. **Given** 10.00, 3 personas, 0%, exacto, **When** calculo, **Then** veo 3.33.
6. **Given** 10.00, 3 personas, 0%, hacia arriba, **When** calculo, **Then** veo 4.00.

### Edge Cases

- Vacío, texto, NaN, infinito, monto negativo: "Monto inválido".
- Personas vacías, fraccionarias, negativas o cero: "Debe haber al menos una persona".
- Propina vacía, no numérica, negativa o no finita: "Propina inválida".
- Cero monto y cero propina son válidos.
- Una entrada nueva o cambio de modo elimina el resultado anterior hasta volver a calcular.
- Aceptar punto o coma decimal sin separadores de miles; mostrar punto y dos decimales.
- Evitar valores desbordados mediante los límites declarados en Assumptions.

## Requirements

### Functional Requirements

- **FR-001**: ingresar monto total, número entero de personas y porcentaje de propina en una pantalla.
- **FR-002**: calcular (monto × (1 + propina / 100)) / personas al tocar Calcular.
- **FR-003**: elegir exacto (redondeo a centavos) o hacia arriba (techo al entero).
- **FR-004**: mostrar el pago por persona con exactamente dos decimales.
- **FR-005**: validar antes de calcular; ante error, no mostrar resultados antiguos ni nuevos.
- **FR-006**: funcionar sin conexión, sin cuentas de usuario, red, historial ni base de datos.
- **FR-007**: permitir corregir y recalcular; eliminar resultados al modificar entradas o modo.

### Key Entities

- **Cuenta**: monto total, personas, porcentaje de propina.
- **Resultado**: importe numérico por persona.
- **Modo de redondeo**: exacto o hacia arriba.

## Success Criteria

### Measurable Outcomes

- **SC-001**: los seis escenarios producen exactamente los mensajes e importes especificados.
- **SC-002**: una entrada inválida nunca deja un resultado visible.
- **SC-003**: el usuario resuelve la división en una pantalla y una pulsación de Calcular.
- **SC-004**: el cálculo no necesita conexión a Internet.

## Assumptions

Decisiones del agente documentadas antes de programar, no respuestas atribuidas al estudiante:
- La moneda es genérica; no hay conversión ni símbolo monetario que presuponga dólares o pesos.
- Inicio: monto vacío, 2 personas, 0% de propina, redondeo exacto.
- Se admiten montos entre 0 y 1 000 000 000, personas entre 1 y 1 000 000 y propina entre 0 y 100.
  Los límites evitan desbordamiento y entradas absurdas para una cuenta de restaurante.
  Fuera del límite de monto: "Monto inválido"; propina: "Propina inválida";
  más de un millón de personas: "Máximo 1000000 personas".
- Exacto significa dos decimales por persona, no redistribuir centavos sobrantes entre personas.
  Por ejemplo 3 × 3.33 = 9.99; esta app no administra el centavo sobrante.
- Se redondean mitades hacia arriba con tolerancia pequeña a errores de representación binaria.
- Accesibilidad: etiquetas de campos, desplazamiento vertical y mensajes de error legibles.

## Clarifications

### Session 2026-09-30

No se hicieron preguntas: los seis escenarios, la fórmula, ambos modos y la ausencia de red
ya estaban definidos. Los detalles menores se registraron como supuestos, no como respuestas
inventadas del usuario. Alcance, datos, interacción, restricciones, términos y aceptación:
claros. Concurrencia, identidades, servicios externos y escalado: no aplican a una calculadora local.

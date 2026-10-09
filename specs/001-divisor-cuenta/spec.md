# Especificación funcional: Divisor de cuenta

**Rama de la funcionalidad**: `sdd`
**Creada**: 2026-09-30
**Estado**: Lista para planificar
**Entrada**: Una pantalla para dividir una cuenta entre personas, con propina y dos modos de redondeo.

## Escenarios de usuario y pruebas

### Historia de usuario 1 - Repartir una cuenta (Prioridad: P1)

Como comensal, ingreso monto, personas y porcentaje de propina y veo cuánto paga cada persona.
**Motivo de la prioridad**: es la necesidad central del producto.
**Prueba independiente**: ingresar los datos y tocar Calcular.

**Escenarios de aceptación**:
1. **Dado** 100.00, 4 personas, 10%, exacto, **Cuando** calculo, **Entonces** veo 27.50.
2. **Dado** 90.00, 3 personas, 0%, exacto, **Cuando** calculo, **Entonces** veo 30.00.

### Historia de usuario 2 - Corregir entradas inválidas (Prioridad: P1)

Como comensal, veo un mensaje comprensible y ningún resultado si la entrada no se puede calcular.
**Motivo de la prioridad**: evita mostrar valores engañosos.
**Prueba independiente**: enviar un monto inválido o cero personas.

**Escenarios de aceptación**:
3. **Dado** 50.00 y 0 personas, **Cuando** calculo, **Entonces** veo "Debe haber al menos una persona" y ningún resultado.
4. **Dado** monto "abc", **Cuando** calculo, **Entonces** veo "Monto inválido" y ningún resultado.

### Historia de usuario 3 - Elegir redondeo (Prioridad: P2)

Como comensal, elijo exacto o hacia arriba al entero más cercano.
**Motivo de la prioridad**: da las dos formas de reparto solicitadas.
**Prueba independiente**: cambiar el modo con la misma cuenta.

**Escenarios de aceptación**:
5. **Dado** 10.00, 3 personas, 0%, exacto, **Cuando** calculo, **Entonces** veo 3.33.
6. **Dado** 10.00, 3 personas, 0%, hacia arriba, **Cuando** calculo, **Entonces** veo 4.00.

### Casos límite

- Vacío, texto, NaN, infinito, monto negativo: "Monto inválido".
- Personas vacías, fraccionarias, negativas o cero: "Debe haber al menos una persona".
- Propina vacía, no numérica, negativa o no finita: "Propina inválida".
- Cero monto y cero propina son válidos.
- Una entrada nueva o cambio de modo elimina el resultado anterior hasta volver a calcular.
- Aceptar punto o coma decimal sin separadores de miles; mostrar punto y dos decimales.
- Evitar valores desbordados mediante los límites declarados en Assumptions.

## Requisitos

### Requisitos funcionales

- **FR-001**: ingresar monto total, número entero de personas y porcentaje de propina en una pantalla.
- **FR-002**: calcular (monto × (1 + propina / 100)) / personas al tocar Calcular.
- **FR-003**: elegir exacto (redondeo a centavos) o hacia arriba (techo al entero).
- **FR-004**: mostrar el pago por persona con exactamente dos decimales.
- **FR-005**: validar antes de calcular; ante error, no mostrar resultados antiguos ni nuevos.
- **FR-006**: funcionar sin conexión, sin cuentas de usuario, red, historial ni base de datos.
- **FR-007**: permitir corregir y recalcular; eliminar resultados al modificar entradas o modo.
- **FR-008**: si la propina supera 100%, mostrar exactamente "La propina no puede superar el 100%" y no calcular. Una propina de exactamente 100% sí está permitida (Deber 3, 2026-10-09).

### Entidades principales

- **Cuenta**: monto total, personas, porcentaje de propina.
- **Resultado**: importe numérico por persona.
- **Modo de redondeo**: exacto o hacia arriba.

## Criterios de éxito

### Resultados medibles

- **SC-001**: los seis escenarios producen exactamente los mensajes e importes especificados.
- **SC-002**: una entrada inválida nunca deja un resultado visible.
- **SC-003**: el usuario resuelve la división en una pantalla y una pulsación de Calcular.
- **SC-004**: el cálculo no necesita conexión a Internet.

## Supuestos

Decisiones del agente documentadas antes de programar, no respuestas atribuidas al estudiante:
- La moneda es genérica; no hay conversión ni símbolo monetario que presuponga dólares o pesos.
- Inicio: monto vacío, 2 personas, 0% de propina, redondeo exacto.
- Se admiten montos entre 0 y 1 000 000 000, personas entre 1 y 1 000 000 y propina entre 0 y 100.
  Los límites evitan desbordamiento y entradas absurdas para una cuenta de restaurante.
  Fuera del límite de monto: "Monto inválido"; propina superior a 100%: "La propina no puede superar el 100%";
  propina negativa, no finita o no numérica: "Propina inválida";
  más de un millón de personas: "Máximo 1000000 personas".
- Exacto significa dos decimales por persona, no redistribuir centavos sobrantes entre personas.
  Por ejemplo 3 × 3.33 = 9.99; esta app no administra el centavo sobrante.
- Se redondean mitades hacia arriba con tolerancia pequeña a errores de representación binaria.
- Accesibilidad: etiquetas de campos, desplazamiento vertical y mensajes de error legibles.

## Aclaraciones

### Sesión 2026-09-30

No se hicieron preguntas: los seis escenarios, la fórmula, ambos modos y la ausencia de red
ya estaban definidos. Los detalles menores se registraron como supuestos, no como respuestas
inventadas del usuario. Alcance, datos, interacción, restricciones, términos y aceptación:
claros. Concurrencia, identidades, servicios externos y escalado: no aplican a una calculadora local.

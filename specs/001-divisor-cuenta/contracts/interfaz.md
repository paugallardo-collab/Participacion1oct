# Contrato de interfaz

Campos con etiquetas Monto total, Personas y Propina (%), botón Calcular y dos opciones:
Exacto y Hacia arriba. Resultado numérico separado del texto "Cada persona paga".

Claves para comprobación de interfaz: monto, personas, propina, modo_arriba, resultado.
Los textos de errores y los seis ejemplos son los de ../spec.md. Enter en propina también calcula.
No hay servicios HTTP. El contrato de estrategia es aplicar(double) -> double, sin dependencias de UI.

Para añadir una estrategia: implementar EstrategiaRedondeo, probarla y registrarla en el mapa de
main.dart con su etiqueta. La pantalla recorre ese mapa y el cálculo permanece intacto.

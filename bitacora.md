# Bitácora Deber 2

Migración basada en Participacion1oct/sdd, snapshot 32d62a1. El laboratorio no registró tiempos ni intervenciones observadas: se dejan como «no registrado». React corresponde a esta sesión autorizada por el estudiante.

| Métrica | Flutter (laboratorio) | React (este deber) |
|---|---|---|
| Minutos hasta primera compilación correcta | no registrado | 15.06 |
| Minutos hasta que pasan los 6 casos | no registrado | 15.10 |
| Iteraciones de corrección del estudiante | no registrado | 0 |
| Líneas de código escritas directamente por estudiante | no registrado | 0; código generado por agente |
| Enunciados modificados en spec | — | 0 de 68 |
| Enunciados modificados en Constitution | — | 13 de 30, todos adaptados |
| Enunciados del plan modificados | — | 34 de 50 |
| Líneas físicas del plan | — | Ver numstat en comparacion_plan.md; no es la métrica de enunciados |
| Casos de aceptación | 6/6 verificados en rama sdd | 6/6 |

- Inicio speckit-plan: 02/10/2026, 19:53:08 (America/Bogota).
- Primera compilación: 02/10/2026, 20:08:11. El cronómetro siguió corriendo.
- Fin, seis casos verdes: 02/10/2026, 20:08:14. No incluye tiempo posterior de documentación, verificaciones y subida.
- Instantes UTC originales: [tiempos.json](https://github.com/paugallardo-collab/divisor_cuenta_web/blob/main/evidencias/tiempos.json) en React.
- Las herramientas y correcciones autónomas del agente no son iteraciones del estudiante. El pedido inicial no cuenta.
- Base Flutter: 28 pruebas, All tests passed! React: 39 pruebas (6 casos + LSP + 3 pantalla + 29 adicionales).
- speckit-constitution, plan, tasks, analyze e implement se ejecutaron como workflows del agente; los scripts de contexto se conservan en evidencias. No se ejecutó speckit-specify.
- Spec Kit 1.0.13 sí ofrece speckit-converge. Revisión final y resultado en evidencias/convergencia.md del repo React.
- Investigación de compatibilidad delegada por instrucción del flujo plan; no altera el conteo de prompts del estudiante.
- Revisión visual real del navegador pendiente: herramienta de navegador sin superficies conectadas (listBrowsers devolvió []). Vite arrancó en 127.0.0.1:5173; UI funcional cubierta por Testing Library.
- Ejercicios requeridos a mano: analisis_spec.md y test/casosDePrueba.js son borradores del agente; el estudiante debe realizar/revisar su propia clasificación y traducción, y poder explicar las funciones.

La diferencia de tiempo no demuestra superioridad del enfoque: no hay medición comparable de Flutter ni experimento controlado.

# Bitácora · Semana 7

## Métricas verificadas

| Métrica | vibe | sdd |
|---|---|---|
| Iteraciones del estudiante tras solicitud inicial | 0 | 0 |
| Casos de aceptación | 6/6 automatizados | 6/6 automatizados |
| Pruebas propias que pasan | 6 | 28 |
| Archivos Dart en lib | 1 | 11 |
| Líneas en lib, incluidos blancos y comentarios | 155 | 414 |
| Domain depende de Flutter | No existe domain; lógica en widget | No |
| Capas presentation/domain/data | No | Sí |
| Decisiones no pedidas literalmente | Coma decimal, limpieza de resultados, validación | Nombre/estética, límites de entrada declarados |
| Extender redondeo sin modificar cálculo | No | Sí |

No se midió tiempo. Iteraciones significa mensajes del estudiante, no llamadas a herramientas
ni correcciones autónomas. Las métricas están limitadas por el contexto compartido entre ramas.

## Registro de etapas

1. Leer guía y PPT. Verificar carpeta vacía, Git padre y Flutter/Android/Chrome instalados.
2. Crear scaffold y commit 934956a; crear main/vibe/sdd desde la misma base. Caso Git C.
3. Vibe: implementación directa, seis pruebas de widgets y análisis limpios; commit e86af0c.
4. SDD: AGENTS.md, instalación real de Spec Kit 1.0.13 con uv, habilidades Codex y PowerShell.
5. Constitution, specify y revisión clarify sin preguntas; supuestos explícitos.
6. Plan, modelos, contrato, guía rápida y 16 tareas. Analyze: sin bloqueos; cobertura 7/7 FR.
7. Pruebas de dominio fallan por clases ausentes; evidencia sdd-pruebas-antes.txt.
8. Implementación por capas. Correcciones autónomas de estilo y desbordamiento con texto grande.
9. Resultado final: 28 pruebas pasan, analyze limpio, Dart puro 6/6, SOLID verificado, APK compilado.
10. Trasladar tests SDD a vibe: falla compilación por clases inexistentes. Restaurar test/:
    los seis tests vibe vuelven a pasar. No modificar vibe para adaptar sus contratos.
11. Integrar SDD en main y redactar respuestas, guía y esta bitácora.

## Evidencia y límites

- Agente: Codex, familia GPT-6 según entorno; modelo exacto y nivel de razonamiento no expuestos.
- Misma sesión/configuración, sin subagentes ni otros modelos; no es una comparación ciega.
- No se atribuyen al estudiante preguntas/respuestas que no hizo.
- Revisión manual pendiente: no había navegador conectado a la herramienta de control.
- GitHub: el 2026-10-01 el estudiante solicitó la subida. Se publicaron main, vibe y sdd en https://github.com/paugallardo-collab/Participacion1oct (privado). La publicación pública fue rechazada por la revisión automática al no haber autorización expresa de visibilidad; se completó en privado.
- La revisión automática rechazó una modificación persistente de safe.directory global.
  No se aplicó. La guía muestra la alternativa acotada con `git -c` por comando.
- No se reportan créditos consumidos: esa cifra no está disponible para el agente.

Los resultados y la interpretación completa se encuentran en respuestas.md y evidencias/.

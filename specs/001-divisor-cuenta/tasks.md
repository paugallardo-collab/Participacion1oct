# Tasks: Divisor de cuenta

Input: spec.md, plan.md, research.md, data-model.md, contracts/interfaz.md.
Pruebas exigidas por la práctica. 16 tareas. Implementación secuencial en una sola sesión.

## Phase 1: Setup

- [x] T001 Retirar cupertino_icons de pubspec.yaml y crear directorios lib/domain, lib/data, lib/presentation, tool; mantener flutter_lints de desarrollo.

## Phase 2: Foundational

- [x] T002 Fijar los seis escenarios sin alterar expectativas en test/casos_de_prueba.dart y el runner test/division_test.dart; ejecutar antes de implementar y observar fallo por clases ausentes.
- [x] T003 Crear modelos inmutables en lib/domain/cuenta.dart y lib/domain/resultado.dart y contrato de un método en lib/domain/estrategia_redondeo.dart.

## Phase 3: User Story 1 — reparto (P1)

Objetivo: cálculo con propina; prueba independiente: escenarios 1 y 2.
- [x] T004 [US1] Crear prueba de resultado 27.50 en test/pantalla_test.dart antes de implementar la UI.
- [x] T005 [US1] Crear cálculo con estrategia inyectada en lib/domain/calcular_division.dart y formato de dos decimales en lib/presentation/formateador_moneda.dart.
- [x] T006 [US1] Crear lib/data/redondeo_exacto.dart para redondear a centavos con la tolerancia de plan.md.

## Phase 4: User Story 2 — validación (P1)

Objetivo: errores sin cálculo; prueba independiente: escenarios 3 y 4.
- [x] T007 [US2] Agregar errores, borrado de resultados, coma decimal y límites a test/pantalla_test.dart y test/limites_test.dart antes de implementar.
- [x] T008 [US2] Crear lib/domain/validar_entrada.dart: monto finito entre 0 y 1000000000; personas enteras entre 1 y 1000000; propina finita entre 0 y 100; mensajes de spec.md.
- [x] T009 [US2] Crear lib/presentation/divisor_controller.dart con conversión de texto, validación previa, dependencias por constructor y limpieza de resultados; nunca calcular entradas inválidas.

## Phase 5: User Story 3 — redondeo y pantalla (P2)

Objetivo: seleccionar estrategia; prueba independiente: escenarios 5 y 6 y sustitución LSP.
- [x] T010 [US3] Probar ambos modos y una tercera estrategia de prueba en test/division_test.dart y test/pantalla_test.dart.
- [x] T011 [US3] Crear lib/data/redondeo_hacia_arriba.dart con ceilToDouble y contrato común.
- [x] T012 [US3] Crear pantalla adaptable con setState en lib/presentation/pantalla_divisor.dart y composición en lib/main.dart; selector generado desde estrategias inyectadas, etiquetas y Enter para calcular.

## Phase 6: Verificación y explicación

- [x] T013 Crear tool/verificar_domain.dart (mismos casos sin Flutter) y tool/verificar_arquitectura.ps1 (capas, SRP y composición).
- [x] T014 Ejecutar formato, flutter analyze, flutter test, Dart puro, verificación SOLID y flutter build apk --debug; conservar evidencia en evidencias/.
- [x] T015 Escribir README.md y GUIA_APP.md con ejecución, fórmula y explicación de cada función.
- [x] T016 Revisar converge contra los siete FR, cuatro SC, seis escenarios, plan y constitución; registrar evidencia en evidencias/convergencia.md.

## Dependencies & Execution Order

T001 -> T002 -> T003 -> pruebas T004/T007/T010 -> T005/T006/T008/T011 -> T009 -> T012 -> T013 -> T014 -> T015 -> T016.
Se escriben juntas las pruebas para evitar cambios posteriores de expectativas. US1/US2/US3 se comprueban
independientemente con su subconjunto de escenarios una vez compuesta la pantalla.

## Parallel Opportunities

US1: cálculo y formato son archivos independientes. US2: pruebas de límites y de pantalla pueden prepararse
por separado. US3: estrategia y pruebas de sustitución están separadas. Se ejecutan secuencialmente para
reducir coste; estas oportunidades no implican que se hayan usado subagentes.

## Implementation Strategy

Primero contratos y pruebas; luego cálculo, validación y redondeos; finalmente pantalla y comprobación completa.
No publicar en servicios remotos sin destino confirmado. El cierre académico (comparación/respuestas)
se registra en main una vez completadas ambas ramas.


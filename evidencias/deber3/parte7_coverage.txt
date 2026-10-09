# Cobertura de líneas

Medición real con `flutter test --no-pub --coverage --reporter expanded`.

| Archivo | Líneas cubiertas | Líneas ejecutables | Cobertura |
| --- | ---: | ---: | ---: |
| `lib/data/redondeo_exacto.dart` | 2 | 2 | 100.00% |
| `lib/data/redondeo_hacia_arriba.dart` | 2 | 2 | 100.00% |
| `lib/domain/calcular_division.dart` | 4 | 4 | 100.00% |
| `lib/domain/cuenta.dart` | 1 | 1 | 100.00% |
| `lib/domain/estrategia_redondeo.dart` | — | — | No aplica: contrato abstracto |
| `lib/domain/resultado.dart` | 1 | 1 | 100.00% |
| `lib/domain/validar_entrada.dart` | 7 | 7 | 100.00% |
| `lib/main.dart` | 16 | 17 | 94.12% |
| `lib/presentation/divisor_controller.dart` | 24 | 25 | 96.00% |
| `lib/presentation/formateador_moneda.dart` | 2 | 2 | 100.00% |
| `lib/presentation/pantalla_divisor.dart` | 88 | 89 | 98.88% |

Total: **147/150 líneas (98.00%)**.

## Interpretación

`lib/main.dart` tiene el porcentaje más bajo: 16/17 líneas (94.12%).
La función `main()` que llama a `runApp` no se ejecuta: las pruebas de pantalla
usan directamente `crearApp()`. Esto señala una ruta sin probar, no un error.

`lib/domain/estrategia_redondeo.dart` declara únicamente un contrato abstracto.
LCOV no lo incluye porque no contiene líneas ejecutables; no equivale a 0%.

Líneas ejecutables sin cobertura:
- `lib/main.dart`: 11.
- `lib/presentation/divisor_controller.dart`: 35.
- `lib/presentation/pantalla_divisor.dart`: 52.

La cobertura mide qué líneas se ejecutaron, no la corrección de todos los resultados.
El archivo original `coverage/lcov.info` permanece local y está excluido de Git.

# Revisión del código antes de refactorizar

Revisión de `lib/` después de la etapa verde y de retirar los avisos temporales
del linter. Las líneas corresponden al commit verde, antes de refactorizar.

| Archivo y línea | Problema de mantenibilidad | Por qué dificulta un cambio |
| --- | --- | --- |
| `lib/domain/validar_entrada.dart:16` | Número mágico: `100` como límite de propina | El literal no nombra la regla de negocio. Una constante permite identificar el límite al leer la condición. |
| `lib/domain/validar_entrada.dart:8` y `:12` | Límites numéricos sin nombre: `1e9` y `1000000` | Su propósito exige consultar la especificación. Podrían tener constantes propias, pero quedan fuera de la refactorización elegida. |
| `lib/data/redondeo_exacto.dart:5` | Tolerancia literal: `0.000001` | El plan explica que compensa la representación binaria, pero la expresión no lo dice. Un nombre facilitaría la lectura. Se conserva para limitar el alcance. |

## Elección

Se refactoriza únicamente el límite de propina `100`: se extrae a la constante
privada `_propinaMaxima` de `ValidarEntrada`. El valor, el operador `>`, el orden
de validación y el mensaje de error permanecen iguales. Las pruebas quedan
fijadas desde el commit rojo.

El linter no marca estos números porque son expresiones válidas y sus reglas
no conocen el significado de cada límite del negocio.

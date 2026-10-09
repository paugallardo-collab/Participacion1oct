# Respuestas del Deber 3

## 1. Rojo antes de verde

La prueba mostró `Expected: 'La propina no puede superar el 100%'` y
`Actual: 'Propina inválida'`. La aplicación ya rechazaba porcentajes superiores
a 100, pero usaba otro mensaje. Ver el fallo primero demostró que la prueba
detectaba el requisito pendiente; después permitió comprobar que el cambio lo
corrigió. La prueba de exactamente 100% pasó desde el inicio.

## 2. Linter e IA

`flutter analyze` mostró `unused_local_variable` por `variableSinUsar` y
`avoid_print` por `print('hola')`, agregados temporalmente para la demostración.
La revisión con IA señaló el número mágico `100` en el límite de propina.
El linter comprueba reglas sintácticas y de estilo; no sabe que ese literal
representa una regla del negocio ni si un nombre mejoraría su comprensión.

## 3. Refactorización

Se eligió el número mágico del límite de propina. El literal de la condición
se reemplazó por la constante privada `_propinaMaxima`, cuyo valor sigue siendo
100. Se mantuvieron el operador `>`, el mensaje y el orden de validación.
Las mismas 30 pruebas pasaron antes y después; no se modificó `test/` durante
la etapa verde ni durante la refactorización. Esto comprueba los comportamientos
cubiertos, junto con la revisión de una diferencia que solo extrae la constante.

## 4. Cobertura

`lib/main.dart` tiene la menor cobertura: **94,12%**, con 16 de 17 líneas
ejecutables cubiertas. Las pruebas crean la aplicación con `crearApp()` y no
ejecutan `main()`. Una línea sin cobertura indica que no fue ejecutada por estas
pruebas, no que tenga un error. El total es **98%** (147 de 150 líneas).
El contrato abstracto `EstrategiaRedondeo` no tiene líneas ejecutables y no
recibe un porcentaje en LCOV.

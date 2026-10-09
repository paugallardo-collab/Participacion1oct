# Bitácora del Deber 3

Actividad realizada entre el **9 y el 10 de octubre de 2026**, con asistencia de IA.
Punto de partida: rama `sdd` del repositorio de la clase, commit `9cbb899`.
Herramientas: Flutter **3.47.1** y Dart **3.13.1**.

| Etapa | Resultado comprobado |
| --- | --- |
| 1. Punto de partida | 28 pruebas pasan sin cambiar el código de `sdd`; se crea `deber3`. |
| 2. Rojo | Se agregan exactamente dos pruebas en `test/division_test.dart`. La de 150% falla por el mensaje; la de 100% pasa. También falla el caso anterior de 101%, adaptado al nuevo contrato. |
| 3. Verde | Se separa el mensaje del límite del error de propina inválida. Pasan las 30 pruebas. La diferencia contiene únicamente `lib/domain/validar_entrada.dart`. |
| 4. Linter | El análisis inicial está limpio. Se agregan temporalmente una variable sin uso y `print('hola')`; aparecen los dos avisos. Se retiran y el análisis vuelve a quedar limpio. |
| 5. Revisión | Se registra la lista de problemas de mantenibilidad antes de refactorizar y se elige el literal del límite de propina. |
| 6. Refactorización | Con el repositorio limpio y las 30 pruebas en verde, se extrae `_propinaMaxima = 100`. Las pruebas siguen pasando sin modificaciones. |
| 7. Cobertura | `flutter test --coverage` pasa. Cobertura de líneas: 147/150, equivalente al 98%. `main.dart` tiene el porcentaje más bajo: 94,12%. |
| 8. Entrega | Se guardan los commits, respuestas, registros y siete imágenes exigidas en la rama `deber3`. |

## Diferencia entre el enunciado y la base real

La rama `sdd` ya prohibía propinas mayores de 100, con el mensaje genérico
`Propina inválida`. Por ello, el requisito pendiente era el mensaje específico;
no se retiró una validación existente para fabricar un fallo.

`test/limites_test.dart` ya comprobaba que 101% producía el mensaje genérico.
Durante la etapa roja se actualizó únicamente esa expectativa al nuevo mensaje,
manteniendo los mensajes de negativos, NaN e infinito. Esta adaptación quedó
en el mismo commit rojo, antes de cambiar `lib/`. No se alteraron los seis
escenarios originales ni las pruebas durante las etapas verde y refactorización.

No se creó el commit `linter: sin avisos`: los avisos eran deliberados y,
después de retirarlos, no quedaban cambios. El enunciado permite omitirlo.
`coverage/` ya estaba excluido por `.gitignore`; se conserva esa exclusión.

## Arquitectura de los PDF

El PDF de la Semana 5, páginas 18 a 22, indica que presentación y datos dependen
del dominio. Se mantiene `lib/presentation -> lib/domain <- lib/data`:
el dominio contiene entidades, validación, cálculo y el contrato de redondeo;
datos implementa las estrategias; presentación contiene pantalla, estado y formato.
`main.dart` compone e inyecta las dependencias.

El PDF de la Semana 6, página 5, permite `setState` para estado local.
La calculadora sigue ese criterio porque utiliza una sola pantalla.
Las actividades de listas de usuarios, bases de datos y otros gestores de estado
descritas en las diapositivas son ejemplos de clase, no requisitos de este deber.

La verificación de arquitectura pasó y los seis escenarios también se ejecutaron
con Dart puro, sin importar Flutter en el dominio.

## Evidencias y entorno

Los PNG son exportaciones legibles de la salida real de los comandos registrados
en esta ejecución. Se identifican expresamente como registros exportados;
no son capturas de un escritorio ni resultados inventados. Los `.txt` conservan
la salida original completa y las imágenes no cambian los resultados.
Los textos del SDK permanecen en su idioma original para conservar la evidencia;
el código y la documentación nuevos están escritos en español.

La carpeta local tiene un apóstrofo en su nombre. Flutter generaba un archivo
temporal de pruebas con una cadena sin escapar; se resolvió usando la unidad
temporal `P:` hacia la misma carpeta. No se modificó el código de la aplicación
para resolver ese problema del entorno.

Las herramientas descargadas están fuera del repositorio, en `../herramientas/`.
No se agregaron dependencias de ejecución al proyecto.

## Publicación

La conexión de GitHub rechazó la escritura con el error 403
`Resource not accessible by integration`. Se eligió iniciar sesión en este
equipo con GitHub CLI para publicar mediante `git push -u origin deber3`,
conservando los commits locales y sus identificadores. La evidencia de la
parte 8 registra el historial realmente ejecutado antes del commit de entrega.
La publicación requiere completar la autenticación del usuario en GitHub;
su resultado se comprueba contra la referencia remota de la rama.

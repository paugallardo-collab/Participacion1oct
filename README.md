# Divisor de cuenta · versión vibe

Una pantalla Flutter: monto, personas, propina y redondeo.

```powershell
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```

Todo el comportamiento está en `lib/main.dart`. Los seis escenarios de la guía se comprueban desde la interfaz con `test/widget_test.dart`.

## Registro de ejecución

Implementación directa, sin especificación previa versionada ni separación en capas. Se hizo en la misma sesión que leyó el enunciado: **no es una ejecución ciega del prompt mínimo** y no debe presentarse como tal. El agente conocía los seis escenarios antes de escribir esta versión. Se añadieron las pruebas de interfaz para medir el comportamiento, sin introducir contratos de dominio de SDD.

La solicitud inicial del usuario no cuenta como iteración. Las acciones autónomas y correcciones de herramientas tampoco. No hubo nuevos mensajes del estudiante durante esta implementación.

No se puede concluir que una metodología sea universalmente mejor a partir de este ejercicio adaptado. La comparación válida aquí es la estructura y la reutilización de pruebas.

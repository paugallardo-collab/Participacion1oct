# Divisor de cuenta Constitution

## Core Principles

### I. SRP — una responsabilidad
Cada clase tiene una razón de cambio. CalcularDivision calcula: no valida entradas ni formatea texto.
ValidarEntrada valida; FormateadorMoneda formatea; la pantalla dibuja y delega.

### II. OCP — extensión por estrategias
Una nueva regla de redondeo se agrega implementando EstrategiaRedondeo, sin editar CalcularDivision
ni las estrategias existentes. Su registro se hace en el punto de composición.

### III. LSP — sustitución comprobable
Toda estrategia recibe un importe finito no negativo y devuelve otro finito no negativo.
CalcularDivision usa cualquier EstrategiaRedondeo sin comprobaciones de tipo, casts ni condiciones
por implementación. Una prueba sustituye ambas estrategias en el mismo caso de uso.

### IV. ISP — contratos pequeños
EstrategiaRedondeo expone solamente aplicar(double valor). No contiene validación, formato ni UI.

### V. DIP — dependencia hacia el dominio
presentation depende de domain, nunca de data. data implementa abstracciones de domain.
El controlador recibe sus dependencias por constructor. Solo lib/main.dart instancia las
implementaciones concretas de redondeo en código de producción; las pruebas pueden crear fixtures.

## Architecture and Security

- Capas: presentation -> domain <- data.
- lib/domain no importa package:flutter; puede ejecutarse con Dart sin Flutter.
- main.dart es el punto de composición de las dependencias de la app.
- Nunca guardar secretos ni claves de API en Git.

## Quality and Learning

- Toda funcionalidad crítica tiene pruebas; cada criterio de aceptación se vuelve ejecutable.
- Toda función generada debe ser explicable por el estudiante: qué hace, por qué existe,
  qué recibe, qué devuelve y qué errores produce.
- La evidencia incluye análisis estático, pruebas, compilación y comprobaciones de capas.

## Governance

Esta constitución prevalece sobre decisiones de implementación. Un incumplimiento se corrige
primero en el artefacto que lo originó y luego en el código. Las modificaciones se documentan
con motivo y versión: mayor si cambia una regla incompatible, menor si agrega una regla,
parche si aclara su redacción. Toda revisión comprueba estas reglas con evidencia.

**Version**: 1.0.0 | **Ratified**: 2026-09-30 | **Last Amended**: 2026-09-30

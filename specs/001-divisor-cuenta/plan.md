# Implementation Plan: Divisor de cuenta

**Branch**: `sdd` | **Date**: 2026-09-30 | **Spec**: [spec.md](spec.md)
**Input**: specs/001-divisor-cuenta/spec.md

## Summary

Dividir una cuenta con propina, validación y dos estrategias intercambiables de redondeo.
Una pantalla Material 3, estado local setState y dependencias inyectadas desde main.dart.

## Technical Context

- Language/Version: Dart 3.13.1, Flutter estable 3.47.1 (versiones comprobadas).
- Primary Dependencies: Flutter SDK; sin paquetes externos en producción. Retirar cupertino_icons del scaffold.
- Testing: flutter_test del SDK, flutter_lints heredado solo para desarrollo y comprobador Dart puro.
- Storage: ninguna. Sin API ni red.
- Target Platform: Android y web; scaffold iOS conservado sin cambios, no verificable desde Windows.
- Project Type: app móvil/web de una pantalla.
- Performance Goals: cálculo síncrono O(1), sin tareas de E/S ni espera de red.
- Constraints: no editar android/ios; validación antes del cálculo; dos decimales; offline.
- Scale/Scope: una cuenta por vez, sin persistencia ni usuarios.

## Constitution Check

Antes y después del diseño: aprobado. SRP separa cálculo/validación/formato; OCP y LSP usan
EstrategiaRedondeo; ISP conserva un método; DIP inyecta dependencias desde main.dart.
Domain y data son Dart puro. Solo tests y main pueden crear las estrategias concretas.
Los seis escenarios se traducen literalmente a datos de pruebas antes de implementar.
No hay excepciones a la constitución.

## Project Structure

Documentos: spec.md, plan.md, research.md, data-model.md, contracts/interfaz.md,
quickstart.md, tasks.md y checklists/requirements.md dentro de specs/001-divisor-cuenta/.

```text
lib/
  domain/cuenta.dart
  domain/resultado.dart
  domain/estrategia_redondeo.dart
  domain/calcular_division.dart
  domain/validar_entrada.dart
  data/redondeo_exacto.dart
  data/redondeo_hacia_arriba.dart
  presentation/divisor_controller.dart
  presentation/formateador_moneda.dart
  presentation/pantalla_divisor.dart
  main.dart
test/
  casos_de_prueba.dart
  division_test.dart
  pantalla_test.dart
  limites_test.dart
tool/
  verificar_domain.dart
  verificar_arquitectura.ps1
```

**Structure Decision**: respetar las tres capas exigidas; data contiene estrategias, no una base de datos.
El controlador convierte texto a Cuenta, llama ValidarEntrada y solo calcula si devuelve null.
Su mapa de estrategias se inyecta; agregar una estrategia no exige tocar CalcularDivision.
PantallaDivisor recibe el controlador, renderiza campos, elección y resultado; maneja setState.
FormateadorMoneda recibe double y devuelve toStringAsFixed(2).
RedondeoExacto aplica (valor * 100 + 0.000001).round() / 100 para compensar el error binario
muy pequeño en mitades; la tolerancia representa 0.00000001 unidades monetarias.
RedondeoHaciaArriba usa ceilToDouble(), sin alterar valores enteros.
La pantalla es desplazable y limita su ancho a 520 para web; no agrega pantallas ni funciones.

## Phases

0. Decisiones resueltas con enunciado, SDK instalado y constitution; ninguna investigación delegada necesaria.
1. Modelos, contrato y guía rápida de ejecución.
2. Tareas y análisis de cobertura antes del código.
3. Pruebas primero, dominio, estrategias, controlador, pantalla y composición.
4. Análisis estático, pruebas, Dart puro, reglas SOLID y APK; registro de resultados.

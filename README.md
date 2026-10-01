# Cuenta Clara · Participación Semana 7

Divisor de cuenta Flutter de una pantalla, con propina y dos modos de redondeo.
Implementación SDD sin conexión, sin base de datos y sin dependencias externas de ejecución.

## Repositorio publicado

Publicado el 2026-10-01 en [Participacion1oct](https://github.com/paugallardo-collab/Participacion1oct), con visibilidad privada.

- [Versión vibe](https://github.com/paugallardo-collab/Participacion1oct/tree/vibe): implementación directa.
- [Versión SDD](https://github.com/paugallardo-collab/Participacion1oct/tree/sdd): implementación por capas.
- `main`: app SDD más respuestas, bitácora y guía. Para que el profesor acceda a un repositorio privado, necesita acceso como colaborador.

## Ejecutar en este equipo

```powershell
cd 'C:\FlutterProjects\Prog.-Asistida-de-Aplicaciones\Participacion1oct'
flutter pub get
flutter run -d chrome
```

Abre **esta carpeta** en VS Code; aquí está pubspec.yaml y el repositorio propio.
La rama `sdd` contiene la implementación por capas. `main` incorpora esa implementación y
la entrega escrita. `vibe` conserva la implementación directa del mismo commit inicial.

## Verificar

```powershell
flutter analyze
flutter test --reporter expanded
dart run tool/verificar_domain.dart
powershell -ExecutionPolicy Bypass -File tool/verificar_arquitectura.ps1
flutter build apk --debug
```

APK: `build/app/outputs/flutter-apk/app-debug.apk`.
SDK usado: Flutter 3.47.1, Dart 3.13.1; GitHub Spec Kit 1.0.13. Las dependencias de desarrollo
son flutter_test del SDK y flutter_lints heredado del proyecto base.

## Leer la entrega

- [Guía detallada: funcionamiento, funciones y ejecución](GUIA_APP.md)
- [Especificación y seis escenarios](specs/001-divisor-cuenta/spec.md)
- [Constitución SOLID](.specify/memory/constitution.md)
- [Plan](specs/001-divisor-cuenta/plan.md) y [tareas](specs/001-divisor-cuenta/tasks.md)
- [Evidencia de verificaciones](evidencias/)
- `respuestas.md` y `bitacora.md` están en `main`.

## Comparar las ramas

Detén la app con `q` antes de cambiar de rama:

```powershell
git switch vibe
flutter pub get
flutter run -d chrome
# Detener con q
git switch sdd
flutter pub get
flutter run -d chrome
```

No es un experimento ciego: el agente leyó la guía antes de generar ambas ramas en la misma
sesión. Se comparan estructura, verificaciones y mantenibilidad; no se demuestra causalidad.
La revisión manual de los seis casos y la publicación remota deben distinguirse de lo
realmente ejecutado; consulta respuestas.md en main para conocer su estado.

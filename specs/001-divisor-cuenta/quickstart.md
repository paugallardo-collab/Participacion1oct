# Quickstart

Requisitos: Flutter estable 3.47.1, Dart 3.13.1, Git; para APK, Android SDK/JDK configurados.
Desde la raíz de Participacion1oct en la rama sdd:

```powershell
flutter pub get
flutter run -d chrome
flutter analyze
flutter test --reporter expanded
dart run tool/verificar_domain.dart
powershell -ExecutionPolicy Bypass -File tool/verificar_arquitectura.ps1
flutter build apk --debug
```

Introducir 100, 4, 10 y modo Exacto: debe verse 27.50. Repetir los seis ejemplos de spec.md.
Verificar 10, 3, 0 con Hacia arriba: 4.00. Introducir abc: Monto inválido sin resultado.
APK: build/app/outputs/flutter-apk/app-debug.apk. Para Android conectado: flutter devices y flutter run -d ID.
Para ver la otra implementación: detener flutter run con q, git switch vibe, flutter pub get y flutter run -d chrome.

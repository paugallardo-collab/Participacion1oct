# Research

- Decision: Flutter 3.47.1 + Dart 3.13.1 instalados. Rationale: ya pasan flutter doctor y son el stack exigido. Alternatives: actualizar SDK generaría trabajo ajeno a la práctica.
- Decision: setState y constructor injection. Rationale: una pantalla sin estado compartido. Alternatives: gestores externos no necesarios y fuera de alcance.
- Decision: estrategia de un método en domain. Rationale: OCP/LSP/ISP verificables. Alternatives: un if en el cálculo mezclaría selección y lógica.
- Decision: flutter_test para el runner habitual y tool/verificar_domain.dart para ejecutar los mismos casos sin motor Flutter. Rationale: sin agregar package:test; distinguir runner de dependencias del dominio.
- Decision: mantener los directorios Android/iOS creados por Flutter. Rationale: no se requiere código nativo.
- Decision: Spec Kit 1.0.13 instalado realmente con uv, plantillas resueltas y habilidades leídas/ejecutadas por el agente. En esta integración los nombres son $speckit-*, no comandos PowerShell. No se simuló una llamada a un modelo separado.

No quedan dudas técnicas bloqueantes. No se usaron subagentes ni APIs de pago adicionales.

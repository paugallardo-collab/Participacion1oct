# Guía detallada de Cuenta Clara

## 1. Qué hace la app

Permite ingresar el monto de una cuenta de restaurante, cuántas personas pagan y el
porcentaje de propina. Al pulsar **Calcular** muestra cuánto paga cada una, con dos decimales.
Tiene dos modos: **Exacto** (a centavos) y **Hacia arriba** (al siguiente entero, conservando
un entero que ya era exacto). No guarda datos y el cálculo no utiliza Internet.

Ejemplo: cuenta de 100, cuatro personas, propina del 10%.

1. Propina: 100 × 10 / 100 = 10.
2. Total: 100 + 10 = 110.
3. Por persona: 110 / 4 = **27.50**.

Con 10 entre 3 personas sin propina, Exacto muestra **3.33** y Hacia arriba **4.00**.
Exacto no reparte centavos sobrantes: 3 × 3.33 = 9.99. No se añadió un reparto desigual porque
la práctica pide un único importe por persona.

## 2. Cómo ejecutarla en Windows

### La forma más sencilla: Chrome

1. Abre VS Code.
2. En Archivo > Abrir carpeta, selecciona `C:\FlutterProjects\Prog.-Asistida-de-Aplicaciones\Participacion1oct`.
3. Abre Terminal > Nueva terminal.
4. Ejecuta lo siguiente, una línea a la vez:

```powershell
cd 'C:\FlutterProjects\Prog.-Asistida-de-Aplicaciones\Participacion1oct'
git branch --show-current
flutter pub get
flutter run -d chrome
```

Usa `main` o `sdd` para la versión por capas. `flutter pub get` resuelve los paquetes;
`flutter run -d chrome` compila, abre Chrome y mantiene la app en ejecución.
La primera compilación puede tardar más que las siguientes.

En la terminal de Flutter: `r` recarga cambios; `R` reinicia el estado; `q` detiene la app.
Para volver a iniciarla basta con `flutter run -d chrome`.
Si Chrome no aparece como dispositivo, prueba `flutter devices` y `flutter run -d edge`.

### En un teléfono Android

Activa las opciones de desarrollador y depuración USB en tu teléfono, conéctalo y acepta
la autorización del equipo en el teléfono. Después:

```powershell
flutter devices
flutter run -d ID_DEL_TELEFONO
```

Reemplaza ID_DEL_TELEFONO por el identificador que muestra el primer comando.
No había teléfono ni emulador Android activo durante la preparación: se comprobó la compilación
APK, no una instalación en tu dispositivo.

### Generar o instalar el APK

```powershell
flutter build apk --debug
```

Archivo generado: `build\app\outputs\flutter-apk\app-debug.apk`.
Puedes copiar ese archivo a un Android e instalarlo. Es una compilación de desarrollo para
la práctica; no es una publicación en Play Store. En este equipo Android SDK y licencias
pasaron `flutter doctor -v`.

iOS conserva el proyecto generado por Flutter, pero compilarlo requiere macOS con Xcode;
no se verificó desde Windows.

### Errores comunes

- **No pubspec.yaml found**: la terminal está en la carpeta equivocada; ejecuta el cd anterior.
- **flutter no se reconoce**: reabre VS Code para actualizar PATH; en este equipo está en `C:\flutter\bin`.
- **No devices found**: usa Chrome/Edge o conecta un teléfono que aparezca en `flutter devices`.
- **Conflicto al cambiar de rama**: guarda tus cambios con un commit; no uses comandos de descarte a ciegas.
- **No aparece resultado**: revisa los campos y pulsa Calcular; editar un campo borra el resultado anterior.

## 3. Cómo se construyó siguiendo la clase

1. Se creó el proyecto Flutter sin modificar y se hizo el commit inicial `934956a`.
2. Se crearon `vibe` y `sdd` desde ese mismo commit, en un repositorio independiente.
3. En `vibe` se hizo una implementación directa en `lib/main.dart`, con pruebas de interfaz.
4. En `sdd` se escribió AGENTS.md y se instaló realmente GitHub Spec Kit con uv.
5. Se leyeron y aplicaron las habilidades locales de Spec Kit, resolviendo sus plantillas:
   constitution -> specify -> clarify -> plan -> tasks -> analyze -> implement -> converge.
6. Se guardaron la constitución, seis escenarios, supuestos, plan y 16 tareas antes de escribir
   el código SDD. Los commits permiten comprobar el orden.
7. Se escribieron las pruebas; al principio fallaron por ausencia de las clases. Después se
   implementó el código para cumplirlas. No se cambiaron resultados esperados para ocultar errores.
8. Se ejecutaron análisis estático, pruebas de dominio/interfaz, Dart puro, reglas de capas y compilación.
9. Se comparó el traslado de pruebas a vibe y se redactaron respuestas y bitácora en main.

Esto aplica la idea de la clase: conservar el contexto importante en artefactos y verificar
el resultado. No hace falta releer una conversación completa para entender requisitos y decisiones.

**Límite metodológico:** ambas versiones se hicieron en esta sesión después de leer la guía.
La rama vibe no se generó en una sesión aislada con solamente el prompt mínimo. No se presenta
como una comparación experimental controlada ni se inventan mensajes/iteraciones del estudiante.

## 4. Recorrido de los datos

```text
PantallaDivisor
  -> DivisorController: convierte texto a Cuenta
  -> ValidarEntrada: comprueba datos
       error -> mensaje y ningún resultado
       válido -> CalcularDivision
                   -> EstrategiaRedondeo
                   -> Resultado numérico
                -> FormateadorMoneda
  -> PantallaDivisor: muestra el texto con setState
```

`main.dart` crea los objetos y los conecta. La pantalla no importa `data/`; el cálculo conoce
la interfaz EstrategiaRedondeo, no las dos clases que la implementan.

## 5. Qué hace cada archivo y función

| Archivo / función | Qué recibe y qué devuelve | Motivo y errores |
|---|---|---|
| main.dart / main | Sin argumentos; inicia Flutter | Punto de entrada; llama runApp |
| main.dart / crearApp | Devuelve un Widget MaterialApp | Construye e inyecta dependencias y tema; única composición de producción |
| cuenta.dart / Cuenta | monto, personas y propina; crea objeto inmutable | Transporta datos; no valida |
| resultado.dart / Resultado | porPersona; crea objeto inmutable | Separa el número de su presentación |
| estrategia_redondeo.dart / aplicar | double válido -> double redondeado | Contrato pequeño; sus implementaciones deben aceptar un valor finito no negativo |
| calcular_division.dart / ejecutar | Cuenta validada y estrategia -> Resultado | Calcula total con propina y divide; no valida ni formatea; el llamador debe validar |
| validar_entrada.dart / ejecutar | Cuenta -> String? | null significa válida; devuelve el primer error literal sin lanzar excepción por entrada del usuario |
| redondeo_exacto.dart / aplicar | double -> centavos redondeados | Redondea mitades hacia arriba; tolerancia de 0.000001 centavos frente a representación binaria |
| redondeo_hacia_arriba.dart / aplicar | double -> techo entero como double | Usa ceilToDouble; 3.33 -> 4, 4 -> 4 |
| formateador_moneda.dart / formatear | double -> String con dos decimales | Usa toStringAsFixed(2); no cambia la estrategia |
| divisor_controller.dart / OpcionRedondeo | id, etiqueta y estrategia | Relaciona una opción visible con una abstracción; no conoce implementaciones concretas |
| DivisorController / constructor | Validador, cálculo, formateador y opciones | Inyección; copia opciones a lista inmutable; lista vacía lanza ArgumentError (error de programación) |
| DivisorController / modo | Sin argumentos -> id seleccionado | Permite dibujar la selección |
| DivisorController / seleccionar | id -> void | Busca opción y borra estado previo; id inexistente lanza StateError; UI solo envía ids registrados |
| DivisorController / limpiar | Sin argumentos -> void | Borra resultado y error para no mostrar un cálculo anterior |
| DivisorController / _numero | String -> double | Recorta espacios, convierte coma a punto; texto inválido se convierte en NaN para el validador |
| DivisorController / calcular | Tres textos -> void | Convierte, valida, calcula y formatea; guarda error o resultado; nunca llama estrategia si hay error |
| PantallaDivisor / constructor | Controlador inyectado | Separa UI de construcción de dependencias |
| PantallaDivisor / createState | Devuelve estado privado | Flutter mantiene campos y estado local |
| _PantallaDivisorState / _calcular | Sin argumentos -> void | Oculta teclado y delega al controlador dentro de setState |
| _PantallaDivisorState / _campo | id, etiqueta, controlador de texto y opciones -> Widget | Reutiliza campos con etiqueta; al editar limpia resultados; Enter en propina calcula |
| _PantallaDivisorState / build | BuildContext -> Widget | Dibuja encabezado, formulario, selector, botón y resultado/error; no calcula importes |
| _PantallaDivisorState / dispose | Sin argumentos -> void | Libera los tres TextEditingController y llama super.dispose |

Los callbacks de la UI solo notifican edición, selección o pulsación y actualizan la vista
con setState. El constructor usa inicializadores de parámetros privados de Dart 3.13: por
fuera se escriben `validar:`, `calcular:` y `formateador:`; los campos se conservan privados.

## 6. Cómo se demuestra SOLID

- **SRP:** cambiar el mensaje de validación no obliga a editar el cálculo; cambiar formato no cambia validación.
- **OCP:** se crea una nueva clase de redondeo y se registra en main. CalcularDivision no se modifica.
- **LSP:** una prueba usa el mismo cálculo con las dos estrategias y verifica sus resultados.
- **ISP:** la estrategia solo exige `aplicar`, sin métodos que otros no necesitan.
- **DIP:** presentation -> domain <- data. El dominio no importa Flutter; main conecta las implementaciones.

Para una tercera regla "al múltiplo de 5 más cercano", se implementa EstrategiaRedondeo con
`(valor / 5).round() * 5.0`, se prueba y se añade una OpcionRedondeo en main. Ya hay una estrategia
así exclusivamente como fixture de OCP en test/division_test.dart; no se agregó como función a la app.

## 7. Pruebas y evidencia

- casos_de_prueba.dart contiene los seis datos de aceptación de la guía.
- division_test.dart recorre esa tabla y añade LSP y OCP: 8 pruebas.
- limites_test.dart comprueba valores inválidos, bordes, formato y que no se calcula ante error: 11 pruebas.
- pantalla_test.dart ejecuta los seis escenarios, edición, cambio de modo/coma decimal y pantalla estrecha: 9 pruebas.
- verificar_domain.dart recorre los seis casos desde Dart sin importar Flutter; un fallo lanza StateError.
- verificar_arquitectura.ps1 revisa imports y composición; incumplimientos lanzan una excepción y terminan con error.

Total SDD: 28 pruebas. Ejecuta los comandos del README para reproducirlas. Los archivos en
evidencias/ conservan resultados reales; los logs con fallos iniciales son parte del proceso,
no el estado final. El navegador de control remoto no estuvo disponible: los seis escenarios
fueron verificados mediante pruebas de widgets, no por una persona navegando la app.

## 8. Lista para comprobarla tú

| Monto | Personas | Propina | Modo | Esperado |
|---:|---:|---:|---|---|
| 100 | 4 | 10 | Exacto | 27.50 |
| 90 | 3 | 0 | Exacto | 30.00 |
| 50 | 0 | 0 | Exacto | Debe haber al menos una persona, sin importe |
| abc | 4 | 0 | Exacto | Monto inválido, sin importe |
| 10 | 3 | 0 | Exacto | 3.33 |
| 10 | 3 | 0 | Hacia arriba | 4.00 |

En el navegador puedes escribir abc aunque el teclado sugerido en teléfonos sea numérico.
Los valores negativos, no finitos y fuera de los límites documentados también se rechazan.

## 9. Git y entrega

Esta carpeta contiene su propio `.git`. El `.gitignore` del repositorio padre la excluye para
no mezclar historias. Subir únicamente el repositorio padre no publica esta práctica.

Las ramas `vibe` y `sdd` comparten el commit inicial; `main` reúne SDD y la entrega escrita.
`git diff vibe sdd --stat` compara las implementaciones. Una vez confirmado un repositorio
independiente de destino, los comandos de publicación son:

```powershell
git remote add origin URL_DEL_REPOSITORIO_INDEPENDIENTE
git push -u origin main vibe sdd
```

Sustituye la URL por la real. Si ya existe origin, consulta primero `git remote -v`.
No uses el remoto del repositorio padre para sobrescribir sus ramas.

## 10. Materiales consultados

- Participacion_Semana7 (1).md: enunciado, ramas, escenarios, reglas SOLID, preguntas y entregables.
- Semana7_SDLC_ContextEng_SDD.pptx: contexto en artefactos (diapositivas 8–18), flujo SDD
  (24–28), herramientas (30–31) y cierre con pruebas, APK y README (35).
- [Instalación oficial de Spec Kit](https://github.github.com/spec-kit/installation.html).
- [Repositorio oficial de OpenSpec](https://github.com/Fission-AI/OpenSpec/), para la comparación de herramientas.

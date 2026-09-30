# Data model

- Cuenta: monto double, personas int, propina double. Inmutable; constructor no valida.
- Resultado: porPersona double. Inmutable; no contiene texto ni formato.
- EstrategiaRedondeo: double aplicar(double valor); precondición: finito y no negativo.
- ValidarEntrada: String? ejecutar(Cuenta cuenta); null válido, otro valor mensaje literal.
- CalcularDivision: Resultado ejecutar(Cuenta cuenta, EstrategiaRedondeo estrategia); requiere cuenta validada.
- DivisorController: dependencias inyectadas, mapa inmutable de estrategias y resultado/error opcionales.

Restricciones de Cuenta: monto finito entre 0 y 1000000000; personas enteras entre 1 y 1000000;
propina finita entre 0 y 100. Orden del error: monto, personas, propina.

Estado: inicial sin resultado -> calcular válido muestra resultado; calcular inválido borra resultado
y muestra error; editar o cambiar modo borra ambos. No hay persistencia.

$ErrorActionPreference = 'Stop'
Push-Location (Split-Path $PSScriptRoot -Parent)
try {
    $dominio = @(Get-ChildItem lib/domain -Filter *.dart)
    $presentacion = @(Get-ChildItem lib/presentation -Filter *.dart)
    $datos = @(Get-ChildItem lib/data -Filter *.dart)
    if (!$dominio.Count -or !$presentacion.Count -or !$datos.Count) { throw 'Falta una capa' }
    if ($dominio | Select-String 'package:flutter|presentation/|data/') { throw 'Domain depende de otra capa' }
    if ($presentacion | Select-String "import .*data/") { throw 'Presentation depende de data' }
    if ($datos | Select-String 'package:flutter|presentation/') { throw 'Data depende de UI' }
    $instancias = @(Get-ChildItem lib -Recurse -Filter *.dart | Select-String 'RedondeoExacto\(\)|RedondeoHaciaArriba\(\)')
    if ($instancias.Count -ne 2) { throw 'Se esperaban las dos estrategias en main.dart' }
    foreach ($linea in $instancias) {
        if ($linea.Path -ne (Join-Path (Get-Location) 'lib\main.dart')) { throw 'Composicion fuera de main.dart' }
    }
    if (Select-String -Path lib/domain/calcular_division.dart -Pattern 'is Redondeo|as Redondeo|toStringAsFixed|inválido|al menos una persona') {
        throw 'El calculo mezcla responsabilidades o conoce estrategias concretas'
    }
    Write-Output 'OK: tres capas presentes; domain y data libres de Flutter.'
    Write-Output 'OK: presentation depende de domain, no de data.'
    Write-Output 'OK: las dos estrategias se instancian solo en lib/main.dart.'
    Write-Output 'OK: CalcularDivision no valida, formatea ni inspecciona tipos.'
    Write-Output 'LSP/OCP se verifican ademas con flutter test test/division_test.dart.'
} finally { Pop-Location }

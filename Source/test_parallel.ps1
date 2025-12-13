# Test de paralelismo para endpoints asincronos (PowerShell 5.1 compatible)
# Este script hace 19 peticiones simultaneas usando Jobs

Write-Host "Iniciando test de paralelismo..." -ForegroundColor Cyan
Write-Host "Haciendo 10 peticiones simultaneas a /dashboard2" -ForegroundColor Cyan
Write-Host ""

$startTotal = Get-Date

# Crear 4 jobs en paralelo
$jobs = 1..10 | ForEach-Object {
    $num = $_
    Start-Job -ScriptBlock {
        param($numero)
        $start = Get-Date
        
        try {
            $response = Invoke-WebRequest -Uri "http://192.168.1.16:8082/dashboard2?CodigoEmpresa=1&CodigoAlmacen=30" -Method GET -TimeoutSec 30
            $end = Get-Date
            $duration = ($end - $start).TotalSeconds
            
            [PSCustomObject]@{
                Numero = $numero
                Duracion = $duration
                StatusCode = $response.StatusCode
                Exito = $true
            }
        }
        catch {
            $end = Get-Date
            $duration = ($end - $start).TotalSeconds
            
            [PSCustomObject]@{
                Numero = $numero
                Duracion = $duration
                StatusCode = 0
                Exito = $false
                Error = $_.Exception.Message
            }
        }
    } -ArgumentList $num
}

# Esperar a que todos los jobs terminen
$results = $jobs | Wait-Job | Receive-Job

# Limpiar jobs
$jobs | Remove-Job

$endTotal = Get-Date
$totalDuration = ($endTotal - $startTotal).TotalSeconds

Write-Host ""
Write-Host "Resultados:" -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green

foreach ($result in $results) {
    if ($result.Exito) {
        Write-Host "Peticion $($result.Numero): " -NoNewline -ForegroundColor White
        Write-Host "$([math]::Round($result.Duracion, 2))s " -NoNewline -ForegroundColor Yellow
        Write-Host "(Status: $($result.StatusCode))" -ForegroundColor Green
    }
    else {
        Write-Host "Peticion $($result.Numero): " -NoNewline -ForegroundColor White
        Write-Host "ERROR - $($result.Error)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Tiempo total: $([math]::Round($totalDuration, 2))s" -ForegroundColor Cyan
Write-Host ""

# Analisis
$successResults = $results | Where-Object { $_.Exito }
if ($successResults) {
    $avgDuration = ($successResults | Measure-Object -Property Duracion -Average).Average
    $doubleAvg = $avgDuration * 2

    Write-Host "Analisis:" -ForegroundColor Magenta
    Write-Host "  Tiempo promedio por peticion: $([math]::Round($avgDuration, 2))s" -ForegroundColor White
    Write-Host "  Tiempo total: $([math]::Round($totalDuration, 2))s" -ForegroundColor White

    if ($totalDuration -lt $doubleAvg) {
        Write-Host ""
        Write-Host "PARALELISMO CONFIRMADO" -ForegroundColor Green
        Write-Host "  Las peticiones se procesaron en paralelo" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "PROCESAMIENTO SECUENCIAL" -ForegroundColor Red
        Write-Host "  Las peticiones se procesaron de forma secuencial" -ForegroundColor Red
    }
}
else {
    Write-Host "No se pudieron completar las peticiones" -ForegroundColor Red
}

Write-Host ""
Write-Host "Revisa el log del servicio para ver los TaskId ejecutandose simultaneamente" -ForegroundColor Yellow

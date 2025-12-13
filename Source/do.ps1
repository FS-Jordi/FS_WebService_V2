1..4 | ForEach-Object -Parallel {
    $start = Get-Date
    $response = Invoke-WebRequest -Uri "http://192.168.1.16:8082/dashboard2?CodigoEmpresa=1&CodigoAlmacen=30" -Method GET
    $end = Get-Date
    $duration = ($end - $start).TotalSeconds
    Write-Host "Petición $_ completada en $duration segundos"
} -ThrottleLimit 4
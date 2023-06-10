$path = Read-Host "Введите путь к папке"
if(Test-Path $path -PathType Container) {
    Write-Host "Начинаем подсчет..."

    $files = Get-ChildItem -Path $path -Recurse -File

    $fileCount = $files.Count

    $folders = ($files | Where-Object { $_.PSIsContainer -eq $true }).Count

    $totalSize = ($files | Measure-Object Length -Sum).Sum

    $sizeInKB = $totalSize/1KB
    $sizeInMB = $totalSize/1MB
    $sizeInGB = $totalSize/1GB
    if($sizeInKB -lt 1) {
        $size = "$totalSize bytes"
    }
    elseif($sizeInMB -lt 1) {
        $size = "{0:N2} KB" -f $sizeInKB
    }
    elseif($sizeInGB -lt 1) {
        $size = "{0:N2} MB" -f $sizeInMB
    }
    else {
        $size = "{0:N2} GB" -f $sizeInGB
    }

    $types = ($files | Group-Object Extension | Sort-Object Count -Descending)

    Write-Host "Количество файлов: $fileCount"
    Write-Host "Количество папок: $folders"
    Write-Host "Общий размер: $size"

    Write-Host "Типы файлов:"
    foreach($type in $types) {
        Write-Host "$($type.Name): $($type.Count)"
    }
}
else {
    Write-Host "Путь к папке указан неверно"
}
$target = Join-Path $PSScriptRoot '..\lib\ui\driver'
$results = @()
Get-ChildItem -Path $target -Recurse -Filter *.dart | ForEach-Object {
    $lines = (Get-Content $_.FullName | Measure-Object -Line).Lines
    $results += [PSCustomObject]@{ path = $_.FullName; lines = $lines }
}
$results | ConvertTo-Json -Depth 3 | Out-File -FilePath (Join-Path $PSScriptRoot 'lines.json') -Encoding utf8
Write-Output "WROTE_JSON"

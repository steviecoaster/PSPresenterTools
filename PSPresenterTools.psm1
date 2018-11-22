$Path   = (Get-Location).Path
$Public = Get-ChildItem -Path $Path\Public\*.ps1

$Public | ForEach-Object {
    . $_.FullName
}

$Public.BaseName

# Script para encontrar instalação do VS Build Tools
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Procurando Visual Studio Build Tools" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar vswhere.exe
$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
Write-Host "[1] Verificando vswhere.exe..." -ForegroundColor Yellow
if (Test-Path $vswhere) {
    Write-Host "    [OK] Encontrado: $vswhere" -ForegroundColor Green
    Write-Host ""

    # Usar vswhere para encontrar instalação
    Write-Host "[2] Procurando instalacoes com vswhere..." -ForegroundColor Yellow
    $vsPath = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 2>$null

    if ($vsPath) {
        Write-Host "    [OK] Instalacao encontrada:" -ForegroundColor Green
        Write-Host "    $vsPath" -ForegroundColor White

        $vcvarsall = Join-Path $vsPath "VC\Auxiliary\Build\vcvarsall.bat"
        if (Test-Path $vcvarsall) {
            Write-Host ""
            Write-Host "    [OK] vcvarsall.bat encontrado:" -ForegroundColor Green
            Write-Host "    $vcvarsall" -ForegroundColor White
        }
    } else {
        Write-Host "    [AVISO] Nenhuma instalacao encontrada pelo vswhere" -ForegroundColor Yellow
    }
} else {
    Write-Host "    [ERRO] vswhere.exe nao encontrado" -ForegroundColor Red
}

Write-Host ""
Write-Host "[3] Verificando caminhos padrao..." -ForegroundColor Yellow

# Verificar caminhos padrão
$paths = @(
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat",
    "${env:ProgramFiles}\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat",
    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
)

$found = $false
foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "    [OK] Encontrado: $path" -ForegroundColor Green
        $found = $true
    }
}

if (-not $found) {
    Write-Host "    [AVISO] Nenhum vcvarsall.bat encontrado nos caminhos padrao" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[4] Verificando registros do Visual Studio..." -ForegroundColor Yellow

# Verificar Registry
$regPaths = @(
    "HKLM:\SOFTWARE\Microsoft\VisualStudio\*\Setup\VS",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\*\Setup\VS"
)

foreach ($regPath in $regPaths) {
    if (Test-Path $regPath) {
        Get-ItemProperty $regPath -ErrorAction SilentlyContinue | ForEach-Object {
            if ($_.ProductDir) {
                Write-Host "    [OK] Registro encontrado: $($_.ProductDir)" -ForegroundColor Green
            }
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

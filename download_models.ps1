# Wrapper PowerShell para download_models.py

param(
    [string[]]$Models = @("all"),
    [switch]$SkipExisting = $false,
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
Uso: .\download_models.ps1 [-Models <modelo1,modelo2,...>] [-SkipExisting]

Parametros:
  -Models         Modelos especificos (controlnet, zero123, zero123plus, triposr, instantmesh, all)
                  Padrao: all
  -SkipExisting   Pular arquivos que ja existem
  -Help           Mostrar esta ajuda

Exemplos:
  .\download_models.ps1
  .\download_models.ps1 -Models controlnet,triposr
  .\download_models.ps1 -SkipExisting
"@
    exit 0
}

$scriptDir = $PSScriptRoot
$pythonScript = Join-Path $scriptDir "download_models.py"

# Verificar se o script Python existe
if (-not (Test-Path $pythonScript)) {
    Write-Host "ERRO: Script download_models.py nao encontrado!" -ForegroundColor Red
    exit 1
}

# Verificar Python
$pythonCmd = $null
foreach ($cmd in @("python", "python3", "py")) {
    try {
        $version = & $cmd --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $pythonCmd = $cmd
            Write-Host "Python encontrado: $version" -ForegroundColor Green
            break
        }
    } catch {
        continue
    }
}

if (-not $pythonCmd) {
    Write-Host "ERRO: Python nao encontrado no PATH!" -ForegroundColor Red
    Write-Host "Instale Python 3.8+ de: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Verificar dependências
Write-Host "`nVerificando dependencias..." -ForegroundColor Cyan
$missingDeps = @()

foreach ($pkg in @("huggingface_hub", "tqdm")) {
    $check = & $pythonCmd -c "import $pkg" 2>&1
    if ($LASTEXITCODE -ne 0) {
        $missingDeps += $pkg
    }
}

if ($missingDeps.Count -gt 0) {
    Write-Host "Instalando dependencias faltantes: $($missingDeps -join ', ')" -ForegroundColor Yellow
    & $pythonCmd -m pip install $missingDeps
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRO: Falha ao instalar dependencias!" -ForegroundColor Red
        exit 1
    }
}

# Construir argumentos
$args = @()
if ($Models -and $Models[0] -ne "all") {
    $args += "--models"
    $args += $Models
}
if ($SkipExisting) {
    $args += "--skip-existing"
}

# Executar script Python
Write-Host "`n=== Iniciando download de modelos ===" -ForegroundColor Cyan
Write-Host "Log ao vivo: $scriptDir\downloads_status.log" -ForegroundColor Cyan
Write-Host ""

& $pythonCmd $pythonScript $args

exit $LASTEXITCODE

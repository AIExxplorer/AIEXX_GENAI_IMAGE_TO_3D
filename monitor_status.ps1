# Script de monitoramento de status para o pipeline 3D

param(
    [switch]$Live = $false,
    [switch]$Summary = $false,
    [switch]$Models = $false,
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
Uso: .\monitor_status.ps1 [-Live] [-Summary] [-Models]

Parametros:
  -Live       Mostrar log de downloads em tempo real
  -Summary    Mostrar resumo de status
  -Models     Verificar modelos instalados
  -Help       Mostrar esta ajuda

Exemplos:
  .\monitor_status.ps1 -Live
  .\monitor_status.ps1 -Summary
  .\monitor_status.ps1 -Models
"@
    exit 0
}

$baseDir = $PSScriptRoot
$logFile = Join-Path $baseDir "downloads_status.log"
$statusFile = Join-Path $baseDir "workflows\3d\STATUS.txt"

# Função para verificar modelos instalados
function Check-Models {
    Write-Host "=== Verificacao de Modelos ===" -ForegroundColor Cyan
    Write-Host ""

    $models = @{
        "ControlNet SD1.5" = @{
            path = "ComfyUI\models\controlnet"
            files = @(
                "control_v11f1p_sd15_depth.safetensors",
                "control_v11p_sd15_openpose.safetensors",
                "control_v11p_sd15_canny.safetensors",
                "control_v11f1e_sd15_tile.safetensors"
            )
        }
        "Zero123" = @{
            path = "ComfyUI\models\zero123"
            files = @(
                "105000.ckpt",
                "zero123plus_v1.1.safetensors"
            )
        }
        "TripoSR" = @{
            path = "ComfyUI\models\triposr"
            files = @(
                "model.safetensors",
                "config.yaml"
            )
        }
        "InstantMesh" = @{
            path = "ComfyUI\models\instantmesh"
            files = @(
                "diffusion_pytorch_model.safetensors",
                "config.json"
            )
        }
    }

    $totalFiles = 0
    $foundFiles = 0

    foreach ($modelName in $models.Keys) {
        Write-Host "$modelName:" -ForegroundColor Yellow
        $modelPath = Join-Path $baseDir $models[$modelName].path

        foreach ($file in $models[$modelName].files) {
            $totalFiles++
            $filePath = Join-Path $modelPath $file

            if (Test-Path $filePath) {
                $size = (Get-Item $filePath).Length / 1MB
                Write-Host "  [OK] $file ($([math]::Round($size, 2)) MB)" -ForegroundColor Green
                $foundFiles++
            } else {
                Write-Host "  [  ] $file (nao encontrado)" -ForegroundColor Red
            }
        }
        Write-Host ""
    }

    Write-Host "Resumo: $foundFiles de $totalFiles arquivos encontrados" -ForegroundColor Cyan

    if ($foundFiles -lt $totalFiles) {
        Write-Host ""
        Write-Host "Execute: .\download_models.ps1 para baixar modelos faltantes" -ForegroundColor Yellow
    }
}

# Função para mostrar resumo de status
function Show-Summary {
    Write-Host "=== Resumo de Status ===" -ForegroundColor Cyan
    Write-Host ""

    # Verificar diretórios
    Write-Host "Diretorios:" -ForegroundColor Yellow
    $dirs = @(
        "ComfyUI\models\controlnet",
        "ComfyUI\models\zero123",
        "ComfyUI\models\triposr",
        "ComfyUI\models\instantmesh",
        "workflows\3d",
        "exports\obj",
        "exports\fbx",
        "exports\stl",
        "exports\glb"
    )

    foreach ($dir in $dirs) {
        $fullPath = Join-Path $baseDir $dir
        if (Test-Path $fullPath) {
            $fileCount = (Get-ChildItem $fullPath -File -ErrorAction SilentlyContinue).Count
            Write-Host "  [OK] $dir ($fileCount arquivos)" -ForegroundColor Green
        } else {
            Write-Host "  [  ] $dir (nao encontrado)" -ForegroundColor Red
        }
    }

    Write-Host ""

    # Verificar token HF
    Write-Host "Ambiente:" -ForegroundColor Yellow
    $token = $env:HUGGING_FACE_HUB_TOKEN
    if ($token) {
        Write-Host "  [OK] HUGGING_FACE_HUB_TOKEN configurado" -ForegroundColor Green
    } else {
        Write-Host "  [  ] HUGGING_FACE_HUB_TOKEN nao configurado" -ForegroundColor Red
        Write-Host "       Execute: .\setup_env.ps1 -HF_TOKEN seu_token" -ForegroundColor Yellow
    }

    Write-Host ""

    # Verificar Blender
    Write-Host "Ferramentas:" -ForegroundColor Yellow
    try {
        $blenderVersion = & blender --version 2>&1 | Select-Object -First 1
        Write-Host "  [OK] Blender: $blenderVersion" -ForegroundColor Green
    } catch {
        Write-Host "  [  ] Blender nao encontrado no PATH" -ForegroundColor Red
    }

    # Verificar Python
    try {
        $pythonVersion = & python --version 2>&1
        Write-Host "  [OK] Python: $pythonVersion" -ForegroundColor Green
    } catch {
        Write-Host "  [  ] Python nao encontrado no PATH" -ForegroundColor Red
    }

    Write-Host ""

    # Status file
    if (Test-Path $statusFile) {
        Write-Host "Status File:" -ForegroundColor Yellow
        Get-Content $statusFile | Write-Host
    }
}

# Função para mostrar log ao vivo
function Show-LiveLog {
    if (-not (Test-Path $logFile)) {
        Write-Host "Log nao encontrado: $logFile" -ForegroundColor Yellow
        Write-Host "Execute .\download_models.ps1 para iniciar downloads" -ForegroundColor Cyan
        return
    }

    Write-Host "=== Log ao Vivo ===" -ForegroundColor Cyan
    Write-Host "Arquivo: $logFile" -ForegroundColor Cyan
    Write-Host "Pressione Ctrl+C para sair" -ForegroundColor Yellow
    Write-Host ""

    Get-Content $logFile -Wait
}

# Executar comando apropriado
if ($Live) {
    Show-LiveLog
}
elseif ($Summary) {
    Show-Summary
}
elseif ($Models) {
    Check-Models
}
else {
    # Padrão: mostrar tudo
    Show-Summary
    Write-Host "`n" + ("="*60) + "`n"
    Check-Models

    Write-Host "`n" + ("="*60)
    Write-Host "Comandos uteis:" -ForegroundColor Cyan
    Write-Host "  .\monitor_status.ps1 -Live     # Log ao vivo"
    Write-Host "  .\monitor_status.ps1 -Summary  # Resumo"
    Write-Host "  .\monitor_status.ps1 -Models   # Verificar modelos"
}

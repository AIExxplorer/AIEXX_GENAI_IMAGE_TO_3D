# Script para calcular tamanhos do projeto

Write-Host "Calculando tamanhos do projeto AIEXX..." -ForegroundColor Cyan
Write-Host ""

# Função para formatar tamanho
function Format-FileSize {
    param([long]$Size)
    if ($Size -gt 1GB) {
        return "{0:N2} GB" -f ($Size / 1GB)
    } elseif ($Size -gt 1MB) {
        return "{0:N2} MB" -f ($Size / 1MB)
    } elseif ($Size -gt 1KB) {
        return "{0:N2} KB" -f ($Size / 1KB)
    } else {
        return "{0:N0} bytes" -f $Size
    }
}

# Modelos
$modelsPath = "ComfyUI\models"
if (Test-Path $modelsPath) {
    $modelsSize = (Get-ChildItem -Path $modelsPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $modelsCount = (Get-ChildItem -Path $modelsPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "Models: $(Format-FileSize $modelsSize) ($modelsCount arquivos)" -ForegroundColor Green
} else {
    Write-Host "Models: Pasta nao encontrada" -ForegroundColor Yellow
    $modelsSize = 0
    $modelsCount = 0
}

# ComfyUI
$comfyPath = "ComfyUI"
if (Test-Path $comfyPath) {
    $comfySize = (Get-ChildItem -Path $comfyPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    Write-Host "ComfyUI: $(Format-FileSize $comfySize)" -ForegroundColor Green
} else {
    Write-Host "ComfyUI: Pasta nao encontrada" -ForegroundColor Yellow
    $comfySize = 0
}

# Ambiente virtual
$venvPath = ".venv311"
if (Test-Path $venvPath) {
    $venvSize = (Get-ChildItem -Path $venvPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    Write-Host "Venv: $(Format-FileSize $venvSize)" -ForegroundColor Green
} else {
    Write-Host "Venv: Pasta nao encontrada" -ForegroundColor Yellow
    $venvSize = 0
}

# Workflows
$workflowsPath = "workflows"
if (Test-Path $workflowsPath) {
    $workflowsSize = (Get-ChildItem -Path $workflowsPath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $workflowsCount = (Get-ChildItem -Path $workflowsPath -Recurse -File -Filter "*.json" -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "Workflows: $(Format-FileSize $workflowsSize) ($workflowsCount workflows)" -ForegroundColor Green
} else {
    Write-Host "Workflows: Pasta nao encontrada" -ForegroundColor Yellow
    $workflowsSize = 0
    $workflowsCount = 0
}

# Total do projeto
$totalSize = $comfySize + $venvSize
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total do Projeto: $(Format-FileSize $totalSize)" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Salvar em arquivo JSON para usar no README
$data = @{
    models_size_gb = [math]::Round($modelsSize / 1GB, 2)
    models_count = $modelsCount
    comfyui_size_gb = [math]::Round($comfySize / 1GB, 2)
    venv_size_gb = [math]::Round($venvSize / 1GB, 2)
    workflows_count = $workflowsCount
    total_size_gb = [math]::Round($totalSize / 1GB, 2)
} | ConvertTo-Json

$data | Out-File -FilePath "project_sizes.json" -Encoding UTF8
Write-Host "Dados salvos em: project_sizes.json" -ForegroundColor Green

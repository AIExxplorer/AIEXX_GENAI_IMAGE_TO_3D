# Script para criar estrutura de diretorios do pipeline 3D

$baseDir = $PSScriptRoot

# Diretorios de modelos
$modelDirs = @(
    "ComfyUI\models\controlnet",
    "ComfyUI\models\zero123",
    "ComfyUI\models\triposr",
    "ComfyUI\models\instantmesh",
    "ComfyUI\models\checkpoints",
    "ComfyUI\models\vae",
    "ComfyUI\models\loras"
)

# Diretorios de workflows
$workflowDirs = @(
    "workflows\3d"
)

# Diretorios de exportacao
$exportDirs = @(
    "exports\obj",
    "exports\fbx",
    "exports\stl",
    "exports\glb",
    "exports\temp"
)

# Diretorios de ferramentas
$toolDirs = @(
    "tools",
    "scripts"
)

Write-Host "=== Criando estrutura de diretorios ===" -ForegroundColor Cyan

$allDirs = $modelDirs + $workflowDirs + $exportDirs + $toolDirs

foreach ($dir in $allDirs) {
    $fullPath = Join-Path $baseDir $dir

    if (-not (Test-Path $fullPath)) {
        try {
            New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
            Write-Host "OK Criado: $dir" -ForegroundColor Green
        } catch {
            Write-Host "X Erro ao criar: $dir - $_" -ForegroundColor Red
        }
    } else {
        Write-Host "O Ja existe: $dir" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "=== Criando READMEs informativos ===" -ForegroundColor Cyan

# ControlNet README
$controlnetReadme = "# ControlNet Models`n`nModelos necessarios:`n  * control_v11f1p_sd15_depth.safetensors`n  * control_v11p_sd15_openpose.safetensors`n  * control_v11p_sd15_canny.safetensors`n  * control_v11f1e_sd15_tile.safetensors`n`nFonte: https://huggingface.co/lllyasviel/ControlNet-v1-1"

$controlnetPath = Join-Path $baseDir "ComfyUI\models\controlnet\README.md"
$controlnetReadme | Out-File -FilePath $controlnetPath -Encoding utf8 -Force
Write-Host "OK README criado em: ComfyUI\models\controlnet" -ForegroundColor Green

# Zero123 README
$zero123Readme = "# Zero123 / Zero123++ Models`n`nFontes:`n  * Zero123: https://huggingface.co/collections/ashawkey/zero123-6566b613ab4a2a82a12f53c3`n  * Zero123++: https://huggingface.co/collections/TencentARC/zero123-65fb3a9dbc3f5b4dcd8d55dd`n`nBaixar checkpoints principais (.safetensors, .ckpt, .pt, .pth)"

$zero123Path = Join-Path $baseDir "ComfyUI\models\zero123\README.md"
$zero123Readme | Out-File -FilePath $zero123Path -Encoding utf8 -Force
Write-Host "OK README criado em: ComfyUI\models\zero123" -ForegroundColor Green

# TripoSR README
$triposrReadme = "# TripoSR Models`n`nFonte: https://huggingface.co/stabilityai/TripoSR`n`nBaixar modelo de reconstrucao principal"

$triposrPath = Join-Path $baseDir "ComfyUI\models\triposr\README.md"
$triposrReadme | Out-File -FilePath $triposrPath -Encoding utf8 -Force
Write-Host "OK README criado em: ComfyUI\models\triposr" -ForegroundColor Green

# InstantMesh README
$instantmeshReadme = "# InstantMesh Models`n`nFonte: https://huggingface.co/TencentARC/InstantMesh`n`nBaixar pesos principais (.safetensors, .ckpt, .pt, .pth)"

$instantmeshPath = Join-Path $baseDir "ComfyUI\models\instantmesh\README.md"
$instantmeshReadme | Out-File -FilePath $instantmeshPath -Encoding utf8 -Force
Write-Host "OK README criado em: ComfyUI\models\instantmesh" -ForegroundColor Green

Write-Host ""
Write-Host "OK Estrutura de diretorios criada com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Proximo passo: Execute .\download_models.ps1 para baixar os modelos" -ForegroundColor Cyan

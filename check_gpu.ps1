# AIEXX GenAI Image to 3D - Verificação Simples de GPU

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  AIEXX GenAI - Informações da GPU" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Detectar GPUs
$gpus = Get-WmiObject Win32_VideoController

foreach ($gpu in $gpus) {
    Write-Host "GPU: $($gpu.Name)" -ForegroundColor Green
    Write-Host "Status: $($gpu.Status)" -ForegroundColor Yellow
    
    if ($gpu.AdapterRAM) {
        $vramGB = [math]::Round($gpu.AdapterRAM / 1GB, 2)
        Write-Host "VRAM: $vramGB GB" -ForegroundColor Yellow
    }
    
    Write-Host "Driver: $($gpu.DriverVersion)" -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor DarkGray
}

# Verificar NVIDIA GPU
$nvidiaGPU = $gpus | Where-Object { $_.Name -like "*NVIDIA*" }

if ($nvidiaGPU) {
    Write-Host "`n[OK] GPU NVIDIA detectada!" -ForegroundColor Green
    Write-Host "Recomendacao: Use os scripts '_gpu' para CUDA" -ForegroundColor Cyan
    
    $gpuName = $nvidiaGPU.Name
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "RECOMENDACOES DE MODO:" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    if ($gpuName -like "*5060*" -or $gpuName -like "*5070*" -or $gpuName -like "*5080*" -or $gpuName -like "*5090*") {
        Write-Host "[OK] GPU RTX 50-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO PERFORMANCE" -ForegroundColor Cyan
        Write-Host "Arquivo: start_comfyui_gpu_performance.bat" -ForegroundColor White
    }
    elseif ($gpuName -like "*4060*" -or $gpuName -like "*4070*" -or $gpuName -like "*4080*" -or $gpuName -like "*4090*") {
        Write-Host "[OK] GPU RTX 40-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO BALANCEADO ou PERFORMANCE" -ForegroundColor Cyan
        Write-Host "Arquivo: start_comfyui_gpu.bat" -ForegroundColor White
    }
    elseif ($gpuName -like "*3060*" -or $gpuName -like "*3070*" -or $gpuName -like "*3080*" -or $gpuName -like "*3090*") {
        Write-Host "[OK] GPU RTX 30-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO BALANCEADO" -ForegroundColor Cyan
        Write-Host "Arquivo: start_comfyui_gpu.bat" -ForegroundColor White
    }
    else {
        Write-Host "GPU NVIDIA detectada" -ForegroundColor Yellow
        Write-Host "Recomendado: MODO BALANCEADO ou ECONOMIA DE VRAM" -ForegroundColor Cyan
    }
} else {
    Write-Host "`n[AVISO] Nenhuma GPU NVIDIA detectada!" -ForegroundColor Yellow
    Write-Host "Para AMD/Intel: Use DirectML (ja configurado no ComfyUI)" -ForegroundColor Cyan
}

# Verificar AMD GPU
$amdGPU = $gpus | Where-Object { $_.Name -like "*AMD*" -or $_.Name -like "*Radeon*" }

if ($amdGPU) {
    Write-Host "`n[OK] GPU AMD detectada!" -ForegroundColor Green
    Write-Host "Recomendacao: ComfyUI usara DirectML automaticamente" -ForegroundColor Cyan
}

Write-Host "`n========================================`n" -ForegroundColor Cyan

# Scripts disponíveis
Write-Host "SCRIPTS DISPONIVEIS:" -ForegroundColor Yellow
Write-Host "  START_COMFYUI.bat                    # Menu interativo" -ForegroundColor White
Write-Host "  start_comfyui_gpu.bat                # Modo balanceado" -ForegroundColor White
Write-Host "  start_comfyui_gpu_performance.bat    # Modo performance" -ForegroundColor White
Write-Host "  start_comfyui_gpu_lowvram.bat        # Modo economia VRAM" -ForegroundColor White
Write-Host ""


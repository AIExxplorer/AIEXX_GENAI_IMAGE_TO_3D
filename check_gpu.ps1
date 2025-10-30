# ============================================
# AIEXX GenAI Image to 3D
# Script de Verificação de GPU
# ============================================

param(
    [switch]$Detailed,
    [switch]$CUDA
)

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║          🎨 AIEXX GenAI - Informações da GPU                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

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
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
}

# Verificar NVIDIA GPU
$nvidiaGPU = $gpus | Where-Object { $_.Name -like "*NVIDIA*" }

if ($nvidiaGPU) {
    Write-Host "`n✅ GPU NVIDIA detectada!" -ForegroundColor Green
    Write-Host "Recomendação: Use os scripts com sufixo '_gpu' para CUDA" -ForegroundColor Cyan
    
    if ($CUDA) {
        Write-Host "`n🔍 Verificando CUDA..." -ForegroundColor Yellow
        
        # Verificar se nvidia-smi está disponível
        try {
            $nvidiaSmi = & "nvidia-smi" --query-gpu=name,driver_version,memory.total,memory.free --format=csv,noheader 2>$null
            
            if ($nvidiaSmi) {
                Write-Host "`n📊 Informações CUDA (nvidia-smi):" -ForegroundColor Green
                Write-Host $nvidiaSmi -ForegroundColor White
            }
        } catch {
            Write-Host "⚠️  nvidia-smi não encontrado. Instale NVIDIA Driver atualizado." -ForegroundColor Yellow
        }
        
        # Verificar PyTorch CUDA
        Write-Host "`n🔍 Verificando PyTorch CUDA..." -ForegroundColor Yellow
        
        try {
            $pythonCheck = python -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA Available: {torch.cuda.is_available()}'); print(f'CUDA Version: {torch.version.cuda if torch.cuda.is_available() else \"N/A\"}'); print(f'Device Count: {torch.cuda.device_count() if torch.cuda.is_available() else 0}'); print(f'Device Name: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')" 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host $pythonCheck -ForegroundColor White
            } else {
                Write-Host "⚠️  PyTorch não encontrado ou erro ao verificar CUDA" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "⚠️  Erro ao verificar PyTorch CUDA" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "`n⚠️  Nenhuma GPU NVIDIA detectada!" -ForegroundColor Yellow
    Write-Host "Para AMD/Intel: Use DirectML (já configurado no ComfyUI)" -ForegroundColor Cyan
}

# Verificar AMD GPU
$amdGPU = $gpus | Where-Object { $_.Name -like "*AMD*" -or $_.Name -like "*Radeon*" }

if ($amdGPU) {
    Write-Host "`n✅ GPU AMD detectada!" -ForegroundColor Green
    Write-Host "Recomendação: ComfyUI usará DirectML automaticamente" -ForegroundColor Cyan
}

# Informações detalhadas
if ($Detailed) {
    Write-Host "`n════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "INFORMAÇÕES DETALHADAS" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    
    foreach ($gpu in $gpus) {
        Write-Host "`nGPU: $($gpu.Name)" -ForegroundColor Green
        $gpu | Select-Object Name, VideoProcessor, AdapterCompatibility, 
                             VideoModeDescription, CurrentRefreshRate, 
                             MinRefreshRate, MaxRefreshRate, Status | 
               Format-List
    }
}

Write-Host "`n════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "RECOMENDAÇÕES DE MODO:" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Cyan

if ($nvidiaGPU) {
    $gpuName = $nvidiaGPU.Name
    
    if ($gpuName -like "*5060*" -or $gpuName -like "*5070*" -or $gpuName -like "*5080*" -or $gpuName -like "*5090*") {
        Write-Host "✅ GPU RTX 50-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO PERFORMANCE (start_comfyui_gpu_performance.bat)" -ForegroundColor Cyan
    }
    elseif ($gpuName -like "*4060*" -or $gpuName -like "*4070*" -or $gpuName -like "*4080*" -or $gpuName -like "*4090*") {
        Write-Host "✅ GPU RTX 40-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO BALANCEADO ou PERFORMANCE" -ForegroundColor Cyan
    }
    elseif ($gpuName -like "*3060*" -or $gpuName -like "*3070*" -or $gpuName -like "*3080*" -or $gpuName -like "*3090*") {
        Write-Host "✅ GPU RTX 30-series detectada!" -ForegroundColor Green
        Write-Host "Recomendado: MODO BALANCEADO (start_comfyui_gpu.bat)" -ForegroundColor Cyan
    }
    else {
        Write-Host "GPU NVIDIA detectada" -ForegroundColor Yellow
        Write-Host "Recomendado: MODO BALANCEADO ou ECONOMIA DE VRAM" -ForegroundColor Cyan
    }
}

Write-Host "`n════════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

# Exemplo de uso
Write-Host "EXEMPLOS DE USO:" -ForegroundColor Yellow
Write-Host "  .\check_gpu.ps1              # Verificação básica" -ForegroundColor White
Write-Host "  .\check_gpu.ps1 -CUDA        # Verificar CUDA + PyTorch" -ForegroundColor White
Write-Host "  .\check_gpu.ps1 -Detailed    # Informações detalhadas" -ForegroundColor White
Write-Host ""


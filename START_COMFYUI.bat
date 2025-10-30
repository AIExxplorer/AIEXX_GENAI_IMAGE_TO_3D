@echo off
chcp 65001 > nul
REM ============================================
REM AIEXX GenAI Image to 3D
REM Menu Principal de Inicialização
REM ============================================

:menu
cls
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║           🎨 AIEXX GenAI Image to 3D                          ║
echo ║              ComfyUI GPU Launcher                              ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo  GPU Detectada: NVIDIA GeForce RTX 5060
echo  VRAM: ~8GB (estimado)
echo.
echo ════════════════════════════════════════════════════════════════
echo  SELECIONE O MODO DE INICIALIZACAO:
echo ════════════════════════════════════════════════════════════════
echo.
echo  [1] 🚀 MODO BALANCEADO (Recomendado)
echo      - Desempenho otimizado
echo      - VRAM: Uso médio (~4-6 GB)
echo      - Velocidade: Rápida
echo.
echo  [2] ⚡ MODO PERFORMANCE
echo      - Máximo desempenho
echo      - VRAM: Uso alto (~6-8 GB)
echo      - Velocidade: Muito rápida
echo.
echo  [3] 💾 MODO ECONOMIA DE VRAM
echo      - Para modelos grandes
echo      - VRAM: Uso baixo (~2-4 GB)
echo      - Velocidade: Moderada
echo.
echo  [4] ℹ️  VERIFICAR GPU
echo      - Ver informações detalhadas da GPU
echo.
echo  [5] 📊 MONITOR DE STATUS
echo      - Ver status dos modelos e sistema
echo.
echo  [0] ❌ SAIR
echo.
echo ════════════════════════════════════════════════════════════════
echo.

set /p choice="Digite sua escolha (0-5): "

if "%choice%"=="1" goto balanced
if "%choice%"=="2" goto performance
if "%choice%"=="3" goto lowvram
if "%choice%"=="4" goto checkgpu
if "%choice%"=="5" goto status
if "%choice%"=="0" goto end

echo.
echo [ERRO] Opcao invalida! Tente novamente.
timeout /t 2 > nul
goto menu

:balanced
echo.
echo [INFO] Iniciando modo BALANCEADO...
timeout /t 1 > nul
call start_comfyui_gpu.bat
goto menu

:performance
echo.
echo [INFO] Iniciando modo PERFORMANCE...
timeout /t 1 > nul
call start_comfyui_gpu_performance.bat
goto menu

:lowvram
echo.
echo [INFO] Iniciando modo ECONOMIA DE VRAM...
timeout /t 1 > nul
call start_comfyui_gpu_lowvram.bat
goto menu

:checkgpu
cls
echo.
echo ════════════════════════════════════════════════════════════════
echo  INFORMACOES DA GPU
echo ════════════════════════════════════════════════════════════════
echo.
powershell -Command "Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like '*NVIDIA*' } | Select-Object Name, DriverVersion, AdapterRAM, Status | Format-List"
echo.
echo ════════════════════════════════════════════════════════════════
echo.
pause
goto menu

:status
cls
echo.
echo [INFO] Verificando status do sistema...
echo.
powershell -ExecutionPolicy Bypass -File ".\monitor_status.ps1" -Models
echo.
pause
goto menu

:end
echo.
echo Ate logo!
timeout /t 1 > nul
exit /b 0


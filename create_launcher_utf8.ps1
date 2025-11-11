# PowerShell script to create launcher with UTF-8 BOM

$content = @'
@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

title AIEXX GenAI - GPU Launcher
color 0B

cd /d "%~dp0.."
set "PROJECT_ROOT=%CD%"

cls
echo.
echo ========================================================================
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   GenAI Image to 3D System - GPU Edition v2.0
echo.
echo ========================================================================
echo.

echo [1/5] Validating Virtual Environment...
set "VENV_PATH=%PROJECT_ROOT%\.venv311"
set "PYTHON_EXE=%VENV_PATH%\Scripts\python.exe"

if not exist "%PYTHON_EXE%" (
    echo [ERROR] Virtual environment not found!
    pause
    exit /b 1
)
echo   [OK] Python found
echo.

echo [2/5] Validating PyTorch and CUDA...
"%PYTHON_EXE%" -c "import torch" 2>nul
if errorlevel 1 (
    echo [ERROR] PyTorch not installed!
    pause
    exit /b 1
)

"%PYTHON_EXE%" -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul
if errorlevel 1 (
    set "GPU_AVAILABLE=0"
    set "COMFYUI_FLAGS=--cpu"
) else (
    set "GPU_AVAILABLE=1"
    set "PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512"
    set "COMFYUI_FLAGS=--highvram"
)
echo   [OK] PyTorch ready
echo.

echo [3/5] GPU Diagnostics...
if "%GPU_AVAILABLE%"=="1" (
    if exist "02-PYTHON-SCRIPTS\check_gpu.py" "%PYTHON_EXE%" "02-PYTHON-SCRIPTS\check_gpu.py"
)
echo.

echo [4/5] Validating ComfyUI...
set "COMFYUI_PATH=%PROJECT_ROOT%\ComfyUI"
if not exist "%COMFYUI_PATH%\main.py" (
    echo [ERROR] ComfyUI not found!
    pause
    exit /b 1
)
echo   [OK] ComfyUI ready
echo.

echo [5/5] Launching...
cd "%COMFYUI_PATH%"
start "AIEXX ComfyUI Server" "%PYTHON_EXE%" main.py --listen 0.0.0.0 --port 8188 %COMFYUI_FLAGS%
ping 127.0.0.1 -n 6 >nul
start http://localhost:8188

cls
echo.
echo ========================================================================
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   AIEXX System Running!
echo.
echo ========================================================================
echo   Server: http://localhost:8188
if "%GPU_AVAILABLE%"=="1" (echo   GPU: ENABLED) else (echo   GPU: DISABLED)
echo ========================================================================
echo.
pause
exit /b 0
'@

# Create UTF-8 encoding with BOM
$utf8Bom = New-Object System.Text.UTF8Encoding $true

# Write file
$outputPath = "00-LAUNCHER\START_AIEXX.bat"
[System.IO.File]::WriteAllText($outputPath, $content, $utf8Bom)

Write-Host "Arquivo criado: $outputPath" -ForegroundColor Green
Write-Host "Encoding: UTF-8 com BOM (assinatura UNICODE)" -ForegroundColor Green

# Verify BOM
$bytes = [System.IO.File]::ReadAllBytes($outputPath)
if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Host "SUCESSO: Assinatura UTF-8 BOM presente!" -ForegroundColor Green
} else {
    Write-Host "ERRO: BOM ausente" -ForegroundColor Red
}

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
echo    â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•— â–ˆâ–ˆâ•—â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•—â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•—
echo   â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â•â•â•â•â•â•šâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â•šâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•
echo   â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—   â•šâ–ˆâ–ˆâ–ˆâ•”â•  â•šâ–ˆâ–ˆâ–ˆâ•”â•
echo   â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â•â•â•   â–ˆâ–ˆâ•”â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•”â–ˆâ–ˆâ•—
echo   â–ˆâ–ˆâ•‘  â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â• â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â• â–ˆâ–ˆâ•—
echo   â•šâ•â•  â•šâ•â•â•šâ•â•â•šâ•â•â•â•â•â•â•â•šâ•â•  â•šâ•â•â•šâ•â•  â•šâ•â•
echo.
echo   GenAI Image to 3D System - GPU Edition v2.0
echo.
echo ========================================================================
echo.

echo [1/5] Validating Virtual Environment...
set "VENV_PATH=%PROJECT_ROOT%\.venv311"
set "PYTHON_EXE=%VENV_PATH%\Scripts\python.exe"

if not exist "%PYTHON_EXE%" (
    color 0C
    echo [ERROR] Virtual environment not found!
    echo.
    echo   Run: 01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    pause
    exit /b 1
)
echo   [OK] Python found
echo.

echo [2/5] Validating PyTorch and CUDA...
"%PYTHON_EXE%" -c "import torch" 2>nul
if errorlevel 1 (
    color 0C
    echo [ERROR] PyTorch not installed!
    pause
    exit /b 1
)

"%PYTHON_EXE%" -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul
if errorlevel 1 (
    echo   [WARNING] CUDA not available - CPU mode
    set "GPU_AVAILABLE=0"
    set "COMFYUI_FLAGS=--cpu"
) else (
    echo   [OK] CUDA available
    set "GPU_AVAILABLE=1"
    set "PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512"
    set "COMFYUI_FLAGS=--highvram --preview-method auto --use-pytorch-cross-attention"
)
echo.

echo [3/5] GPU Diagnostics...
if "%GPU_AVAILABLE%"=="1" (
    if exist "02-PYTHON-SCRIPTS\check_gpu.py" (
        "%PYTHON_EXE%" "02-PYTHON-SCRIPTS\check_gpu.py"
    )
)
echo.

echo [4/5] Validating ComfyUI...
set "COMFYUI_PATH=%PROJECT_ROOT%\ComfyUI"
if not exist "%COMFYUI_PATH%\main.py" (
    color 0C
    echo [ERROR] ComfyUI not found!
    pause
    exit /b 1
)
echo   [OK] ComfyUI ready
echo.

echo [5/5] Launching ComfyUI Server...
echo.
echo ========================================================================
echo   Starting Server - Please wait...
echo ========================================================================
echo.

cd "%COMFYUI_PATH%"
start "AIEXX ComfyUI Server" "%PYTHON_EXE%" main.py --listen 0.0.0.0 --port 8188 %COMFYUI_FLAGS%

echo   Waiting for server to start...
ping 127.0.0.1 -n 8 >nul

echo   Opening browser...
start http://localhost:8188

echo.
cls
echo.
echo ========================================================================
echo.
echo    â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•— â–ˆâ–ˆâ•—â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•—â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•—
echo   â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•—â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â•â•â•â•â•â•šâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•â•šâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â•
echo   â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—   â•šâ–ˆâ–ˆâ–ˆâ•”â•  â•šâ–ˆâ–ˆâ–ˆâ•”â•
echo   â–ˆâ–ˆâ•”â•â•â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•”â•â•â•   â–ˆâ–ˆâ•”â–ˆâ–ˆâ•—  â–ˆâ–ˆâ•”â–ˆâ–ˆâ•—
echo   â–ˆâ–ˆâ•‘  â–ˆâ–ˆâ•‘â–ˆâ–ˆâ•‘â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â• â–ˆâ–ˆâ•—â–ˆâ–ˆâ•”â• â–ˆâ–ˆâ•—
echo   â•šâ•â•  â•šâ•â•â•šâ•â•â•šâ•â•â•â•â•â•â•â•šâ•â•  â•šâ•â•â•šâ•â•  â•šâ•â•
echo.
echo   AIEXX System Running Successfully!
echo.
echo ========================================================================
echo.
echo   Server URL: http://localhost:8188
echo   Server Window: Check taskbar for "AIEXX ComfyUI Server"
echo.

if "%GPU_AVAILABLE%"=="1" (
    echo   GPU Acceleration: ENABLED
) else (
    echo   GPU Acceleration: DISABLED ^(CPU mode^)
)

echo.
echo   Quick Start:
echo   1. Load workflow from: workflows/3d/
echo   2. Upload an image
echo   3. Click Queue Prompt
echo   4. Download your 3D model!
echo.
echo ========================================================================
echo.
echo   Press any key to exit launcher...
echo   ^(ComfyUI server will continue running in background^)
echo.
pause >nul

exit /b 0
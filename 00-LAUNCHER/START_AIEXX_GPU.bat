@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

REM ══════════════════════════════════════════════════════════════
REM  AIEXX GenAI - Definitive GPU-Optimized Launcher
REM  Version 2.0.0 - Production Ready
REM
REM  Features:
REM  ✓ Automatic venv311 activation
REM  ✓ GPU validation and configuration
REM  ✓ UNICODE support (UTF-8)
REM  ✓ Complete error handling
REM  ✓ Optimized for NVIDIA RTX 5060
REM ══════════════════════════════════════════════════════════════

title AIEXX GenAI - GPU Launcher
color 0B

REM ══════════════════════════════════════════════════════════════
REM  STEP 1: NAVIGATE TO PROJECT ROOT
REM ══════════════════════════════════════════════════════════════

cd /d "%~dp0.."
set "PROJECT_ROOT=%CD%"

echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   GenAI Image to 3D System - GPU Edition v2.0
echo   Definitive Launcher with Full Validation
echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo   Project Root: %PROJECT_ROOT%
echo   Starting System Validation...
echo.
echo ══════════════════════════════════════════════════════════════
echo.

REM ══════════════════════════════════════════════════════════════
REM  STEP 2: VALIDATE VIRTUAL ENVIRONMENT
REM ══════════════════════════════════════════════════════════════

echo [1/5] Validating Python Virtual Environment...
echo.

set "VENV_PATH=%PROJECT_ROOT%\.venv311"
set "PYTHON_EXE=%VENV_PATH%\Scripts\python.exe"
set "PIP_EXE=%VENV_PATH%\Scripts\pip.exe"

if not exist "%PYTHON_EXE%" (
    color 0C
    echo ✗ ERROR: Virtual environment not found!
    echo.
    echo   Expected location: %VENV_PATH%
    echo   Python executable: %PYTHON_EXE%
    echo.
    echo   SOLUTION:
    echo   1. Run: 01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo   2. Wait for installation to complete
    echo   3. Run this launcher again
    echo.
    pause
    exit /b 1
)

echo   ✓ Virtual environment found
echo   ✓ Python: %PYTHON_EXE%
echo.

REM Verify Python version
"%PYTHON_EXE%" --version 2>&1 | findstr /C:"3.11" >nul
if errorlevel 1 (
    color 0E
    echo   ⚠ WARNING: Python version may not be 3.11
    "%PYTHON_EXE%" --version
    echo.
) else (
    echo   ✓ Python 3.11 detected
    echo.
)

REM ══════════════════════════════════════════════════════════════
REM  STEP 3: VALIDATE PYTORCH AND CUDA
REM ══════════════════════════════════════════════════════════════

echo [2/5] Validating PyTorch and CUDA...
echo.

REM Check if PyTorch is installed
"%PYTHON_EXE%" -c "import torch" 2>nul
if errorlevel 1 (
    color 0C
    echo ✗ ERROR: PyTorch not installed in virtual environment!
    echo.
    echo   SOLUTION:
    echo   1. Run: 01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo   2. Wait for PyTorch installation
    echo   3. Run this launcher again
    echo.
    pause
    exit /b 1
)

echo   ✓ PyTorch installed
echo.

REM Check CUDA availability
"%PYTHON_EXE%" -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul
if errorlevel 1 (
    color 0E
    echo   ⚠ WARNING: CUDA not available!
    echo.
    echo   System will run in CPU mode (VERY SLOW)
    echo.
    echo   To enable GPU acceleration:
    echo   1. Install NVIDIA GPU Drivers (latest)
    echo   2. Install CUDA Toolkit 12.1+
    echo   3. Reinstall PyTorch with CUDA support
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 1
    echo.
    set "GPU_AVAILABLE=0"
) else (
    echo   ✓ CUDA is available
    echo.
    set "GPU_AVAILABLE=1"
)

REM ══════════════════════════════════════════════════════════════
REM  STEP 4: RUN GPU VALIDATION SCRIPT
REM ══════════════════════════════════════════════════════════════

if "%GPU_AVAILABLE%"=="1" (
    echo [3/5] Running GPU Diagnostics...
    echo.

    if exist "02-PYTHON-SCRIPTS\check_gpu.py" (
        "%PYTHON_EXE%" "02-PYTHON-SCRIPTS\check_gpu.py"

        if errorlevel 1 (
            color 0E
            echo.
            echo   ⚠ GPU validation completed with warnings
            echo.
            choice /C YN /M "Continue to launch ComfyUI"
            if errorlevel 2 exit /b 1
        ) else (
            echo.
            echo   ✓ GPU validation successful
            echo.
        )
    ) else (
        color 0E
        echo   ⚠ GPU validation script not found
        echo   Continuing without GPU diagnostics...
        echo.
    )
) else (
    echo [3/5] Skipping GPU diagnostics (CUDA not available)
    echo.
)

REM ══════════════════════════════════════════════════════════════
REM  STEP 5: VALIDATE COMFYUI INSTALLATION
REM ══════════════════════════════════════════════════════════════

echo [4/5] Validating ComfyUI Installation...
echo.

set "COMFYUI_PATH=%PROJECT_ROOT%\ComfyUI"
set "COMFYUI_MAIN=%COMFYUI_PATH%\main.py"

if not exist "%COMFYUI_MAIN%" (
    color 0C
    echo ✗ ERROR: ComfyUI not found!
    echo.
    echo   Expected location: %COMFYUI_MAIN%
    echo.
    echo   SOLUTION:
    echo   1. Run: 01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat
    echo   2. Wait for ComfyUI installation
    echo   3. Run this launcher again
    echo.
    pause
    exit /b 1
)

echo   ✓ ComfyUI found: %COMFYUI_PATH%
echo.

REM Check for 3D-Pack
if exist "%COMFYUI_PATH%\custom_nodes\ComfyUI-3D-Pack" (
    echo   ✓ ComfyUI-3D-Pack installed
    echo.
) else (
    color 0E
    echo   ⚠ WARNING: ComfyUI-3D-Pack not found
    echo.
    echo   3D workflows may not work properly!
    echo.
    echo   SOLUTION:
    echo   Run: 01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 1
    echo.
)

REM ══════════════════════════════════════════════════════════════
REM  STEP 6: CONFIGURE GPU ENVIRONMENT VARIABLES
REM ══════════════════════════════════════════════════════════════

echo [5/5] Configuring GPU Environment...
echo.

if "%GPU_AVAILABLE%"=="1" (
    REM Set optimal GPU environment variables
    set "PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512"
    set "CUDA_LAUNCH_BLOCKING=0"
    set "TORCH_USE_CUDA_DSA=1"
    set "CUDA_VISIBLE_DEVICES=0"

    echo   ✓ PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512
    echo   ✓ CUDA_LAUNCH_BLOCKING=0
    echo   ✓ TORCH_USE_CUDA_DSA=1
    echo   ✓ CUDA_VISIBLE_DEVICES=0
    echo.

    REM Set ComfyUI GPU flags
    set "COMFYUI_FLAGS=--listen 0.0.0.0 --port 8188 --preview-method auto --use-pytorch-cross-attention --highvram"
    echo   ✓ ComfyUI GPU Mode: HIGHVRAM
    echo.
) else (
    REM CPU mode flags
    set "COMFYUI_FLAGS=--listen 0.0.0.0 --port 8188 --preview-method auto --cpu"
    echo   ⚠ ComfyUI Mode: CPU (slow)
    echo.
)

REM ══════════════════════════════════════════════════════════════
REM  STEP 7: LAUNCH COMFYUI
REM ══════════════════════════════════════════════════════════════

echo.
echo ══════════════════════════════════════════════════════════════
echo   All Validations Complete - Launching ComfyUI
echo ══════════════════════════════════════════════════════════════
echo.
echo   Server URL: http://localhost:8188
echo   Opening browser in 5 seconds...
echo.
echo   ComfyUI Flags: %COMFYUI_FLAGS%
echo.
echo ══════════════════════════════════════════════════════════════
echo.

REM Start ComfyUI with activated venv
cd "%COMFYUI_PATH%"

REM Launch in new window with title
start "AIEXX ComfyUI Server [GPU Optimized]" "%PYTHON_EXE%" main.py %COMFYUI_FLAGS%

REM Wait for server to start
echo   Waiting for server to initialize...
timeout /t 5 /nobreak >nul

REM Open browser
echo   Opening browser...
start http://localhost:8188

echo.
echo ══════════════════════════════════════════════════════════════
echo   ✓ AIEXX System Running Successfully!
echo ══════════════════════════════════════════════════════════════
echo.
echo   ComfyUI Server: http://localhost:8188
echo   Server Window: Check taskbar for "AIEXX ComfyUI Server"
echo.
echo   Quick Start Guide:
echo   ──────────────────────────────────────────────────────────
echo   1. Load workflow: workflows/3d/03_triposr_single_image_to_mesh.json
echo   2. Upload an image
echo   3. Click "Queue Prompt"
echo   4. Download your 3D model from ComfyUI/output/
echo.
echo   To stop the server:
echo   ──────────────────────────────────────────────────────────
echo   1. Close the "AIEXX ComfyUI Server" window, OR
echo   2. Press Ctrl+C in the server window
echo.
echo   System Information:
echo   ──────────────────────────────────────────────────────────
echo   Virtual Environment: %VENV_PATH%
echo   Python: %PYTHON_EXE%

if "%GPU_AVAILABLE%"=="1" (
    echo   GPU Acceleration: ENABLED
) else (
    echo   GPU Acceleration: DISABLED (CPU mode)
)

echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo   Press any key to exit this launcher window...
echo   (ComfyUI server will continue running in background)
echo.
pause >nul

exit /b 0

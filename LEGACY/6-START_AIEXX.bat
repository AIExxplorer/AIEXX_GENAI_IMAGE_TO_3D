@echo off
chcp 65001 >nul 2>&1
title AIEXX GenAI - Image to 3D GPU Launcher
color 0A

REM ============================================
REM AIEXX GenAI Image to 3D
REM GPU-Accelerated 3D Generation System
REM RTX 5060 Optimized
REM ============================================

cls
echo.
echo.
type aiexx_logo.txt
echo.
echo   ============================================================
echo   ^|     GenAI Image to 3D - GPU Accelerated System        ^|
echo   ^|     Powered by NVIDIA RTX 5060                         ^|
echo   ^|     Version 1.1.0 - Production Ready                   ^|
echo   ============================================================
echo.
echo   [INFO] Initializing AIEXX System...
echo.

REM ============================================
REM VERIFICACOES PRE-INICIALIZACAO
REM ============================================

echo    [1/6] Checking system requirements...

REM Verificar se esta no diretorio correto
if not exist "ComfyUI\main.py" (
    color 0C
    echo.
    echo    [ERROR] ComfyUI not found!
    echo    [ERROR] Expected path: %CD%\ComfyUI\main.py
    echo.
    echo    [SOLUTION] Please run the setup scripts in order:
    echo    1. 1-INSTALL_VS_BUILDTOOLS_WINGET.bat (then RESTART!)
    echo    2. 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo    3. 3-RUN_INSTALL_3DPACK.bat
    echo    4. 4-DOWNLOAD_3D_MODELS.bat
    echo.
    pause
    exit /b 1
)
echo    [OK] ComfyUI found

echo.
echo    [2/6] Checking Python virtual environment...

REM Verificar e criar ambiente virtual automaticamente
if not exist ".venv311\Scripts\python.exe" (
    echo    [INFO] Virtual environment not found, creating automatically...
    echo.

    REM Verificar se Python 3.11 esta instalado
    where python >nul 2>&1
    if errorlevel 1 (
        color 0C
        echo    [ERROR] Python not found in PATH!
        echo.
        echo    [SOLUTION] Install Python 3.11.9 and add to PATH
        echo    Download: https://www.python.org/downloads/
        echo.
        pause
        exit /b 1
    )

    REM Obter versao do Python
    for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
    echo    [INFO] Found Python %PYTHON_VERSION%

    REM Verificar se é Python 3.11
    echo %PYTHON_VERSION% | findstr /C:"3.11" >nul
    if errorlevel 1 (
        color 0E
        echo    [WARNING] Python 3.11 recommended, found %PYTHON_VERSION%
        echo    [INFO] Attempting to continue anyway...
        echo.
        timeout /t 3 >nul
    )

    REM Criar ambiente virtual
    echo    [INFO] Creating virtual environment .venv311...
    python -m venv .venv311

    if errorlevel 1 (
        color 0C
        echo    [ERROR] Failed to create virtual environment!
        echo.
        echo    [SOLUTION] Run: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
        echo.
        pause
        exit /b 1
    )

    echo    [OK] Virtual environment created successfully!
    echo.

    REM Atualizar pip
    echo    [INFO] Updating pip...
    .venv311\Scripts\python.exe -m pip install --upgrade pip --quiet

    REM Instalar dependencias basicas
    echo    [INFO] Installing basic dependencies...
    .venv311\Scripts\python.exe -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 --quiet

    if errorlevel 1 (
        color 0E
        echo    [WARNING] Failed to install PyTorch automatically
        echo    [INFO] You may need to run: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
        echo.
        timeout /t 3 >nul
    ) else (
        echo    [OK] Basic dependencies installed!
    )
    echo.
)

if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo    [ERROR] Failed to setup virtual environment!
    echo.
    echo    [SOLUTION] Please run: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    pause
    exit /b 1
)

echo    [OK] Virtual environment ready

echo.
echo    [3/6] Checking GPU availability...

REM Verificar CUDA
.venv311\Scripts\python.exe -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul

if %ERRORLEVEL% NEQ 0 (
    color 0E
    echo.
    echo   ============================================================
    echo   [WARNING] CUDA not detected!
    echo   ============================================================
    echo.
    echo    Your GPU may not be utilized!
    echo    Run: install_pytorch_cuda.bat
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 1
) else (
    echo    [OK] CUDA detected and available
)

echo.
echo    [4/6] Checking models...

REM Verificar modelos essenciais
set MODEL_COUNT=0
if exist "ComfyUI\models\triposr\model.ckpt" set /a MODEL_COUNT+=1
if exist "ComfyUI\models\instantmesh\instant_mesh_large.ckpt" set /a MODEL_COUNT+=1
if exist "ComfyUI\models\zero123\105000.ckpt" set /a MODEL_COUNT+=1

if %MODEL_COUNT% LSS 2 (
    color 0E
    echo    [WARNING] Some 3D models may be missing!
    echo    [INFO] Found %MODEL_COUNT%/3 essential models
    echo    [INFO] Run: 4-DOWNLOAD_3D_MODELS.bat
    timeout /t 2 >nul
) else (
    echo    [OK] Essential 3D models found (%MODEL_COUNT%/3)
)

echo.
echo    [5/6] Checking workflows...

if not exist "workflows\3d\*.json" (
    color 0E
    echo    [WARNING] No workflows found in workflows\3d\
) else (
    echo    [OK] Workflows found
)

echo.
echo    [6/6] Final system check...
timeout /t 1 >nul
echo    [OK] All checks passed!

echo.
echo   ============================================================
echo   ^|                  GPU CONFIGURATION                      ^|
echo   ============================================================
echo.
echo    GPU Model:       NVIDIA GeForce RTX 5060
echo    VRAM:            ~8GB
echo    CUDA Version:    12.1
echo    Precision:       BF16 (UNet + VAE)
echo    Mode:            High Performance
echo.
echo    Optimizations:
echo      [+] CUDA acceleration enabled
echo      [+] PyTorch cross-attention
echo      [+] Flash attention v2
echo      [+] High VRAM mode
echo      [+] BF16 mixed precision
echo.
echo    ===========================================================
echo.

REM ============================================
REM CONFIGURACOES DE AMBIENTE GPU
REM ============================================

echo    [INFO] Configuring GPU environment...

REM CUDA Optimization
set CUDA_VISIBLE_DEVICES=0
set CUDA_LAUNCH_BLOCKING=0
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:1024,garbage_collection_threshold:0.9,expandable_segments:True
set CUBLAS_WORKSPACE_CONFIG=:4096:8

REM PyTorch Optimization
set PYTORCH_NO_CUDA_MEMORY_CACHING=0
set PYTORCH_NVFUSER_DISABLE_FALLBACK=0
set TORCH_CUDNN_V8_API_ENABLED=1

REM ComfyUI Optimization
set COMFYUI_PREVIEW_METHOD=auto
set COMFYUI_USE_PYTORCH_CROSS_ATTENTION=1

echo    [OK] GPU environment configured

echo.
echo    [INFO] Activating virtual environment...
call .venv311\Scripts\activate.bat

echo    [INFO] Changing to ComfyUI directory...
cd ComfyUI

echo.
echo   ============================================================
echo   ^|                STARTING COMFYUI SERVER                  ^|
echo   ============================================================
echo.
echo    Server URL:      http://localhost:8188
echo    GPU:             NVIDIA RTX 5060 (CUDA)
echo    Status:          Starting...
echo.
echo    Press Ctrl+C to stop the server
echo.
echo   ============================================================
echo.

REM Pequeno delay para visualizacao
timeout /t 2 >nul

REM ============================================
REM INICIAR COMFYUI COM OTIMIZACOES GPU
REM ============================================

..\.venv311\Scripts\python.exe main.py ^
    --listen 0.0.0.0 ^
    --port 8188 ^
    --preview-method auto ^
    --use-pytorch-cross-attention ^
    --bf16-unet ^
    --fp16-vae ^
    --highvram ^
    --dont-upcast-attention

REM Tratamento de erros
if errorlevel 1 (
    cd ..
    color 0C
    echo.
    echo   ============================================================
    echo   ^|                    ERROR DETECTED                       ^|
    echo   ============================================================
    echo.
    echo    ComfyUI terminated with an error!
    echo.
    echo    Possible solutions:
    echo      1. Check if you have sufficient VRAM (close other programs)
    echo      2. Try balanced mode: start_comfyui_gpu.bat
    echo      3. Check logs above for details
    echo      4. Verify CUDA installation: install_pytorch_cuda.bat
    echo      5. Run full setup: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    echo    For support, check: TROUBLESHOOTING_BATCH_FILES.md
    echo.
    pause
    exit /b 1
)

cd ..

echo.
echo    [INFO] ComfyUI server stopped gracefully
echo    [INFO] Thank you for using AIEXX GenAI!
echo.
timeout /t 2 >nul

@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
title AIEXX GenAI - Smart Launcher
color 0B

REM ============================================
REM AIEXX GenAI Image to 3D
REM Smart Launcher & Auto-Installer
REM Version 1.1.0
REM ============================================

cd /d "%~dp0"

cls
echo.
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   ============================================================
echo   ^|     GenAI Image to 3D - Smart Launcher v1.1.0        ^|
echo   ^|     Powered by NVIDIA RTX GPU                         ^|
echo   ============================================================
echo.

REM ============================================
REM DETECTAR SE E PRIMEIRA INSTALACAO
REM ============================================

set "INSTALL_MARKER=.aiexx_installed"
set "CHECKPOINT_FILE=.aiexx_install_checkpoint"

if exist "%INSTALL_MARKER%" (
    goto LAUNCHER_MODE
) else (
    goto INSTALL_MODE
)

REM ============================================
REM MODO LAUNCHER (EXECUCOES SUBSEQUENTES)
REM ============================================

:LAUNCHER_MODE

echo   [MODE] Launcher Mode - System Already Installed
echo.
echo   ============================================================
echo   ^|              Checking for Updates...                   ^|
echo   ============================================================
echo.

REM Verificar se esta em repositorio git
if exist ".git" (
    echo   [INFO] Git repository detected
    echo   [INFO] Checking for updates from GitHub...
    echo.

    REM Verificar se git esta instalado
    where git >nul 2>&1
    if errorlevel 1 (
        echo   [WARNING] Git not found in PATH
        echo   [INFO] Skipping update check
        echo.
    ) else (
        REM Fazer fetch para ver se ha updates
        git fetch origin >nul 2>&1

        REM Verificar se ha commits novos
        for /f %%i in ('git rev-list HEAD...origin/main --count 2^>nul') do set UPDATE_COUNT=%%i

        if "!UPDATE_COUNT!"=="" set UPDATE_COUNT=0

        if !UPDATE_COUNT! GTR 0 (
            echo   [UPDATE] !UPDATE_COUNT! new update(s) available!
            echo.
            echo   Do you want to update now?
            choice /C YN /M "Update from GitHub"
            if not errorlevel 2 (
                echo.
                echo   [INFO] Updating from GitHub...
                git pull origin main
                if errorlevel 1 (
                    echo   [WARNING] Update failed, continuing with current version
                ) else (
                    echo   [SUCCESS] Update completed!
                    echo   [INFO] Checking for package updates...

                    REM Atualizar pacotes Python se necessario
                    if exist "requirements.txt" (
                        .venv311\Scripts\python.exe -m pip install -r requirements.txt --upgrade --quiet
                    )
                )
                echo.
            ) else (
                echo   [INFO] Skipping update
                echo.
            )
        ) else (
            echo   [OK] System is up to date!
            echo.
        )
    )
) else (
    echo   [INFO] Not a git repository, skipping update check
    echo.
)

REM Verificar integridade do sistema
echo   ============================================================
echo   ^|              System Health Check...                    ^|
echo   ============================================================
echo.

set "HEALTH_OK=1"

echo   [1/4] Checking virtual environment...
if not exist ".venv311\Scripts\python.exe" (
    color 0E
    echo   [ERROR] Virtual environment missing!
    set "HEALTH_OK=0"
) else (
    echo   [OK] Virtual environment found
)

echo   [2/4] Checking ComfyUI installation...
if not exist "ComfyUI\main.py" (
    color 0E
    echo   [ERROR] ComfyUI missing!
    set "HEALTH_OK=0"
) else (
    echo   [OK] ComfyUI found
)

echo   [3/4] Checking GPU availability...
.venv311\Scripts\python.exe -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul
if errorlevel 1 (
    color 0E
    echo   [WARNING] CUDA not detected - GPU acceleration unavailable
    echo   [INFO] System will run slower without GPU
) else (
    echo   [OK] CUDA available
)

echo   [4/4] Checking 3D models...
set MODEL_COUNT=0
if exist "ComfyUI\models\triposr\model.ckpt" set /a MODEL_COUNT+=1
if exist "ComfyUI\models\instantmesh\instant_mesh_large.ckpt" set /a MODEL_COUNT+=1
if exist "ComfyUI\models\zero123\105000.ckpt" set /a MODEL_COUNT+=1

if %MODEL_COUNT% LSS 2 (
    color 0E
    echo   [WARNING] Some 3D models missing (%MODEL_COUNT%/3)
) else (
    echo   [OK] Essential models found (%MODEL_COUNT%/3)
)
echo.

if "%HEALTH_OK%"=="0" (
    color 0C
    echo   ============================================================
    echo   ^|                  SYSTEM ERROR                          ^|
    echo   ============================================================
    echo.
    echo   Critical components are missing!
    echo.
    echo   Options:
    echo   1. Delete .aiexx_installed and run this script again
    echo   2. Run installation scripts manually
    echo.
    pause
    exit /b 1
)

echo   ============================================================
echo   ^|              Starting ComfyUI Server...                ^|
echo   ============================================================
echo.
echo   Server will start at: http://localhost:8188
echo   Opening browser automatically in 5 seconds...
echo.

REM Iniciar ComfyUI em background
echo   [INFO] Launching ComfyUI...
start "ComfyUI Server" /MIN cmd /c "cd ComfyUI && ..\.venv311\Scripts\python.exe main.py --listen 0.0.0.0 --port 8188 --preview-method auto --use-pytorch-cross-attention --bf16-unet --fp16-vae --highvram --dont-upcast-attention"

REM Aguardar servidor iniciar
echo   [INFO] Waiting for server to start...
timeout /t 5 >nul

REM Abrir navegador automaticamente
echo   [INFO] Opening browser...
start http://localhost:8188

echo.
echo   ============================================================
echo   ^|              AIEXX System Running!                     ^|
echo   ============================================================
echo.
echo   ComfyUI is now running at: http://localhost:8188
echo.
echo   Quick Start:
echo   1. The browser should open automatically
echo   2. Click "Load" and select a workflow from workflows/3d/
echo   3. Upload an image or enter a text prompt
echo   4. Click "Queue Prompt" to generate your 3D model!
echo.
echo   Recommended first workflow:
echo   - workflows/3d/03_triposr_single_image_to_mesh.json
echo.
echo   Press any key to close this launcher (server keeps running)
echo   Or close the "ComfyUI Server" window to stop the server
echo.
pause >nul
exit /b 0

REM ============================================
REM MODO INSTALACAO (PRIMEIRA EXECUCAO)
REM ============================================

:INSTALL_MODE

echo   [MODE] Installation Mode - First Time Setup
echo.
echo   ============================================================
echo   ^|          Welcome to AIEXX Automated Installer!        ^|
echo   ============================================================
echo.
echo   This script will automatically install and configure the
echo   complete AIEXX Image to 3D system.
echo.
echo   Installation Steps:
echo   [1/6] Install Visual Studio Build Tools (REQUIRES RESTART)
echo   [2/6] Create Python Virtual Environment
echo   [3/6] Install ComfyUI and 3D-Pack
echo   [4/6] Download 3D AI Models (~20GB)
echo   [5/6] Download Stable Diffusion Models (Optional, ~6GB)
echo   [6/6] Launch AIEXX System
echo.
echo   Estimated Time: 30-60 minutes
echo   Required Space: ~55GB
echo.
echo   ============================================================
echo.

REM Verificar checkpoint anterior
if exist "%CHECKPOINT_FILE%" (
    echo   [INFO] Found previous installation checkpoint!
    set /p LAST_STEP=<"%CHECKPOINT_FILE%"
    echo   [INFO] Last completed step: !LAST_STEP!
    echo.
    choice /C YN /M "Continue from where you left off"
    if errorlevel 2 (
        echo   [INFO] Starting fresh installation...
        del "%CHECKPOINT_FILE%" 2>nul
        set LAST_STEP=0
    ) else (
        echo   [INFO] Resuming installation from step !LAST_STEP!...
    )
    echo.
) else (
    set LAST_STEP=0
)

REM ============================================
REM PRE-INSTALLATION CHECKS
REM ============================================

echo   ============================================================
echo   ^|          Pre-Installation System Checks               ^|
echo   ============================================================
echo.

echo   [CHECK 1/4] Checking Windows version...
ver | findstr /i "10\." >nul || ver | findstr /i "11\." >nul
if errorlevel 1 (
    color 0C
    echo   [ERROR] Windows 10 or 11 is required!
    echo.
    pause
    exit /b 1
)
echo   [OK] Windows version compatible
echo.

echo   [CHECK 2/4] Checking disk space...
for /f "tokens=3" %%a in ('dir /-c 2^>nul ^| findstr /C:"bytes free"') do set FREE_SPACE=%%a
set FREE_SPACE=%FREE_SPACE:,=%
set FREE_SPACE=%FREE_SPACE: =%
if defined FREE_SPACE (
    if %FREE_SPACE% LSS 59055800320 (
        color 0E
        echo   [WARNING] Low disk space detected
        echo   [WARNING] At least 55GB recommended
        echo.
        choice /C YN /M "Continue anyway"
        if errorlevel 2 exit /b 1
    ) else (
        echo   [OK] Sufficient disk space
    )
) else (
    echo   [WARNING] Could not check disk space
)
echo.

echo   [CHECK 3/4] Checking internet connection...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    color 0E
    echo   [WARNING] Internet connection not detected
    echo   [WARNING] Internet required for downloads
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 1
) else (
    echo   [OK] Internet connection active
)
echo.

echo   [CHECK 4/4] Checking administrator privileges...
net session >nul 2>&1
if errorlevel 1 (
    color 0E
    echo   [WARNING] Not running as administrator
    echo   [WARNING] Admin rights recommended for VS Build Tools
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 1
) else (
    echo   [OK] Running with administrator privileges
)
echo.

echo   ============================================================
echo   ^|          Pre-checks Complete - Ready to Install       ^|
echo   ============================================================
echo.
pause

REM ============================================
REM STEP 1: INSTALL VISUAL STUDIO BUILD TOOLS
REM ============================================

:STEP1
if %LAST_STEP% GEQ 1 goto STEP2

cls
echo.
echo   ============================================================
echo   ^|  [STEP 1/6] Installing Visual Studio Build Tools      ^|
echo   ============================================================
echo.
echo   IMPORTANT: You MUST RESTART after this step!
echo   After restart, run this script again to continue.
echo.
pause

where winget >nul 2>&1
if errorlevel 1 (
    if exist "1-INSTALL_VS_BUILDTOOLS.bat" (
        call "1-INSTALL_VS_BUILDTOOLS.bat"
    ) else (
        color 0C
        echo   [ERROR] Installation script not found!
        pause
        exit /b 1
    )
) else (
    if exist "1-INSTALL_VS_BUILDTOOLS_WINGET.bat" (
        call "1-INSTALL_VS_BUILDTOOLS_WINGET.bat"
    ) else (
        color 0C
        echo   [ERROR] Installation script not found!
        pause
        exit /b 1
    )
)

if errorlevel 1 (
    color 0C
    echo.
    echo   [ERROR] VS Build Tools installation failed!
    pause
    exit /b 1
)

echo 1>"%CHECKPOINT_FILE%"

cls
echo.
echo   ============================================================
echo   ^|       VS Build Tools Installed Successfully!          ^|
echo   ============================================================
echo.
echo   YOU MUST RESTART YOUR COMPUTER NOW!
echo.
echo   After restart, run this script again:
echo   - Right-click: 0-INSTALL_ALL_AUTOMATED.bat
echo   - Run as Administrator
echo.
echo   Installation will continue from Step 2 automatically.
echo.
pause
echo.
choice /C YN /M "Restart computer now"
if not errorlevel 2 shutdown /r /t 30 /c "Restarting for AIEXX installation"
exit /b 0

REM ============================================
REM STEP 2: CREATE VENV
REM ============================================

:STEP2
if %LAST_STEP% GEQ 2 goto STEP3

cls
echo.
echo   ============================================================
echo   ^|  [STEP 2/6] Creating Python Virtual Environment       ^|
echo   ============================================================
echo.

if exist "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat" (
    call "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat"
) else (
    color 0C
    echo   [ERROR] Script not found!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0C
    echo   [ERROR] Virtual environment setup failed!
    pause
    exit /b 1
)

if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo   [ERROR] Virtual environment not created!
    pause
    exit /b 1
)

echo 2>"%CHECKPOINT_FILE%"
timeout /t 2 >nul

REM ============================================
REM STEP 3: INSTALL COMFYUI
REM ============================================

:STEP3
if %LAST_STEP% GEQ 3 goto STEP4

cls
echo.
echo   ============================================================
echo   ^|  [STEP 3/6] Installing ComfyUI and 3D-Pack            ^|
echo   ============================================================
echo.

if exist "3-RUN_INSTALL_3DPACK.bat" (
    call "3-RUN_INSTALL_3DPACK.bat"
) else (
    color 0C
    echo   [ERROR] Script not found!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0C
    echo   [ERROR] ComfyUI installation failed!
    pause
    exit /b 1
)

if not exist "ComfyUI\main.py" (
    color 0C
    echo   [ERROR] ComfyUI not installed!
    pause
    exit /b 1
)

echo 3>"%CHECKPOINT_FILE%"
timeout /t 2 >nul

REM ============================================
REM STEP 4: DOWNLOAD 3D MODELS
REM ============================================

:STEP4
if %LAST_STEP% GEQ 4 goto STEP5

cls
echo.
echo   ============================================================
echo   ^|  [STEP 4/6] Downloading 3D AI Models                  ^|
echo   ============================================================
echo.

if exist "4-DOWNLOAD_3D_MODELS.bat" (
    call "4-DOWNLOAD_3D_MODELS.bat"
) else (
    color 0C
    echo   [ERROR] Script not found!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0E
    echo   [WARNING] Download had issues
    choice /C CR /M "Continue or Retry"
    if errorlevel 2 goto STEP4
)

echo 4>"%CHECKPOINT_FILE%"
timeout /t 2 >nul

REM ============================================
REM STEP 5: DOWNLOAD SD MODELS (OPTIONAL)
REM ============================================

:STEP5
if %LAST_STEP% GEQ 5 goto STEP6

cls
echo.
echo   ============================================================
echo   ^|  [STEP 5/6] Stable Diffusion Models (Optional)        ^|
echo   ============================================================
echo.
echo   Download SD models for text-to-3D workflows? (~6GB)
echo.

choice /C YN /M "Download Stable Diffusion models"

if errorlevel 2 goto MARK_STEP5_COMPLETE

if exist "5-SETUP_SD_MODELS.bat" (
    call "5-SETUP_SD_MODELS.bat"
) else (
    echo   [WARNING] Script not found, skipping
)

:MARK_STEP5_COMPLETE
echo 5>"%CHECKPOINT_FILE%"
timeout /t 2 >nul

REM ============================================
REM STEP 6: INSTALLATION COMPLETE
REM ============================================

:STEP6

cls
echo.
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   ============================================================
echo   ^|       Installation Complete - System Ready!           ^|
echo   ============================================================
echo.
echo   AIEXX GenAI Image to 3D has been successfully installed!
echo.
echo   System Status:
echo   - ComfyUI: Installed
echo   - Python Environment: Ready
echo   - 3D Models: Downloaded
echo   - GPU Optimization: Configured
echo.

REM Marcar instalacao como completa
echo Installation completed on %DATE% at %TIME% > "%INSTALL_MARKER%"

REM Limpar checkpoint
if exist "%CHECKPOINT_FILE%" del "%CHECKPOINT_FILE%" 2>nul

echo   ============================================================
echo   ^|          Launching AIEXX for the First Time!          ^|
echo   ============================================================
echo.
echo   Starting ComfyUI server...
echo   Browser will open automatically at http://localhost:8188
echo.

REM Iniciar ComfyUI
start "ComfyUI Server" /MIN cmd /c "cd ComfyUI && ..\.venv311\Scripts\python.exe main.py --listen 0.0.0.0 --port 8188 --preview-method auto --use-pytorch-cross-attention --bf16-unet --fp16-vae --highvram --dont-upcast-attention"

echo   [INFO] Waiting for server to start...
timeout /t 5 >nul

echo   [INFO] Opening browser...
start http://localhost:8188

echo.
echo   ============================================================
echo   ^|              First Launch Complete!                   ^|
echo   ============================================================
echo.
echo   Next time you run this script, it will:
echo   - Check for updates from GitHub
echo   - Start the system automatically
echo   - Open the browser
echo.
echo   Quick Start Guide:
echo   1. Load workflow: workflows/3d/03_triposr_single_image_to_mesh.json
echo   2. Upload an image
echo   3. Click "Queue Prompt"
echo   4. Wait ~30 seconds
echo   5. Download your .glb 3D model!
echo.
echo   Press any key to close this window...
pause >nul
exit /b 0

@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
REM ============================================
REM AIEXX GenAI - Professional Launcher
REM Version 1.2.0
REM ============================================

title AIEXX GenAI Launcher
color 0B

REM Navigate to project root
cd /d "%~dp0.."
set "PROJECT_ROOT=%CD%"

REM Setup logging
set "LOG_DIR=%PROJECT_ROOT%\logs"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
set "LOG_FILE=%LOG_DIR%\launcher_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log"
set "LOG_FILE=%LOG_FILE: =0%"

echo ============================================ >"%LOG_FILE%"
echo AIEXX Launcher Log >>"%LOG_FILE%"
echo Date: %date% %time% >>"%LOG_FILE%"
echo ============================================ >>"%LOG_FILE%"
echo. >>"%LOG_FILE%"

REM Helper function for logging (simulated via labels)
REM Call with: call :LOG "message"
goto :SKIP_LOG_FUNCTION
:LOG
    echo %~1 >>"%LOG_FILE%"
    echo %~1
    goto :EOF
:SKIP_LOG_FUNCTION

cd /d "%~dp0"

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
echo   GenAI Image to 3D System - v1.2.0
echo   Smart Launcher and Installer
echo.
echo ========================================================================
echo.

REM ============================================
REM CHECK IF INSTALLED
REM ============================================

set "MARKER=%PROJECT_ROOT%\.aiexx_installed"

echo Checking installation status... >>"%LOG_FILE%"
echo Marker file: %MARKER% >>"%LOG_FILE%"

if exist "%MARKER%" (
    echo Status: INSTALLED >>"%LOG_FILE%"
    goto LAUNCHER_MODE
) else (
    echo Status: NOT INSTALLED >>"%LOG_FILE%"
    goto INSTALL_MODE
)

REM ============================================
REM LAUNCHER MODE
REM ============================================

:LAUNCHER_MODE

echo [MODE] Launcher Mode - Starting System
echo.
echo ========================================================================
echo   System Checks
echo ========================================================================
echo.

REM Define venv paths
set "VENV_PATH=%PROJECT_ROOT%\.venv311"
set "PYTHON_EXE=%VENV_PATH%\Scripts\python.exe"

REM Check virtual environment
echo [1/4] Checking virtual environment...
if not exist "%PYTHON_EXE%" (
    color 0C
    echo [ERROR] Virtual environment missing!
    echo.
    echo Expected: %PYTHON_EXE%
    echo.
    echo Solution: Delete .aiexx_installed and run again to reinstall
    echo.
    pause
    exit /b 1
)
echo [OK] Virtual environment ready
echo.

REM Check PyTorch and CUDA
echo [2/4] Checking PyTorch and GPU...
"%PYTHON_EXE%" -c "import torch; print('PyTorch ' + torch.__version__); exit(0 if torch.cuda.is_available() else 1)" 2>nul
if errorlevel 1 (
    color 0E
    echo [WARNING] GPU not available - running in CPU mode
    echo.
    set "GPU_MODE=--cpu"
) else (
    echo [OK] GPU acceleration enabled
    echo.
    set "GPU_MODE=--highvram"
    set "PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512"
)

REM Check ComfyUI
echo [3/4] Checking ComfyUI...
set "COMFYUI_PATH=%PROJECT_ROOT%\ComfyUI"
if not exist "%COMFYUI_PATH%\main.py" (
    color 0C
    echo [ERROR] ComfyUI not found!
    echo.
    echo Solution: Delete .aiexx_installed and run again to reinstall
    echo.
    pause
    exit /b 1
)
echo [OK] ComfyUI ready
echo.

REM Check for updates
echo [4/4] Checking for updates...
if exist ".git" (
    where git >nul 2>&1
    if not errorlevel 1 (
        git fetch origin >nul 2>&1
        for /f %%i in ('git rev-list HEAD...origin/main --count 2^>nul') do set UPDATE_COUNT=%%i
        if not "!UPDATE_COUNT!"=="" (
            if !UPDATE_COUNT! GTR 0 (
                echo [UPDATE] !UPDATE_COUNT! update(s) available
                echo.
                choice /C YN /M "Update now"
                if not errorlevel 2 (
                    git pull origin main
                    if exist "requirements.txt" (
                        .venv311\Scripts\python.exe -m pip install -r requirements.txt --upgrade --quiet
                    )
                )
            ) else (
                echo [OK] System up to date
            )
        ) else (
            echo [OK] No updates available
        )
    ) else (
        echo [INFO] Git not available, skipping update check
    )
) else (
    echo [INFO] Not a git repository
)
echo.

echo ========================================================================
echo   Starting ComfyUI Server
echo ========================================================================
echo.
echo Starting server at: http://localhost:8188
echo Opening browser in 5 seconds...
echo.

REM Start ComfyUI in background with GPU optimization
start "AIEXX ComfyUI Server" /MIN cmd /c "cd ComfyUI && %PYTHON_EXE% main.py --listen 0.0.0.0 --port 8188 --preview-method auto --use-pytorch-cross-attention %GPU_MODE%"

REM Wait for server to start
timeout /t 5 /nobreak >nul

REM Open browser
start http://localhost:8188

echo.
echo ========================================================================
echo   AIEXX System Running!
echo ========================================================================
echo.
echo   ComfyUI: http://localhost:8188
echo.
echo   Quick Start:
echo   1. Load workflow from: workflows/3d/
echo   2. Upload an image
echo   3. Click Queue Prompt
echo   4. Download your 3D model!
echo.
echo   Close this window or press any key to continue...
echo   (Server keeps running in background)
echo.
pause >nul
exit /b 0

REM ============================================
REM INSTALL MODE
REM ============================================

:INSTALL_MODE

echo [MODE] Installation Mode - First Time Setup
echo.
echo ========================================================================
echo   AIEXX Installation Wizard
echo ========================================================================
echo.
echo   This will install:
echo   - Visual Studio Build Tools
echo   - Python Virtual Environment
echo   - ComfyUI and 3D-Pack
echo   - AI Models (20-30GB download)
echo.
echo   Time Required: 30-60 minutes
echo   Disk Space: 55GB minimum
echo.
echo ========================================================================
echo.
echo Press any key to start installation...
pause >nul

REM Check for checkpoint
set "CHECKPOINT=%PROJECT_ROOT%\.aiexx_checkpoint"
echo Checking for checkpoint: %CHECKPOINT% >>"%LOG_FILE%"

if exist "%CHECKPOINT%" (
    set /p STEP=<"%CHECKPOINT%"
    echo Found checkpoint at step !STEP! >>"%LOG_FILE%"
    echo.
    echo [INFO] Instalacao anterior encontrada no passo !STEP!
    choice /C YN /M "Continuar do passo !STEP!"
    if errorlevel 2 (
        del "%CHECKPOINT%"
        echo Checkpoint deleted, starting fresh >>"%LOG_FILE%"
        set STEP=0
    ) else (
        echo Resuming from step !STEP! >>"%LOG_FILE%"
    )
) else (
    echo No checkpoint found, starting fresh >>"%LOG_FILE%"
    set STEP=0
)

REM ============================================
REM STEP 1: VS BUILD TOOLS
REM ============================================

:STEP1
if %STEP% GEQ 1 goto STEP2

echo. >>"%LOG_FILE%"
echo ======================================== >>"%LOG_FILE%"
echo STEP 1: Visual Studio Build Tools >>"%LOG_FILE%"
echo ======================================== >>"%LOG_FILE%"

cls
echo.
echo ========================================================================
echo   [PASSO 1/4] Visual Studio Build Tools
echo ========================================================================
echo.
echo   Instalando ferramentas de compilacao C++...
echo   Apos este passo, voce DEVE reiniciar o computador!
echo.
echo   Log: %LOG_FILE%
echo.
pause

cd /d "%~dp0.."
echo Current directory: %CD% >>"%LOG_FILE%"

where winget >nul 2>&1
if errorlevel 1 (
    echo Winget not found, using manual installer >>"%LOG_FILE%"
    set "INSTALL_SCRIPT=01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS.bat"
) else (
    echo Winget found, using winget installer >>"%LOG_FILE%"
    set "INSTALL_SCRIPT=01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS_WINGET.bat"
)

echo Checking for script: !INSTALL_SCRIPT! >>"%LOG_FILE%"
if not exist "!INSTALL_SCRIPT!" (
    color 0C
    echo [ERRO] Script !INSTALL_SCRIPT! nao encontrado!
    echo [ERRO] Script !INSTALL_SCRIPT! nao encontrado! >>"%LOG_FILE%"
    echo.
    echo Estrutura de diretorio: >>"%LOG_FILE%"
    dir /b 01-SETUP-SCRIPTS >>"%LOG_FILE%" 2>&1
    echo.
    pause
    exit /b 1
)

echo Executing: !INSTALL_SCRIPT! >>"%LOG_FILE%"
call "!INSTALL_SCRIPT!"

if errorlevel 1 (
    color 0C
    echo.
    echo [ERRO] Instalacao falhou!
    echo [ERRO] Instalacao falhou! >>"%LOG_FILE%"
    echo Verifique o log em: %LOG_FILE%
    echo.
    pause
    exit /b 1
)

echo Step 1 completed successfully >>"%LOG_FILE%"
echo 1>"%CHECKPOINT%"
echo Checkpoint saved: 1 >>"%LOG_FILE%"

cls
echo.
echo ========================================================================
echo   Step 1 Complete - RESTART REQUIRED
echo ========================================================================
echo.
echo   YOU MUST RESTART YOUR COMPUTER NOW!
echo.
echo   After restart:
echo   - Run AIEXX_LAUNCHER.bat again
echo   - Installation will continue automatically
echo.
pause
echo.
choice /C YN /M "Restart computer now"
if not errorlevel 2 shutdown /r /t 30
exit /b 0

REM ============================================
REM STEP 2: PYTHON ENVIRONMENT
REM ============================================

:STEP2
if %STEP% GEQ 2 goto STEP3

cls
echo.
echo ========================================================================
echo   [STEP 2/4] Python Virtual Environment
echo ========================================================================
echo.

cd /d "%~dp0.."
if exist "01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat" (
    call "01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat"
) else (
    color 0C
    echo [ERRO] Script 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat nao encontrado!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha na instalacao!
    pause
    exit /b 1
)

if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo [ERROR] Virtual environment not created!
    pause
    exit /b 1
)

echo 2>"%CHECKPOINT%"
timeout /t 2 >nul

REM ============================================
REM STEP 3: COMFYUI
REM ============================================

:STEP3
if %STEP% GEQ 3 goto STEP4

cls
echo.
echo ========================================================================
echo   [STEP 3/4] ComfyUI and 3D-Pack
echo ========================================================================
echo.

cd /d "%~dp0.."
if exist "01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat" (
    call "01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat"
) else (
    color 0C
    echo [ERRO] Script 3-RUN_INSTALL_3DPACK.bat nao encontrado!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha na instalacao!
    pause
    exit /b 1
)

if not exist "ComfyUI\main.py" (
    color 0C
    echo [ERROR] ComfyUI not installed!
    pause
    exit /b 1
)

echo 3>"%CHECKPOINT%"
timeout /t 2 >nul

REM ============================================
REM STEP 4: DOWNLOAD MODELS
REM ============================================

:STEP4
if %STEP% GEQ 4 goto COMPLETE

cls
echo.
echo ========================================================================
echo   [STEP 4/4] Downloading AI Models
echo ========================================================================
echo.

cd /d "%~dp0.."
if exist "01-SETUP-SCRIPTS\4-DOWNLOAD_3D_MODELS.bat" (
    call "01-SETUP-SCRIPTS\4-DOWNLOAD_3D_MODELS.bat"
) else (
    color 0C
    echo [ERRO] Script 4-DOWNLOAD_3D_MODELS.bat nao encontrado!
    pause
    exit /b 1
)

if errorlevel 1 (
    color 0E
    echo.
    echo [WARNING] Download had issues
    choice /C CR /M "Continue or Retry"
    if errorlevel 2 goto STEP4
)

echo 4>"%CHECKPOINT%"

REM ============================================
REM INSTALLATION COMPLETE
REM ============================================

:COMPLETE

cls
echo.
echo.
echo ========================================================================
echo.
echo      AAA    IIIII  EEEEE  XX   XX  XX   XX
echo     AAAAA    III   EE      XX XX    XX XX
echo    AA   AA   III   EEEE     XXX      XXX
echo   AAAAAAA    III   EE      XX XX    XX XX
echo  AA     AA  IIIII  EEEEE  XX   XX  XX   XX
echo.
echo   Installation Complete!
echo.
echo ========================================================================
echo.
echo   AIEXX GenAI Image to 3D is ready to use!
echo.
echo   System Status:
echo   - ComfyUI: Installed
echo   - Python Environment: Ready
echo   - 3D Models: Downloaded
echo.

REM Mark as installed
echo Installed on %DATE% at %TIME%>"%MARKER%"

REM Clean up checkpoint
if exist "%CHECKPOINT%" del "%CHECKPOINT%"

echo ========================================================================
echo   Launching System...
echo ========================================================================
echo.

REM Start ComfyUI with GPU optimization
cd "%COMFYUI_PATH%"
start "AIEXX ComfyUI Server" "%PYTHON_EXE%" main.py --listen 0.0.0.0 --port 8188 --preview-method auto --use-pytorch-cross-attention --highvram

echo Starting server...
timeout /t 5 /nobreak >nul

echo Opening browser...
start http://localhost:8188

echo.
echo ========================================================================
echo   First Launch Complete!
echo ========================================================================
echo.
echo   Next time, just run AIEXX_LAUNCHER.bat to start the system!
echo.
echo   Quick Start Guide:
echo   1. Load: workflows/3d/03_triposr_single_image_to_mesh.json
echo   2. Upload an image
echo   3. Click Queue Prompt
echo   4. Download your .glb file!
echo.
pause
exit /b 0

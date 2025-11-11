@echo off
chcp 65001 >nul 2>&1
title AIEXX - Download Stable Diffusion Models
color 0B

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
echo   Stable Diffusion Models Setup
echo.
echo ========================================================================
echo.
echo   This script downloads Stable Diffusion models required for
echo   prompt-based 3D generation workflows.
echo.
echo ========================================================================
echo.

cd /d "%~dp0"

REM Verificar ambiente virtual
echo [INFO] Checking virtual environment...
echo [INFO] Looking for: %CD%\.venv311\Scripts\python.exe
echo.

if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo [ERROR] Virtual environment not found!
    echo [ERROR] Expected path: %CD%\.venv311
    echo.
    echo [SOLUTION] Run one of these scripts first:
    echo   - 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo   - 6-START_AIEXX.bat (auto-creates venv)
    echo.
    pause
    exit /b 1
)

echo [OK] Virtual environment found!
echo.

REM Verificar script Python
if not exist "download_sd_models.py" (
    color 0C
    echo [ERROR] Script download_sd_models.py not found!
    echo [ERROR] Expected path: %CD%\download_sd_models.py
    echo.
    pause
    exit /b 1
)

echo [OK] Download script found!
echo.

echo ========================================================================
echo   Starting Stable Diffusion Models Download
echo ========================================================================
echo.
echo   This will download approximately 6GB of models:
echo   - Stable Diffusion 1.5 (~4GB)
echo   - SD 1.5 VAE (~335MB)
echo   - CLIP Vision (~1.7GB)
echo.
echo   Make sure you have:
echo   - Stable internet connection
echo   - At least 10GB free disk space
echo   - Optional: HuggingFace token in .env file
echo.
echo ========================================================================
echo.

pause

echo [INFO] Executing download script...
echo.

REM Usar o Python do ambiente virtual diretamente
"%CD%\.venv311\Scripts\python.exe" download_sd_models.py

if errorlevel 1 (
    echo.
    echo ========================================================================
    echo   [ERROR] Download Failed!
    echo ========================================================================
    echo.
    echo   Possible causes:
    echo   1. Internet connection problems
    echo   2. Insufficient disk space
    echo   3. Missing HuggingFace token (for some models)
    echo.
    echo   Solutions:
    echo   - Check your internet connection
    echo   - Free up disk space (need ~10GB)
    echo   - Create .env file with: HUGGING_FACE_HUB_TOKEN=your_token
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo   Download Complete!
echo ========================================================================
echo.
echo   Stable Diffusion models are now ready!
echo.
echo   Next steps:
echo   - You can now use prompt-based workflows
echo   - Run: 6-START_AIEXX.bat to start the system
echo   - Load workflows from: workflows/basic/
echo.
pause

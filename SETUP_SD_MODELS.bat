@echo off
chcp 65001 > nul
title AIEXX - Download Stable Diffusion Models
color 0B

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
echo   ════════════════════════════════════════════════════════════════
echo   ║        Stable Diffusion Models Setup                        ║
echo   ║        Required for Prompt-Based Workflows                  ║
echo   ════════════════════════════════════════════════════════════════
echo.

REM Verificar ambiente virtual
if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo   [ERROR] Virtual environment not found!
    echo   [ERROR] Run setup first
    pause
    exit /b 1
)

echo   [INFO] Activating virtual environment...
call .venv311\Scripts\activate.bat

echo   [INFO] Starting download process...
echo.

REM Executar o script Python de download
python download_sd_models.py

if errorlevel 1 (
    echo.
    echo   [ERROR] Download failed!
    pause
    exit /b 1
)

echo.
echo   ════════════════════════════════════════════════════════════════
echo   ║                    Setup Complete!                          ║
echo   ════════════════════════════════════════════════════════════════
echo.
echo   You can now run START_AIEXX.bat to start the system
echo.
pause

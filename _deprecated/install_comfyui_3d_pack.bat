@echo off
title AIEXX - Installing ComfyUI-3D-Pack
color 0A

echo.
echo ========================================
echo   Installing ComfyUI-3D-Pack
echo ========================================
echo.

REM Set CUDA paths
set "CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
set "CUDA_PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
set "PATH=%CUDA_HOME%\bin;%PATH%"

echo CUDA_PATH: %CUDA_PATH%
echo.

REM Verify nvcc is available
echo Verifying CUDA Toolkit...
nvcc --version
if errorlevel 1 (
    echo ERROR: nvcc not found!
    pause
    exit /b 1
)

echo.
echo CUDA Toolkit found! Starting installation...
echo.

REM Run install.py
cd /d "%~dp0"
.venv311\Scripts\python.exe ComfyUI\custom_nodes\ComfyUI-3D-Pack\install.py

echo.
echo ========================================
echo   Installation Complete!
echo ========================================
echo.
pause

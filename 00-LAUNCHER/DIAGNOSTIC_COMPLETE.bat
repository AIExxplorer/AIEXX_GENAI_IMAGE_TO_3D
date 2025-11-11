@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion
title AIEXX - Diagnóstico Completo do Sistema
color 0B

REM ============================================
REM AIEXX Complete System Diagnostic Tool
REM Version 1.1.0
REM ============================================

cd /d "%~dp0.."
set "PROJECT_ROOT=%CD%"
set "LOG_FILE=%PROJECT_ROOT%\aiexx_diagnostic_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log"
set "LOG_FILE=%LOG_FILE: =0%"

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
echo   DIAGNOSTICO COMPLETO DO SISTEMA
echo   Version 1.2.0
echo.
echo ========================================================================
echo.
echo Log sera salvo em:
echo %LOG_FILE%
echo.
echo ========================================================================
echo.

REM Initialize log
echo ============================================ >"%LOG_FILE%"
echo AIEXX System Diagnostic Report >>"%LOG_FILE%"
echo Date: %date% %time% >>"%LOG_FILE%"
echo ============================================ >>"%LOG_FILE%"
echo. >>"%LOG_FILE%"

set TOTAL_CHECKS=0
set PASSED_CHECKS=0
set FAILED_CHECKS=0
set WARNING_CHECKS=0

REM ============================================
REM 1. SYSTEM INFORMATION
REM ============================================

echo [1/10] Coletando informacoes do sistema... | tee -a "%LOG_FILE%"
echo. | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

echo System Information: >>"%LOG_FILE%"
echo   OS: %OS% >>"%LOG_FILE%"
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" >>"%LOG_FILE%" 2>&1

echo [OK] Informacoes do sistema coletadas
echo. | tee -a "%LOG_FILE%"
set /a PASSED_CHECKS+=1

REM ============================================
REM 2. CHECK GIT
REM ============================================

echo [2/10] Verificando Git... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

where git >nul 2>&1
if errorlevel 1 (
    color 0E
    echo [WARNING] Git nao encontrado no PATH | tee -a "%LOG_FILE%"
    echo   Repositorio nao pode ser atualizado automaticamente >>"%LOG_FILE%"
    set /a WARNING_CHECKS+=1
) else (
    git --version >>"%LOG_FILE%" 2>&1
    echo [OK] Git instalado | tee -a "%LOG_FILE%"
    set /a PASSED_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 3. CHECK PYTHON
REM ============================================

echo [3/10] Verificando Python... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

where python >nul 2>&1
if errorlevel 1 (
    color 0C
    echo [ERRO] Python nao encontrado no PATH! | tee -a "%LOG_FILE%"
    echo   Instale Python 3.11.9 de: https://www.python.org/downloads/ >>"%LOG_FILE%"
    set /a FAILED_CHECKS+=1
) else (
    python --version >>"%LOG_FILE%" 2>&1
    echo [OK] Python instalado | tee -a "%LOG_FILE%"
    set /a PASSED_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 4. CHECK VIRTUAL ENVIRONMENT
REM ============================================

echo [4/10] Verificando ambiente virtual... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

if exist ".venv311\Scripts\python.exe" (
    echo [OK] Ambiente virtual .venv311 existe | tee -a "%LOG_FILE%"

    REM Check Python version in venv
    .venv311\Scripts\python.exe --version >>"%LOG_FILE%" 2>&1

    REM Check pip
    .venv311\Scripts\python.exe -m pip --version >>"%LOG_FILE%" 2>&1

    echo   Python venv: >>"%LOG_FILE%"
    .venv311\Scripts\python.exe --version >>"%LOG_FILE%" 2>&1

    set /a PASSED_CHECKS+=1
) else (
    color 0E
    echo [WARNING] Ambiente virtual .venv311 nao encontrado | tee -a "%LOG_FILE%"
    echo   Execute: 01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat >>"%LOG_FILE%"
    set /a WARNING_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 5. CHECK VISUAL STUDIO BUILD TOOLS
REM ============================================

echo [5/10] Verificando Visual Studio Build Tools... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set "VCVARSALL="

if exist "%VSWHERE%" (
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        set "VCVARSALL=%%i\VC\Auxiliary\Build\vcvarsall.bat"
    )
)

if exist "%VCVARSALL%" (
    echo [OK] Visual Studio Build Tools encontrado | tee -a "%LOG_FILE%"
    echo   Caminho: %VCVARSALL% >>"%LOG_FILE%"
    set /a PASSED_CHECKS+=1
) else (
    color 0E
    echo [WARNING] VS Build Tools nao encontrado | tee -a "%LOG_FILE%"
    echo   Execute: 01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS.bat >>"%LOG_FILE%"
    set /a WARNING_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 6. CHECK CUDA TOOLKIT
REM ============================================

echo [6/10] Verificando CUDA Toolkit... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

where nvcc >nul 2>&1
if errorlevel 1 (
    REM Try default path
    if exist "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8\bin\nvcc.exe" (
        echo [OK] CUDA Toolkit 12.8 encontrado | tee -a "%LOG_FILE%"
        echo   Caminho: C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8 >>"%LOG_FILE%"
        set /a PASSED_CHECKS+=1
    ) else (
        color 0E
        echo [WARNING] CUDA Toolkit nao encontrado no PATH | tee -a "%LOG_FILE%"
        echo   Instale de: https://developer.nvidia.com/cuda-downloads >>"%LOG_FILE%"
        set /a WARNING_CHECKS+=1
    )
) else (
    nvcc --version >>"%LOG_FILE%" 2>&1
    echo [OK] CUDA Toolkit disponivel | tee -a "%LOG_FILE%"
    set /a PASSED_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 7. CHECK PYTORCH
REM ============================================

echo [7/10] Verificando PyTorch... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

if exist ".venv311\Scripts\python.exe" (
    .venv311\Scripts\python.exe -c "import torch; print(f'PyTorch {torch.__version__}'); print(f'CUDA Available: {torch.cuda.is_available()}'); print(f'CUDA Version: {torch.version.cuda}')" >>"%LOG_FILE%" 2>&1
    if errorlevel 1 (
        color 0E
        echo [WARNING] PyTorch nao instalado | tee -a "%LOG_FILE%"
        set /a WARNING_CHECKS+=1
    ) else (
        echo [OK] PyTorch instalado e funcional | tee -a "%LOG_FILE%"
        set /a PASSED_CHECKS+=1
    )
) else (
    color 0E
    echo [WARNING] Ambiente virtual nao encontrado | tee -a "%LOG_FILE%"
    set /a WARNING_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 8. CHECK COMFYUI
REM ============================================

echo [8/10] Verificando ComfyUI... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

if exist "ComfyUI\main.py" (
    echo [OK] ComfyUI instalado | tee -a "%LOG_FILE%"

    REM Check for 3D-Pack
    if exist "ComfyUI\custom_nodes\ComfyUI-3D-Pack\__init__.py" (
        echo [OK] ComfyUI-3D-Pack instalado | tee -a "%LOG_FILE%"
    ) else (
        color 0E
        echo [WARNING] ComfyUI-3D-Pack nao encontrado | tee -a "%LOG_FILE%"
    )

    set /a PASSED_CHECKS+=1
) else (
    color 0E
    echo [WARNING] ComfyUI nao encontrado | tee -a "%LOG_FILE%"
    echo   Execute: 01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat >>"%LOG_FILE%"
    set /a WARNING_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 9. CHECK MODELS
REM ============================================

echo [9/10] Verificando modelos 3D... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

set MODEL_COUNT=0

if exist "ComfyUI\models\checkpoints" (
    for %%F in ("ComfyUI\models\checkpoints\*.*") do set /a MODEL_COUNT+=1
)

if %MODEL_COUNT% GTR 0 (
    echo [OK] Encontrados %MODEL_COUNT% modelos em checkpoints | tee -a "%LOG_FILE%"
    set /a PASSED_CHECKS+=1
) else (
    color 0E
    echo [WARNING] Nenhum modelo encontrado | tee -a "%LOG_FILE%"
    echo   Execute: 01-SETUP-SCRIPTS\4-DOWNLOAD_3D_MODELS.bat >>"%LOG_FILE%"
    set /a WARNING_CHECKS+=1
)
echo. >>"%LOG_FILE%"

REM ============================================
REM 10. CHECK DISK SPACE
REM ============================================

echo [10/10] Verificando espaco em disco... | tee -a "%LOG_FILE%"
set /a TOTAL_CHECKS+=1

for /f "tokens=3" %%a in ('dir /-c "%PROJECT_ROOT%" ^| find "bytes free"') do set FREE_SPACE=%%a

echo   Espaco livre: %FREE_SPACE% bytes >>"%LOG_FILE%"
echo [OK] Verificacao de espaco concluida | tee -a "%LOG_FILE%"
set /a PASSED_CHECKS+=1

echo. >>"%LOG_FILE%"

REM ============================================
REM SUMMARY
REM ============================================

echo. >>"%LOG_FILE%"
echo ======================================================================== >>"%LOG_FILE%"
echo   RESUMO DO DIAGNOSTICO >>"%LOG_FILE%"
echo ======================================================================== >>"%LOG_FILE%"
echo. >>"%LOG_FILE%"
echo   Total de verificacoes: %TOTAL_CHECKS% >>"%LOG_FILE%"
echo   Passou: %PASSED_CHECKS% >>"%LOG_FILE%"
echo   Avisos: %WARNING_CHECKS% >>"%LOG_FILE%"
echo   Falhas: %FAILED_CHECKS% >>"%LOG_FILE%"
echo. >>"%LOG_FILE%"

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
echo   RESUMO DO DIAGNOSTICO
echo.
echo ========================================================================
echo.
echo   Total de verificacoes: %TOTAL_CHECKS%
echo.
echo   [OK] Passou: %PASSED_CHECKS%
echo   [!]  Avisos: %WARNING_CHECKS%
echo   [X]  Falhas: %FAILED_CHECKS%
echo.
echo ========================================================================
echo.

if %FAILED_CHECKS% GTR 0 (
    color 0C
    echo   STATUS: SISTEMA COM PROBLEMAS CRITICOS
) else if %WARNING_CHECKS% GTR 0 (
    color 0E
    echo   STATUS: SISTEMA PARCIALMENTE CONFIGURADO
) else (
    color 0A
    echo   STATUS: SISTEMA PRONTO PARA USO!
)

echo.
echo ========================================================================
echo.
echo Log detalhado salvo em:
echo %LOG_FILE%
echo.
echo ========================================================================
echo.

pause
exit /b 0

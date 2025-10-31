@echo off
title AIEXX - Download 3D Models
color 0A

echo.
echo ========================================================================
echo   AIEXX - Download de Modelos 3D Necessarios
echo ========================================================================
echo.

cd /d "%~dp0"

:: Definir caminho do Python do venv
set "VENV_PYTHON=%CD%\.venv311\Scripts\python.exe"

if not exist "%VENV_PYTHON%" (
    color 0C
    echo [ERRO] Ambiente virtual nao encontrado!
    echo Execute primeiro: FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    pause
    exit /b 1
)

echo [INFO] Usando Python: %VENV_PYTHON%
echo.

:: ============================================
:: PASSO 1: Instalar dependências
:: ============================================

echo [1/2] Instalando dependencias para download de modelos...
echo.

"%VENV_PYTHON%" -m pip install huggingface-hub tqdm --quiet

if errorlevel 1 (
    color 0E
    echo [AVISO] Falha ao instalar dependencias, tentando continuar...
    echo.
)

echo [OK] Dependencias instaladas!
echo.

:: ============================================
:: PASSO 2: Executar script de download
:: ============================================

echo [2/2] Iniciando download de modelos...
echo.

"%VENV_PYTHON%" download_models.py

if errorlevel 1 (
    color 0C
    echo.
    echo [ERRO] Falha ao executar script de download!
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo   Download concluido!
echo ========================================================================
echo.

pause

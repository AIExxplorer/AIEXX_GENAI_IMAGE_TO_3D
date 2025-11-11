@echo off
chcp 65001 >nul 2>&1
title AIEXX - Teste de Launcher
color 0E

echo.
echo ========================================================================
echo   AIEXX - Teste de Estrutura e Configuracao
echo ========================================================================
echo.

cd /d "%~dp0.."
set "PROJECT_ROOT=%CD%"

echo [INFO] Projeto Root: %PROJECT_ROOT%
echo.

echo [1/5] Verificando estrutura de diretorios...
echo.

if exist "00-LAUNCHER" (
    echo [OK] 00-LAUNCHER existe
) else (
    echo [ERRO] 00-LAUNCHER NAO encontrado!
)

if exist "01-SETUP-SCRIPTS" (
    echo [OK] 01-SETUP-SCRIPTS existe
    echo      Conteudo:
    dir /b "01-SETUP-SCRIPTS\*.bat" 2>nul
) else (
    echo [ERRO] 01-SETUP-SCRIPTS NAO encontrado!
)

if exist "02-PYTHON-SCRIPTS" (
    echo [OK] 02-PYTHON-SCRIPTS existe
) else (
    echo [ERRO] 02-PYTHON-SCRIPTS NAO encontrado!
)

if exist "03-DOCUMENTATION" (
    echo [OK] 03-DOCUMENTATION existe
) else (
    echo [ERRO] 03-DOCUMENTATION NAO encontrado!
)

echo.
echo [2/5] Verificando arquivos principais...
echo.

if exist "aiexx_logo_ascii.txt" (
    echo [OK] Logo ASCII existe
) else (
    echo [AVISO] Logo ASCII NAO encontrado
)

if exist ".aiexx_installed" (
    echo [OK] Marker de instalacao existe - MODO LAUNCHER
) else (
    echo [INFO] Marker de instalacao NAO existe - MODO INSTALACAO
)

if exist ".aiexx_checkpoint" (
    set /p CHECKPOINT_STEP=<".aiexx_checkpoint"
    echo [INFO] Checkpoint encontrado no passo: !CHECKPOINT_STEP!
) else (
    echo [INFO] Nenhum checkpoint encontrado
)

echo.
echo [3/5] Verificando ambiente virtual...
echo.

if exist ".venv311\Scripts\python.exe" (
    echo [OK] Ambiente virtual .venv311 existe
    .venv311\Scripts\python.exe --version 2>nul
) else (
    echo [INFO] Ambiente virtual .venv311 NAO encontrado
)

echo.
echo [4/5] Verificando ComfyUI...
echo.

if exist "ComfyUI\main.py" (
    echo [OK] ComfyUI instalado
    if exist "ComfyUI\custom_nodes\ComfyUI-3D-Pack" (
        echo [OK] ComfyUI-3D-Pack instalado
    ) else (
        echo [INFO] ComfyUI-3D-Pack NAO encontrado
    )
) else (
    echo [INFO] ComfyUI NAO instalado
)

echo.
echo [5/5] Testando navegacao de diretorios...
echo.

cd /d "%~dp0"
echo Diretorio do launcher: %CD%
echo.

cd /d "%~dp0.."
echo Diretorio raiz do projeto: %CD%
echo.

if exist "01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS.bat" (
    echo [OK] Script 1-INSTALL_VS_BUILDTOOLS.bat acessivel
) else (
    echo [ERRO] Script 1-INSTALL_VS_BUILDTOOLS.bat NAO acessivel!
)

echo.
echo ========================================================================
echo   Teste Concluido
echo ========================================================================
echo.

pause

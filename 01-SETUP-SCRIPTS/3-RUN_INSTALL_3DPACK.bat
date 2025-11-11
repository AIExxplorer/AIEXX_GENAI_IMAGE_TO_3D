@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

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
echo   ComfyUI 3D-Pack Installer
echo.
echo ========================================================================
echo.

:: Configurar CUDA
set "CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
set "CUDA_PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
set "PATH=%CUDA_HOME%\bin;%CUDA_HOME%\lib\x64;%PATH%"

echo [1/5] Verificando CUDA Toolkit...
echo CUDA_PATH: %CUDA_PATH%
echo.

:: Verificar nvcc
where nvcc >nul 2>&1
if errorlevel 1 (
    echo [ERRO] nvcc nao encontrado no PATH!
    echo.
    echo Por favor, verifique se o CUDA Toolkit 12.8 esta instalado em:
    echo %CUDA_HOME%
    echo.
    echo Se estiver instalado, pode ser necessario:
    echo 1. Adicionar manualmente ao PATH do sistema
    echo 2. Reiniciar o computador
    echo 3. Abrir um NOVO terminal
    echo.
    pause
    exit /b 1
)

echo [OK] CUDA Toolkit encontrado!
nvcc --version
echo.

echo [2/5] Ativando ambiente Python...
REM Navigate to project root (one level up from 01-SETUP-SCRIPTS)
cd /d "%~dp0.."
if not exist ".venv311\Scripts\python.exe" (
    echo [ERRO] Ambiente virtual nao encontrado!
    pause
    exit /b 1
)
echo [OK] Ambiente Python encontrado!
echo.

echo [3/5] Verificando PyTorch e CUDA...
.venv311\Scripts\python.exe -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA disponivel: {torch.cuda.is_available()}'); print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')"
echo.

echo [4/5] Iniciando instalacao do ComfyUI-3D-Pack...
echo Este processo pode levar 10-30 minutos.
echo Aguarde...
echo.

.venv311\Scripts\python.exe ComfyUI\custom_nodes\ComfyUI-3D-Pack\install.py

if errorlevel 1 (
    echo.
    echo [ERRO] Instalacao falhou!
    echo.
    echo Verifique os erros acima e tente:
    echo 1. Instalar Visual Studio Build Tools
    echo 2. Reiniciar o computador
    echo 3. Executar como Administrador
    echo.
    pause
    exit /b 1
)

echo.
echo [5/5] Verificando instalacao...
.venv311\Scripts\python.exe -c "try: import nvdiffrast; print('[OK] nvdiffrast instalado com sucesso!'); except: print('[ERRO] nvdiffrast nao encontrado')"
echo.

echo ========================================
echo   Instalacao Concluida!
echo ========================================
echo.
echo Pressione qualquer tecla para fechar...
pause >nul

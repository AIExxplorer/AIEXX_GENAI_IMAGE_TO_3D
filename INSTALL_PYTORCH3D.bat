@echo off
chcp 65001 >nul
cls
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   INSTALACAO PYTORCH3D - ComfyUI-3D-Pack
echo.
echo ========================================================================
echo.
echo   Este script vai instalar o pytorch3d necessario para workflows 3D.
echo   A instalacao pode levar 10-30 minutos.
echo.
echo ========================================================================
echo.
pause

echo.
echo [1/5] Verificando ambiente virtual...
if not exist ".venv311\Scripts\python.exe" (
    echo [ERRO] Ambiente virtual nao encontrado!
    pause
    exit /b 1
)
echo   [OK] Ambiente virtual encontrado
echo.

echo [2/5] Instalando dependencias do pytorch3d...
echo.

REM Instalar dependencias necessarias
.venv311\Scripts\pip.exe install iopath fvcore
if errorlevel 1 (
    echo [ERRO] Falha ao instalar dependencias!
    pause
    exit /b 1
)
echo   [OK] Dependencias instaladas
echo.

echo [3/5] Tentando instalar pytorch3d pre-compilado...
echo.

REM Tentar instalar wheel pre-compilado (mais rapido)
.venv311\Scripts\pip.exe install pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py311_cu121_pyt270/download.html

if not errorlevel 1 (
    echo   [OK] pytorch3d instalado com sucesso!
    goto verify
)

echo.
echo [AVISO] Wheel pre-compilado nao encontrado.
echo Tentando compilar do codigo-fonte...
echo Isso pode levar 15-30 minutos!
echo.

echo [4/5] Clonando repositorio pytorch3d...
echo.

if exist "temp_pytorch3d" rd /s /q temp_pytorch3d
git clone https://github.com/facebookresearch/pytorch3d.git temp_pytorch3d

if errorlevel 1 (
    echo [ERRO] Falha ao clonar repositorio!
    echo.
    echo Instalando diretamente do GitHub...
    .venv311\Scripts\pip.exe install "git+https://github.com/facebookresearch/pytorch3d.git"
    goto verify
)

echo.
echo [5/5] Compilando pytorch3d...
echo AGUARDE - Este processo e LENTO mas necessario!
echo.

cd temp_pytorch3d
..\.venv311\Scripts\pip.exe install -e .
cd ..

if errorlevel 1 (
    echo [ERRO] Falha na compilacao!
    pause
    exit /b 1
)

:verify
echo.
echo ========================================================================
echo   Verificando instalacao...
echo ========================================================================
echo.

.venv311\Scripts\python.exe -c "import pytorch3d; print(f'pytorch3d version: {pytorch3d.__version__}')"

if errorlevel 1 (
    echo.
    echo [ERRO] pytorch3d nao foi instalado corretamente!
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo   SUCESSO! pytorch3d instalado!
echo ========================================================================
echo.
echo   Agora voce pode:
echo   1. Reiniciar ComfyUI: START.bat
echo   2. Usar workflows 3D (TripoSR, InstantMesh, etc)
echo.
echo ========================================================================
echo.

REM Limpar arquivos temporarios
if exist "temp_pytorch3d" rd /s /q temp_pytorch3d

pause

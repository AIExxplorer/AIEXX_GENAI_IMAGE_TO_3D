@echo off
chcp 65001 >nul 2>&1
title AIEXX - Fix venv + Install torch_scatter
color 0A

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
echo   Corrigir Ambiente Virtual + Instalar torch_scatter
echo.
echo ========================================================================
echo.

REM Navigate to project root (one level up from 01-SETUP-SCRIPTS)
cd /d "%~dp0.."

:: ============================================
:: PASSO 1: Remover ambiente virtual corrompido
:: ============================================

echo [1/6] Verificando ambiente virtual...
echo.

if exist ".venv311\Scripts\python.exe" (
    echo [OK] Ambiente virtual parece estar correto!
    echo.
    goto :check_buildtools
)

if exist ".venv311" (
    color 0E
    echo [AVISO] Ambiente virtual existe mas esta corrompido!
    echo [INFO] Removendo pasta .venv311...
    echo.

    rd /s /q ".venv311" 2>nul

    if exist ".venv311" (
        color 0C
        echo [ERRO] Nao foi possivel remover .venv311
        echo Por favor, delete manualmente a pasta .venv311 e execute novamente.
        echo.
        pause
        exit /b 1
    )

    echo [OK] Pasta corrompida removida!
    echo.
)

:: ============================================
:: PASSO 2: Verificar Python 3.11
:: ============================================

echo [2/6] Verificando Python 3.11...
echo.

where python >nul 2>&1
if errorlevel 1 (
    color 0C
    echo [ERRO] Python nao encontrado no PATH!
    echo.
    echo Instale Python 3.11.9 primeiro.
    echo Download: https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

python --version
echo.

:: ============================================
:: PASSO 3: Criar novo ambiente virtual
:: ============================================

echo [3/6] Criando novo ambiente virtual...
echo.

python -m venv .venv311

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao criar ambiente virtual!
    echo.
    echo Tente executar manualmente:
    echo   python -m venv .venv311
    echo.
    pause
    exit /b 1
)

:: Verificar se foi criado corretamente
if not exist ".venv311\Scripts\python.exe" (
    color 0C
    echo [ERRO] Ambiente virtual criado mas python.exe nao existe!
    echo.
    pause
    exit /b 1
)

echo [OK] Ambiente virtual criado com sucesso!
echo.

:: Definir caminho do Python do venv
set "VENV_PYTHON=%CD%\.venv311\Scripts\python.exe"
set "VENV_PIP=%CD%\.venv311\Scripts\pip.exe"

echo [INFO] Python do venv: %VENV_PYTHON%
echo.

:: ============================================
:: PASSO 3.1: Atualizar pip
:: ============================================

echo [INFO] Atualizando pip no ambiente virtual...
echo.

"%VENV_PYTHON%" -m pip install --upgrade pip

if errorlevel 1 (
    color 0E
    echo [AVISO] Falha ao atualizar pip, continuando...
    echo.
)

echo [OK] pip atualizado!
echo.

:: ============================================
:: PASSO 3.2: Instalar PyTorch com CUDA
:: ============================================

echo [INFO] Instalando PyTorch 2.7.0+cu128...
echo Este processo pode levar 5-10 minutos (~2-3GB download)...
echo.

"%VENV_PYTHON%" -m pip install torch==2.7.0 torchvision==0.22.0 torchaudio==2.7.0 --index-url https://download.pytorch.org/whl/cu128

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao instalar PyTorch!
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] PyTorch instalado com sucesso!
echo.

:: ============================================
:: PASSO 4: Verificar VS Build Tools
:: ============================================

:check_buildtools

echo [4/6] Verificando Visual Studio Build Tools...
echo.

:: Tenta encontrar o vcvarsall.bat
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set "VCVARSALL="

if exist "%VSWHERE%" (
    echo Procurando instalacao do Visual Studio...
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        set "VCVARSALL=%%i\VC\Auxiliary\Build\vcvarsall.bat"
    )
)

:: Se não encontrou com vswhere, tenta caminhos padrão
if not exist "%VCVARSALL%" (
    echo Tentando caminhos padrao...
    if exist "%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" (
        set "VCVARSALL=%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
    ) else if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" (
        set "VCVARSALL=%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
    ) else if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" (
        set "VCVARSALL=%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
    ) else if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" (
        set "VCVARSALL=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
    )
)

if not exist "%VCVARSALL%" (
    color 0C
    echo [ERRO] Visual Studio Build Tools nao encontrado!
    echo.
    echo Execute primeiro: INSTALL_VS_BUILDTOOLS_WINGET.bat
    echo.
    pause
    exit /b 1
)

echo Encontrado: %VCVARSALL%
echo Configurando ambiente de compilacao...
echo.

:: Configura o ambiente VS (x64)
call "%VCVARSALL%" x64 >nul 2>&1

:: Verifica se cl.exe agora está disponível
where cl.exe >nul 2>&1
if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao configurar ambiente de compilacao!
    echo.
    pause
    exit /b 1
)

echo [OK] Build Tools configurado com sucesso!
echo.

:: ============================================
:: PASSO 5: Instalar torch_scatter
:: ============================================

echo [5/6] Instalando torch_scatter...
echo.
echo Este processo pode levar 5-15 minutos e inclui compilacao C++/CUDA.
echo Aguarde...
echo.

:: Definir variáveis de compilação
set MAX_JOBS=4
set FORCE_CUDA=1

:: Usar caminho absoluto do Python do venv
set "VENV_PYTHON=%CD%\.venv311\Scripts\python.exe"

:: Instalar torch_scatter
"%VENV_PYTHON%" -m pip install torch-scatter -f https://data.pyg.org/whl/torch-2.7.0+cu128.html

if errorlevel 1 (
    color 0E
    echo.
    echo [AVISO] Instalacao via PyG falhou. Tentando compilar do source...
    echo.

    :: Tentar instalar do GitHub
    "%VENV_PYTHON%" -m pip install git+https://github.com/rusty1s/pytorch_scatter.git

    if errorlevel 1 (
        color 0C
        echo.
        echo [ERRO] Falha ao instalar torch_scatter!
        echo.
        pause
        exit /b 1
    )
)

echo.

:: ============================================
:: PASSO 6: Verificar instalação
:: ============================================

echo [6/6] Verificando instalacao...
echo.

"%VENV_PYTHON%" -c "import torch; print(f'[OK] PyTorch {torch.__version__} com CUDA {torch.version.cuda}')"

if errorlevel 1 (
    color 0C
    echo [ERRO] PyTorch nao pode ser importado!
    pause
    exit /b 1
)

echo.

"%VENV_PYTHON%" -c "import torch_scatter; print(f'[OK] torch_scatter {torch_scatter.__version__} instalado com sucesso!')"

if errorlevel 1 (
    color 0C
    echo [ERRO] torch_scatter nao pode ser importado!
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo ========================================================================
echo.
echo Ambiente virtual: .venv311
echo Python: %VENV_PYTHON%
echo PyTorch: 2.7.0+cu128
echo torch_scatter: Instalado e funcional
echo.
echo Proximo passo:
echo   Execute: RUN_INSTALL_3DPACK.bat
echo   (para instalar ComfyUI-3D-Pack completo)
echo.
echo ========================================================================
echo.

pause

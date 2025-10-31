@echo off
title AIEXX - Setup venv + torch_scatter
color 0A

echo.
echo ========================================================================
echo   AIEXX - Setup Ambiente Virtual + torch_scatter
echo ========================================================================
echo.

cd /d "%~dp0"

:: ============================================
:: PASSO 1: Verificar se venv já existe
:: ============================================

echo [1/5] Verificando ambiente virtual...
echo.

if exist ".venv311\Scripts\python.exe" (
    echo [OK] Ambiente virtual .venv311 ja existe!
    echo.
    goto :check_buildtools
)

echo [INFO] Ambiente virtual nao encontrado. Criando...
echo.

:: ============================================
:: PASSO 1.1: Verificar Python 3.11
:: ============================================

where python >nul 2>&1
if errorlevel 1 (
    color 0C
    echo [ERRO] Python nao encontrado no PATH!
    echo.
    echo Instale Python 3.11.9 primeiro.
    echo.
    pause
    exit /b 1
)

python --version | findstr "3.11" >nul 2>&1
if errorlevel 1 (
    color 0E
    echo [AVISO] Python 3.11 nao detectado!
    echo Tentando continuar...
    echo.
)

:: ============================================
:: PASSO 1.2: Criar ambiente virtual
:: ============================================

echo [INFO] Criando ambiente virtual Python...
echo.

python -m venv .venv311

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao criar ambiente virtual!
    echo.
    pause
    exit /b 1
)

echo [OK] Ambiente virtual criado com sucesso!
echo.

:: ============================================
:: PASSO 1.3: Atualizar pip
:: ============================================

echo [INFO] Atualizando pip...
echo.

call .venv311\Scripts\activate.bat
python -m pip install --upgrade pip

echo [OK] pip atualizado!
echo.

:: ============================================
:: PASSO 1.4: Instalar PyTorch com CUDA
:: ============================================

echo [INFO] Instalando PyTorch 2.7.0+cu128...
echo Este processo pode levar 5-10 minutos...
echo.

pip install torch==2.7.0 torchvision==0.22.0 torchaudio==2.7.0 --index-url https://download.pytorch.org/whl/cu128

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao instalar PyTorch!
    echo.
    pause
    exit /b 1
)

echo [OK] PyTorch instalado com sucesso!
echo.

:: ============================================
:: PASSO 2: Verificar VS Build Tools
:: ============================================

:check_buildtools

echo [2/5] Verificando Visual Studio Build Tools...
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
    echo Ou verifique se voce reiniciou o computador apos instalar.
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
:: PASSO 3: Garantir que o venv está ativado
:: ============================================

echo [3/5] Ativando ambiente virtual...
echo.

call .venv311\Scripts\activate.bat

if errorlevel 1 (
    color 0C
    echo [ERRO] Falha ao ativar ambiente virtual!
    echo.
    pause
    exit /b 1
)

:: Verificar Python do venv
where python | findstr "venv311" >nul 2>&1
if errorlevel 1 (
    color 0E
    echo [AVISO] Python do venv pode nao estar ativo!
    echo Tentando continuar...
)

echo [OK] Ambiente virtual ativado!
echo.

:: ============================================
:: PASSO 4: Instalar torch_scatter
:: ============================================

echo [4/5] Instalando torch_scatter...
echo.
echo Este processo pode levar 5-15 minutos e inclui compilacao C++/CUDA.
echo Aguarde...
echo.

:: Definir variáveis de compilação
set MAX_JOBS=4
set FORCE_CUDA=1

:: Instalar torch_scatter
python -m pip install torch-scatter -f https://data.pyg.org/whl/torch-2.7.0+cu128.html

if errorlevel 1 (
    color 0E
    echo.
    echo [AVISO] Instalacao via PyG falhou. Tentando compilar do source...
    echo.

    :: Tentar instalar do GitHub
    pip install git+https://github.com/rusty1s/pytorch_scatter.git

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
:: PASSO 5: Verificar instalação
:: ============================================

echo [5/5] Verificando instalacao...
echo.

python -c "import torch; print(f'PyTorch {torch.__version__} com CUDA {torch.version.cuda}')"

if errorlevel 1 (
    color 0C
    echo [ERRO] PyTorch nao pode ser importado!
    pause
    exit /b 1
)

echo.

python -c "import torch_scatter; print(f'torch_scatter {torch_scatter.__version__} instalado com sucesso!')"

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
echo PyTorch: 2.7.0+cu128
echo torch_scatter: Instalado
echo.
echo Proximo passo:
echo   Execute: RUN_INSTALL_3DPACK.bat
echo   (para instalar ComfyUI-3D-Pack completo)
echo.
echo ========================================================================
echo.

pause

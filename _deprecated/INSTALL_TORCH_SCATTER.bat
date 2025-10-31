@echo off
title AIEXX - torch_scatter Installer
color 0A

echo.
echo ========================================================================
echo   AIEXX - torch_scatter Installation
echo ========================================================================
echo.

cd /d "%~dp0"

echo [1/3] Verificando e configurando Visual Studio Build Tools...
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
    echo Caminhos verificados:
    echo   - vswhere.exe
    echo   - Program Files\Microsoft Visual Studio\2022\BuildTools
    echo   - Program Files ^(x86^)\Microsoft Visual Studio\2022\BuildTools
    echo   - Program Files\Microsoft Visual Studio\2022\Community
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

echo [2/3] Instalando torch_scatter...
echo.
echo Este processo pode levar 5-15 minutos e inclui compilacao C++/CUDA.
echo Aguarde...
echo.

:: Ativar ambiente
call .venv311\Scripts\activate.bat

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
echo [3/3] Verificando instalacao...

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
echo Proximo passo:
echo   Execute: RUN_INSTALL_3DPACK.bat
echo   (para reinstalar ComfyUI-3D-Pack com todas as dependencias)
echo.
echo ========================================================================
echo.

pause

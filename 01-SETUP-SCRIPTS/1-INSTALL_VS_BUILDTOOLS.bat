@echo off
chcp 65001 >nul 2>&1
title AIEXX - Visual Studio Build Tools Installer
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
echo   Visual Studio Build Tools 2022 Installer
echo.
echo ========================================================================
echo.
echo Este script ira:
echo   1. Baixar VS Build Tools 2022
echo   2. Instalar componentes C++ necessarios
echo   3. Configurar para compilacao CUDA
echo.
echo Tempo estimado: 10-20 minutos
echo Espaco necessario: ~7 GB
echo.
echo ========================================================================
echo.

pause

echo.
echo [1/4] Baixando Visual Studio Build Tools...
echo.

:: Baixar usando PowerShell
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vs_buildtools.exe' -OutFile '%TEMP%\vs_buildtools.exe'}"

if not exist "%TEMP%\vs_buildtools.exe" (
    color 0C
    echo.
    echo [ERRO] Falha ao baixar VS Build Tools!
    echo.
    echo Baixe manualmente de:
    echo https://aka.ms/vs/17/release/vs_buildtools.exe
    echo.
    pause
    exit /b 1
)

echo [OK] Download concluido!

echo.
echo [2/4] Instalando Visual Studio Build Tools 2022...
echo.
echo IMPORTANTE:
echo - Esta janela pode ficar sem resposta durante a instalacao
echo - Aguarde ate que apareca a mensagem "[OK] Instalacao concluida!"
echo - NAO FECHE esta janela!
echo.
pause

:: Instalar com componentes C++ e Windows SDK
"%TEMP%\vs_buildtools.exe" --wait --passive --norestart ^
    --add Microsoft.VisualStudio.Workload.VCTools ^
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
    --add Microsoft.VisualStudio.Component.Windows11SDK.22621 ^
    --add Microsoft.VisualStudio.Component.VC.CMake.Project ^
    --add Microsoft.VisualStudio.Component.VC.CoreBuildTools ^
    --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest ^
    --includeRecommended

if errorlevel 3010 (
    echo.
    echo [AVISO] Instalacao concluida, mas requer reinicializacao!
    goto :success
)

if errorlevel 1 (
    color 0C
    echo.
    echo [ERRO] Instalacao falhou!
    echo.
    echo Tente instalar manualmente:
    echo 1. Execute: %TEMP%\vs_buildtools.exe
    echo 2. Selecione: "Desktop development with C++"
    echo 3. Certifique-se de incluir:
    echo    - MSVC v143
    echo    - Windows 11 SDK
    echo    - CMake tools
    echo.
    pause
    exit /b 1
)

:success
echo.
echo [3/4] Verificando instalacao...
timeout /t 2 >nul

:: Verificar se cl.exe existe
where cl.exe >nul 2>&1
if errorlevel 1 (
    :: Tentar encontrar no caminho padrao
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\*\bin\Hostx64\x64\cl.exe" (
        echo [OK] Compilador C++ encontrado!
    ) else (
        color 0E
        echo [AVISO] Compilador nao encontrado no PATH
        echo Pode ser necessario reiniciar o computador
    )
) else (
    echo [OK] Compilador C++ encontrado no PATH!
)

echo.
echo [4/4] Limpando arquivos temporarios...
del /q "%TEMP%\vs_buildtools.exe" 2>nul
echo [OK] Limpeza concluida!

echo.
echo ========================================================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo ========================================================================
echo.
echo Proximos passos:
echo.
echo 1. REINICIE O COMPUTADOR (altamente recomendado)
echo    ou
echo    Feche todos os terminais e abra um novo terminal
echo.
echo 2. Execute: RUN_INSTALL_3DPACK.bat
echo    (para instalar torch_scatter e ComfyUI-3D-Pack)
echo.
echo 3. Inicie o sistema: START_AIEXX.bat
echo.
echo ========================================================================
echo.

pause

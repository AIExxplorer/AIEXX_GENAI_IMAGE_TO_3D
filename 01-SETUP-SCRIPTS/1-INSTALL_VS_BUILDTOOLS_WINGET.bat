@echo off
chcp 65001 >nul 2>&1
title AIEXX - Visual Studio Build Tools Quick Install (winget)
color 0A

echo.
echo ========================================================================
echo   AIEXX - VS Build Tools 2022 - Instalacao Rapida (winget)
echo ========================================================================
echo.

:: Verificar winget
where winget >nul 2>&1
if errorlevel 1 (
    color 0C
    echo [ERRO] winget nao encontrado!
    echo.
    echo Use o instalador padrao: INSTALL_VS_BUILDTOOLS.bat
    echo.
    pause
    exit /b 1
)

echo [OK] winget encontrado!
echo.
echo Este metodo e MAIS RAPIDO e usa o Windows Package Manager.
echo.
echo Instalando Visual Studio Build Tools 2022 com componentes C++...
echo Tempo estimado: 10-15 minutos
echo.
pause

:: Instalar via winget
winget install Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22621 --add Microsoft.VisualStudio.Component.VC.CMake.Project --includeRecommended"

if errorlevel 1 (
    color 0C
    echo.
    echo [ERRO] Instalacao falhou!
    echo.
    echo Tente o instalador manual: INSTALL_VS_BUILDTOOLS.bat
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================================================
echo   INSTALACAO CONCLUIDA!
echo ========================================================================
echo.
echo IMPORTANTE: REINICIE O COMPUTADOR
echo.
echo Apos reiniciar, execute:
echo   INSTALL_TORCH_SCATTER.bat
echo.
pause

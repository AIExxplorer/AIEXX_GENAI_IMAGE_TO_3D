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
echo   AIEXX GenAI - Image to 3D Converter
echo.
echo ========================================================================
echo.

REM Verificar se foi fornecida uma imagem
if "%~1"=="" (
    echo [ERRO] Nenhuma imagem fornecida!
    echo.
    echo Uso:
    echo   AIEXX_IMAGE_TO_3D.bat ^<imagem^> [saida]
    echo.
    echo Exemplos:
    echo   AIEXX_IMAGE_TO_3D.bat minha_foto.png
    echo   AIEXX_IMAGE_TO_3D.bat foto.jpg modelo3d.obj
    echo   AIEXX_IMAGE_TO_3D.bat input.png output.glb
    echo.
    echo OU arraste e solte uma imagem sobre este arquivo!
    echo.
    pause
    exit /b 1
)

echo [INFO] Iniciando conversao de imagem para 3D...
echo.

REM Executar o script Python
.venv311\Scripts\python.exe 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py %*

echo.
echo ========================================================================
echo.
pause

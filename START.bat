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
echo   AIEXX GenAI - Iniciando Sistema
echo.
echo ========================================================================
echo.

cd ComfyUI
start "AIEXX ComfyUI Server" ..\.venv311\Scripts\python.exe main.py --listen 0.0.0.0 --port 8188 --highvram --preview-method auto

echo Aguardando servidor iniciar...
ping 127.0.0.1 -n 8 >nul

start http://localhost:8188

cls
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   SISTEMA RODANDO!
echo.
echo ========================================================================
echo   URL: http://localhost:8188
echo   GPU: NVIDIA RTX 5060 Laptop - HIGHVRAM Mode
echo ========================================================================
echo.
pause

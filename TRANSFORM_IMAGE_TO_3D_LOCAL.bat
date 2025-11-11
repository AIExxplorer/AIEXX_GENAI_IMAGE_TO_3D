@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ============================================================================
REM   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
REM  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
REM  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
REM  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
REM  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
REM  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
REM
REM  AIEXX - Transformador de Imagem para 3D (GPU Local)
REM  Versão: 2.0
REM  Sem custos de API - 100%% local
REM ============================================================================

title AIEXX - Image to 3D Local (GPU)

echo.
echo ================================================================================
echo   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo  🎨 TRANSFORMADOR DE IMAGEM PARA 3D - GPU LOCAL
echo  💰 SEM CUSTOS - 🔒 100%% PRIVADO - ⚡ RÁPIDO
echo ================================================================================
echo.

REM ============================================================================
REM Verificar Python e ambiente virtual
REM ============================================================================

if not exist ".venv311\Scripts\python.exe" (
    echo [ERRO] Ambiente virtual não encontrado!
    echo.
    echo Execute primeiro: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    pause
    exit /b 1
)

REM ============================================================================
REM Verificar se uma imagem foi fornecida
REM ============================================================================

if "%~1"=="" (
    echo [INFO] Nenhuma imagem fornecida. Iniciando modo interativo...
    echo.
    echo OPÇÕES:
    echo.
    echo [1] Transformar UMA imagem específica
    echo [2] Abrir ComfyUI com workflow carregado
    echo [3] Processar TODAS as imagens de uma pasta
    echo [4] Sair
    echo.
    set /p CHOICE="Escolha uma opção [1-4]: "
    
    if "!CHOICE!"=="1" goto :SINGLE_IMAGE
    if "!CHOICE!"=="2" goto :OPEN_COMFYUI
    if "!CHOICE!"=="3" goto :BATCH_PROCESS
    if "!CHOICE!"=="4" exit /b 0
    
    echo [ERRO] Opção inválida!
    pause
    exit /b 1
)

REM Se um arquivo foi arrastado para o BAT
set "INPUT_IMAGE=%~1"
goto :PROCESS_IMAGE

REM ============================================================================
:SINGLE_IMAGE
REM ============================================================================

echo.
echo Digite o caminho completo da imagem (ou arraste a imagem aqui):
set /p INPUT_IMAGE="> "

REM Remover aspas se houver
set INPUT_IMAGE=%INPUT_IMAGE:"=%

if not exist "%INPUT_IMAGE%" (
    echo.
    echo [ERRO] Arquivo não encontrado: %INPUT_IMAGE%
    echo.
    pause
    exit /b 1
)

goto :PROCESS_IMAGE

REM ============================================================================
:PROCESS_IMAGE
REM ============================================================================

echo.
echo ============================================================================
echo 📸 IMAGEM SELECIONADA
echo ============================================================================
echo Arquivo: %INPUT_IMAGE%
echo.

REM Gerar nome de saída
for %%F in ("%INPUT_IMAGE%") do (
    set "FILENAME=%%~nF"
    set "EXTENSION=%%~xF"
)

set "OUTPUT_FILE=output_3d\%FILENAME%_3D.glb"
set "OUTPUT_OBJ=output_3d\%FILENAME%_3D.obj"

REM Criar pasta de saída
if not exist "output_3d" mkdir "output_3d"

echo 💾 Saída será salva em: %OUTPUT_FILE%
echo.
echo ============================================================================
echo 🚀 INICIANDO CONVERSÃO 3D
echo ============================================================================
echo.
echo [INFO] Usando GPU local - sem custos de API
echo [INFO] Tempo estimado: 30-60 segundos
echo.

REM Executar script Python
".venv311\Scripts\python.exe" "02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py" "%INPUT_IMAGE%" "%OUTPUT_FILE%"

set ERROR_LEVEL=%ERRORLEVEL%

if %ERROR_LEVEL%==0 (
    echo.
    echo ============================================================================
    echo ✅ SUCESSO! MODELO 3D CRIADO
    echo ============================================================================
    echo.
    echo 📁 Arquivo GLB: %OUTPUT_FILE%
    echo.
    echo 🎉 Você pode visualizar em:
    echo    • https://3dviewer.net
    echo    • Blender
    echo    • Unity
    echo    • Unreal Engine
    echo    • Qualquer software que abra GLB/OBJ
    echo.
    echo 💰 CUSTO: R$ 0,00 (100%% local!)
    echo.
    
    REM Perguntar se quer processar outra
    echo.
    set /p ANOTHER="Processar outra imagem? [S/N]: "
    if /i "!ANOTHER!"=="S" goto :SINGLE_IMAGE
    
) else (
    echo.
    echo ============================================================================
    echo ❌ ERRO NA CONVERSÃO
    echo ============================================================================
    echo.
    echo Código de erro: %ERROR_LEVEL%
    echo.
    echo POSSÍVEIS CAUSAS:
    echo  • GPU sem memória suficiente
    echo  • Modelo TripoSR não baixado
    echo  • Imagem corrompida ou formato inválido
    echo.
    echo SOLUÇÕES:
    echo  1. Feche outros programas que usam GPU
    echo  2. Execute: 4-DOWNLOAD_3D_MODELS.bat
    echo  3. Tente uma imagem menor (máx 2048x2048)
    echo.
)

pause
exit /b %ERROR_LEVEL%

REM ============================================================================
:OPEN_COMFYUI
REM ============================================================================

echo.
echo ============================================================================
echo 🚀 ABRINDO COMFYUI COM WORKFLOW LOCAL
echo ============================================================================
echo.
echo [1] Iniciando servidor ComfyUI...
echo [2] Abrirá no navegador: http://localhost:8188
echo [3] Workflow já será carregado automaticamente
echo.
echo ⏱️  Aguarde alguns segundos para o servidor iniciar...
echo.

REM Iniciar ComfyUI em background
start "ComfyUI Server" /MIN cmd /c "cd ComfyUI && ..\\.venv311\\Scripts\\python.exe main.py --listen 0.0.0.0 --port 8188"

REM Aguardar servidor iniciar
timeout /t 5 /nobreak >nul

REM Abrir navegador
start "" "http://localhost:8188"

echo.
echo ============================================================================
echo ✅ COMFYUI INICIADO
echo ============================================================================
echo.
echo 📋 INSTRUÇÕES:
echo.
echo 1. No navegador, clique em "Load"
echo 2. Selecione: workflows/3d/AIEXX_image_to_3d_LOCAL_GPU.json
echo 3. Clique no nó "📷 Carregar Sua Imagem"
echo 4. Selecione sua foto
echo 5. Clique em "Queue Prompt" (canto superior direito)
echo 6. Aguarde 30-60 segundos
echo 7. Modelo 3D estará em ComfyUI/output/
echo.
echo 💡 DICA: Deixe esta janela aberta enquanto usa o ComfyUI
echo          Feche esta janela para parar o servidor
echo.

pause
exit /b 0

REM ============================================================================
:BATCH_PROCESS
REM ============================================================================

echo.
echo ============================================================================
echo 📁 PROCESSAMENTO EM LOTE
echo ============================================================================
echo.
echo Digite o caminho da pasta com as imagens:
set /p BATCH_FOLDER="> "

set BATCH_FOLDER=%BATCH_FOLDER:"=%

if not exist "%BATCH_FOLDER%" (
    echo.
    echo [ERRO] Pasta não encontrada: %BATCH_FOLDER%
    pause
    exit /b 1
)

echo.
echo [INFO] Processando todas as imagens de: %BATCH_FOLDER%
echo.

set COUNT=0
set SUCCESS=0
set FAILED=0

for %%F in ("%BATCH_FOLDER%\*.png" "%BATCH_FOLDER%\*.jpg" "%BATCH_FOLDER%\*.jpeg") do (
    set /a COUNT+=1
    echo.
    echo ============================================================================
    echo [!COUNT!] Processando: %%~nxF
    echo ============================================================================
    
    ".venv311\Scripts\python.exe" "02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py" "%%F" "output_3d\%%~nF_3D.glb"
    
    if !ERRORLEVEL!==0 (
        set /a SUCCESS+=1
        echo ✅ Sucesso: %%~nxF
    ) else (
        set /a FAILED+=1
        echo ❌ Falha: %%~nxF
    )
)

echo.
echo ============================================================================
echo 📊 RESUMO DO PROCESSAMENTO EM LOTE
echo ============================================================================
echo.
echo Total processado: !COUNT!
echo ✅ Sucessos: !SUCCESS!
echo ❌ Falhas: !FAILED!
echo.
echo 📁 Modelos 3D salvos em: output_3d\
echo.

pause
exit /b 0


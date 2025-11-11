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
REM  AIEXX - ComfyUI com Workflow LOCAL GPU
REM  Versão: 2.0
REM ============================================================================

title AIEXX - ComfyUI Local GPU Workflow

echo.
echo ================================================================================
echo   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo  🎨 COMFYUI + WORKFLOW LOCAL GPU
echo  💰 SEM CUSTOS - 🔒 100%% PRIVADO
echo ================================================================================
echo.

REM Voltar para diretório raiz do projeto
cd /d "%~dp0.."

REM Verificar ambiente
if not exist ".venv311\Scripts\python.exe" (
    echo [ERRO] Ambiente virtual não encontrado!
    echo.
    echo Execute primeiro: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
    echo.
    pause
    exit /b 1
)

REM Verificar ComfyUI
if not exist "ComfyUI\main.py" (
    echo [ERRO] ComfyUI não encontrado!
    echo.
    echo Verifique a instalação.
    pause
    exit /b 1
)

echo [1/4] Preparando ambiente...
echo.

REM Copiar workflow para pasta de workflows do ComfyUI (se necessário)
if not exist "ComfyUI\user\default\workflows\" mkdir "ComfyUI\user\default\workflows\"
copy /Y "workflows\3d\AIEXX_image_to_3d_LOCAL_GPU.json" "ComfyUI\user\default\workflows\" >nul 2>&1

echo [2/4] Iniciando servidor ComfyUI...
echo.
echo 🌐 URL: http://localhost:8188
echo.
echo ⏱️  Aguarde alguns segundos para o servidor iniciar...
echo.

REM Iniciar ComfyUI
cd ComfyUI

start "AIEXX ComfyUI Server" cmd /c ^"..\.venv311\Scripts\python.exe main.py --listen 0.0.0.0 --port 8188 ^& pause^"

cd ..

echo [3/4] Aguardando servidor...
timeout /t 8 /nobreak >nul

echo.
echo [4/4] Abrindo navegador...
echo.

REM Abrir navegador com URL do workflow
start "" "http://localhost:8188"

timeout /t 2 /nobreak >nul

echo.
echo ================================================================================
echo ✅ COMFYUI INICIADO COM SUCESSO
echo ================================================================================
echo.
echo 📋 PRÓXIMOS PASSOS:
echo.
echo 1. No navegador, clique em "Load" (canto superior)
echo 2. Selecione: AIEXX_image_to_3d_LOCAL_GPU.json
echo 3. Clique no nó "📷 Carregar Sua Imagem"
echo 4. Selecione uma foto da pasta: MINHAS_IMAGENS_TESTE
echo 5. Clique em "Queue Prompt" (botão laranja no topo)
echo 6. Aguarde 30-60 segundos
echo 7. Modelo 3D estará em: ComfyUI\output\
echo.
echo ================================================================================
echo 💡 DICAS
echo ================================================================================
echo.
echo • Use fotos com fundo limpo para melhores resultados
echo • Resolução ideal: 512x512 até 2048x2048
echo • Objetos/pessoas centralizadas na imagem
echo.
echo • Para ALTA QUALIDADE: Resolution = 512
echo • Para VELOCIDADE: Resolution = 256
echo.
echo • Formato de saída: GLB (universal)
echo • Abra em: Blender, Unity, Unreal, 3DViewer.net
echo.
echo ================================================================================
echo 🖥️  CONTROLE DO SERVIDOR
echo ================================================================================
echo.
echo • Servidor rodando em: http://localhost:8188
echo • Para PARAR: Feche a janela "AIEXX ComfyUI Server"
echo • Logs: Visíveis na janela do servidor
echo.
echo 💰 CUSTO: R$ 0,00 - 100%% Local, sem API!
echo.
echo ================================================================================
echo.
echo Pressione qualquer tecla para abrir o navegador novamente...
pause >nul

start "" "http://localhost:8188"

echo.
echo Navegador aberto. Você pode fechar esta janela.
echo O servidor continuará rodando na outra janela.
echo.

timeout /t 5 >nul
exit /b 0


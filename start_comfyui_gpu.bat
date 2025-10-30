@echo off
REM ============================================
REM AIEXX GenAI Image to 3D - ComfyUI Launcher
REM GPU: NVIDIA GeForce RTX 5060 (CUDA)
REM ============================================

echo.
echo ========================================
echo  AIEXX GenAI Image to 3D
echo  Iniciando ComfyUI com GPU NVIDIA
echo ========================================
echo.

REM Verificar se está no diretório correto
if not exist "ComfyUI\main.py" (
    echo [ERRO] ComfyUI nao encontrado!
    echo Certifique-se de estar no diretorio: C:\ComfyUI
    pause
    exit /b 1
)

REM Configurar variáveis de ambiente para CUDA
set CUDA_VISIBLE_DEVICES=0
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512
set COMMANDLINE_ARGS=--preview-method auto --use-pytorch-cross-attention

REM Ativar ambiente virtual (se existir)
if exist ".venv311\Scripts\activate.bat" (
    echo [INFO] Ativando ambiente virtual...
    call .venv311\Scripts\activate.bat
)

REM Mudar para diretório do ComfyUI
cd ComfyUI

echo.
echo [INFO] GPU: NVIDIA GeForce RTX 5060
echo [INFO] Modo: CUDA (otimizado)
echo [INFO] Porta: 8188
echo [INFO] Acesso: http://localhost:8188
echo.
echo [INFO] Pressione Ctrl+C para parar o servidor
echo.
echo ========================================
echo  Iniciando...
echo ========================================
echo.

REM Iniciar ComfyUI com otimizações CUDA
python main.py ^
    --listen 0.0.0.0 ^
    --port 8188 ^
    --preview-method auto ^
    --use-pytorch-cross-attention ^
    --highvram ^
    --bf16-unet

REM Se houver erro, pausar para ver a mensagem
if errorlevel 1 (
    echo.
    echo [ERRO] ComfyUI encerrou com erro!
    pause
)


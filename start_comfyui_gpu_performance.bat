@echo off
REM ============================================
REM AIEXX GenAI Image to 3D - Performance Mode
REM GPU: NVIDIA GeForce RTX 5060 (CUDA)
REM Modo: Performance Máximo (requer mais VRAM)
REM ============================================

echo.
echo ========================================
echo  AIEXX GenAI Image to 3D
echo  Modo: PERFORMANCE MAXIMO
echo  GPU: NVIDIA RTX 5060
echo ========================================
echo.

REM Verificar se está no diretório correto
if not exist "ComfyUI\main.py" (
    echo [ERRO] ComfyUI nao encontrado!
    pause
    exit /b 1
)

REM Configurar variáveis de ambiente para máximo desempenho
set CUDA_VISIBLE_DEVICES=0
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:1024,garbage_collection_threshold:0.9
set CUBLAS_WORKSPACE_CONFIG=:4096:8
set PYTORCH_NO_CUDA_MEMORY_CACHING=0

REM Ativar ambiente virtual (se existir)
if exist ".venv311\Scripts\activate.bat" (
    call .venv311\Scripts\activate.bat
)

cd ComfyUI

echo.
echo [INFO] Modo: PERFORMANCE MAXIMO
echo [INFO] VRAM: Uso alto (recomendado para RTX 5060)
echo [INFO] Otimizacoes: xformers + flash attention
echo [INFO] Porta: 8188
echo [INFO] URL: http://localhost:8188
echo.
echo ========================================
echo  Iniciando...
echo ========================================
echo.

REM Máximo desempenho com todas as otimizações
python main.py ^
    --listen 0.0.0.0 ^
    --port 8188 ^
    --preview-method auto ^
    --use-pytorch-cross-attention ^
    --disable-xformers ^
    --bf16-unet ^
    --fp16-vae ^
    --highvram ^
    --reserve-vram 1.0

if errorlevel 1 (
    echo.
    echo [ERRO] ComfyUI encerrou com erro!
    echo Tente o modo balanceado: start_comfyui_gpu.bat
    pause
)


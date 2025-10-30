@echo off
REM ============================================
REM AIEXX GenAI Image to 3D - Low VRAM Mode
REM GPU: NVIDIA GeForce RTX 5060 (CUDA)
REM Modo: Economia de VRAM (para modelos grandes)
REM ============================================

echo.
echo ========================================
echo  AIEXX GenAI Image to 3D
echo  Modo: ECONOMIA DE VRAM
echo  GPU: NVIDIA RTX 5060
echo ========================================
echo.

if not exist "ComfyUI\main.py" (
    echo [ERRO] ComfyUI nao encontrado!
    pause
    exit /b 1
)

REM Configurar para economia de VRAM
set CUDA_VISIBLE_DEVICES=0
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:256

if exist ".venv311\Scripts\activate.bat" (
    call .venv311\Scripts\activate.bat
)

cd ComfyUI

echo.
echo [INFO] Modo: ECONOMIA DE VRAM
echo [INFO] Ideal para: Modelos grandes ou multitarefa
echo [INFO] Velocidade: Mais lento, mas estavel
echo [INFO] Porta: 8188
echo.
echo ========================================
echo  Iniciando...
echo ========================================
echo.

REM Modo economia de VRAM
python main.py ^
    --listen 0.0.0.0 ^
    --port 8188 ^
    --preview-method auto ^
    --lowvram ^
    --use-split-cross-attention ^
    --bf16-unet

if errorlevel 1 (
    echo.
    echo [ERRO] ComfyUI encerrou com erro!
    pause
)


@echo off
REM ============================================
REM AIEXX GenAI Image to 3D - ComfyUI Launcher
REM GPU: NVIDIA GeForce RTX 5060 (CUDA)
REM Versao: CORRIGIDA (sem erros)
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

REM Verificar PyTorch CUDA
echo [INFO] Verificando PyTorch CUDA...
python -c "import torch; exit(0 if torch.cuda.is_available() else 1)" 2>nul

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ========================================
    echo  [AVISO] PyTorch sem suporte CUDA!
    echo ========================================
    echo.
    echo O PyTorch instalado NAO tem suporte a CUDA.
    echo Sua GPU NVIDIA nao sera utilizada!
    echo.
    echo Deseja instalar PyTorch com CUDA agora? [S/N]
    echo.
    set /p install_cuda="Digite S para instalar ou N para continuar sem CUDA: "
    
    if /i "%install_cuda%"=="S" (
        echo.
        echo [INFO] Instalando PyTorch com CUDA...
        call install_pytorch_cuda.bat
        echo.
        echo Reinicie este script apos a instalacao.
        pause
        exit /b 0
    ) else (
        echo.
        echo [AVISO] Continuando sem CUDA (CPU mode)...
        echo Performance sera MUITO mais lenta!
        timeout /t 3
    )
)

REM Configurar variáveis de ambiente para CUDA
set CUDA_VISIBLE_DEVICES=0
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

REM Ativar ambiente virtual (se existir)
if exist ".venv311\Scripts\activate.bat" (
    echo [INFO] Ativando ambiente virtual...
    call .venv311\Scripts\activate.bat
)

REM Mudar para diretório do ComfyUI
cd ComfyUI

echo.
echo [INFO] GPU: NVIDIA GeForce RTX 5060
echo [INFO] Porta: 8188
echo [INFO] Acesso: http://localhost:8188
echo.
echo [INFO] Pressione Ctrl+C para parar o servidor
echo.
echo ========================================
echo  Iniciando ComfyUI...
echo ========================================
echo.

REM Iniciar ComfyUI com otimizações CUDA (se disponível)
python main.py --listen 0.0.0.0 --port 8188 --preview-method auto

REM Se houver erro, pausar para ver a mensagem
if errorlevel 1 (
    cd ..
    echo.
    echo ========================================
    echo  [ERRO] ComfyUI encerrou com erro!
    echo ========================================
    echo.
    echo Possíveis solucoes:
    echo 1. Instale PyTorch com CUDA: install_pytorch_cuda.bat
    echo 2. Tente modo CPU: python main.py --cpu
    echo 3. Verifique logs acima para mais detalhes
    echo.
    pause
)

cd ..


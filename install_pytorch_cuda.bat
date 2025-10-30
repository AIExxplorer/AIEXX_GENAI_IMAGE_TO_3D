@echo off
REM ============================================
REM AIEXX GenAI Image to 3D
REM Instalacao PyTorch com CUDA para RTX 5060
REM ============================================

echo.
echo ========================================
echo  Instalando PyTorch com CUDA
echo  GPU: NVIDIA RTX 5060
echo ========================================
echo.

REM Ativar ambiente virtual
if exist ".venv311\Scripts\activate.bat" (
    echo [INFO] Ativando ambiente virtual...
    call .venv311\Scripts\activate.bat
) else (
    echo [AVISO] Ambiente virtual nao encontrado!
    echo [INFO] Usando Python global...
)

echo.
echo [INFO] Desinstalando versao atual do PyTorch...
pip uninstall -y torch torchvision torchaudio

echo.
echo [INFO] Instalando PyTorch com CUDA 12.1...
echo [INFO] Isso pode demorar alguns minutos...
echo.

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo.
echo ========================================
echo  Verificando instalacao...
echo ========================================
echo.

python -c "import torch; print('PyTorch:', torch.__version__); print('CUDA Available:', torch.cuda.is_available()); print('CUDA Version:', torch.version.cuda); print('Device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'N/A')"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  [OK] PyTorch com CUDA instalado!
    echo ========================================
    echo.
) else (
    echo.
    echo ========================================
    echo  [ERRO] Falha na instalacao!
    echo ========================================
    echo.
)

pause


# 🔧 Troubleshooting - AIEXX GenAI Image to 3D

Soluções para problemas comuns de inicialização e execução.

---

## ❌ Erro: "Torch not compiled with CUDA enabled"

### Problema
```
AssertionError: Torch not compiled with CUDA enabled
```

### Causa
O PyTorch instalado não tem suporte a CUDA. Sua GPU NVIDIA não está sendo utilizada.

### Solução

#### Opção 1: Script Automático (Recomendado)
```bash
install_pytorch_cuda.bat
```

#### Opção 2: Manual
```bash
# Ativar ambiente virtual
.venv311\Scripts\activate.bat

# Desinstalar PyTorch atual
pip uninstall -y torch torchvision torchaudio

# Instalar PyTorch com CUDA 12.1
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Verificar
python -c "import torch; print('CUDA:', torch.cuda.is_available())"
```

#### Opção 3: Usar CPU (Temporário)
```bash
cd ComfyUI
python main.py --cpu --listen 0.0.0.0 --port 8188
```
⚠️ **Aviso:** Modo CPU é MUITO mais lento!

---

## ❌ Erro: "InvalidVariableReferenceWithDrive" no PowerShell

### Problema
```
No C:\ComfyUI\monitor_status.ps1:74 caractere:21
+ Write-Host "$modelName:" -ForegroundColor Yellow
```

### Causa
PowerShell interpreta `$m` como variável.

### Solução
✅ **Já corrigido!** Use a versão atualizada:
```powershell
git pull origin main
```

Ou execute:
```powershell
.\check_gpu.ps1
```

---

## ❌ ComfyUI não inicia

### Problema
ComfyUI fecha imediatamente ou não inicia.

### Soluções

#### 1. Verificar GPU
```bash
.\check_gpu.ps1
```

#### 2. Usar Launcher Corrigido
```bash
start_comfyui_gpu_fixed.bat
```

Este launcher:
- ✅ Detecta automaticamente se CUDA está disponível
- ✅ Oferece instalar PyTorch com CUDA
- ✅ Continua em modo CPU se necessário
- ✅ Mostra erros detalhados

#### 3. Verificar Dependências
```bash
cd ComfyUI
python -c "import torch, numpy, PIL; print('OK')"
```

#### 4. Modo Seguro (CPU)
```bash
cd ComfyUI
python main.py --cpu --listen 0.0.0.0 --port 8188
```

---

## ❌ Erro: "Out of Memory" (VRAM)

### Problema
```
RuntimeError: CUDA out of memory
```

### Soluções

#### 1. Usar Modo Economia de VRAM
```bash
start_comfyui_gpu_lowvram.bat
```

#### 2. Fechar Outras Aplicações
- Navegadores (desabilite aceleração por hardware)
- Jogos
- Outras aplicações que usam GPU

#### 3. Reduzir Batch Size
No workflow do ComfyUI, reduza:
- Batch size para 1
- Resolução de saída
- Número de steps

---

## ❌ ComfyUI muito lento

### Problema
Processamento demora muito tempo.

### Soluções

#### 1. Verificar se GPU está sendo usada
```bash
# Abrir outro terminal
nvidia-smi
```

Deve mostrar:
- Processo `python.exe`
- Uso de VRAM
- GPU Utilization > 0%

#### 2. Instalar PyTorch com CUDA
```bash
install_pytorch_cuda.bat
```

#### 3. Usar Modo Performance
```bash
start_comfyui_gpu_performance.bat
```

#### 4. Verificar Energia (Laptop)
- Conecte na tomada
- Configure "Alto desempenho" no Windows
- Verifique se modo de economia de bateria está DESLIGADO

---

## ❌ Erro: "Module not found"

### Problema
```
ModuleNotFoundError: No module named 'xyz'
```

### Solução

#### Para ComfyUI
```bash
cd ComfyUI
pip install -r requirements.txt
```

#### Para Custom Nodes
```bash
cd ComfyUI\custom_nodes\[nome-do-node]
pip install -r requirements.txt
```

#### Reinstalar Tudo
```bash
pip install --upgrade --force-reinstall -r requirements.txt
```

---

## ❌ Porta 8188 já em uso

### Problema
```
OSError: [Errno 98] Address already in use
```

### Soluções

#### 1. Matar Processo Anterior
```bash
# Encontrar processo
netstat -ano | findstr :8188

# Matar (substitua PID)
taskkill /PID [numero] /F
```

#### 2. Usar Outra Porta
```bash
cd ComfyUI
python main.py --listen 0.0.0.0 --port 8189
```

Acesse: http://localhost:8189

---

## ❌ Modelos não encontrados

### Problema
ComfyUI não encontra os modelos baixados.

### Solução

#### 1. Verificar Modelos
```powershell
.\monitor_status.ps1 -Models
```

#### 2. Redownload (se necessário)
```bash
python download_models.py
```

#### 3. Verificar Caminhos
Modelos devem estar em:
```
C:\ComfyUI\ComfyUI\models\
├── controlnet\
├── zero123\
├── triposr\
└── instantmesh\
```

---

## ❌ Workflows não carregam

### Problema
Erro ao carregar arquivo `.json` do workflow.

### Soluções

#### 1. Verificar Formato JSON
Abra o arquivo em editor de texto e verifique se é JSON válido.

#### 2. Usar Workflows Atualizados
```bash
git pull origin main
```

#### 3. Instalar Custom Nodes Necessários
```bash
cd ComfyUI\custom_nodes

# ComfyUI-3D-Pack
git clone https://github.com/MrForExample/ComfyUI-3D-Pack
cd ComfyUI-3D-Pack
pip install -r requirements.txt
cd ..

# ComfyUI ControlNet Aux
git clone https://github.com/Fannovel16/comfyui_controlnet_aux
cd comfyui_controlnet_aux
pip install -r requirements.txt
cd ..

# ComfyUI Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager
```

---

## ✅ Verificação Completa do Sistema

Execute este checklist:

```bash
# 1. Verificar GPU
.\check_gpu.ps1

# 2. Verificar modelos
.\monitor_status.ps1 -Models

# 3. Verificar PyTorch CUDA
python -c "import torch; print('CUDA:', torch.cuda.is_available(), 'Device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'N/A')"

# 4. Verificar ComfyUI
cd ComfyUI
python main.py --help

# 5. Iniciar com launcher corrigido
cd ..
start_comfyui_gpu_fixed.bat
```

---

## 📚 Logs e Diagnóstico

### Verificar Logs
```bash
# Log do ComfyUI
type ComfyUI\comfyui.log

# Log de downloads
type downloads_status.log
```

### Diagnóstico Completo
```powershell
# Criar arquivo de diagnóstico
@"
=== Sistema ===
$(Get-ComputerInfo | Select-Object WindowsVersion, OsArchitecture, CsProcessors)

=== GPU ===
$(Get-WmiObject Win32_VideoController | Select-Object Name, DriverVersion, AdapterRAM)

=== Python ===
$(python --version)
$(pip list | findstr torch)

=== CUDA ===
$(python -c "import torch; print(torch.cuda.is_available())")

=== Modelos ===
$(Get-ChildItem ComfyUI\models -Recurse -File | Measure-Object -Property Length -Sum)
"@ | Out-File diagnostico.txt

notepad diagnostico.txt
```

---

## 🆘 Suporte

Se os problemas persistirem:

1. **Verifique documentação:**
   - [README.md](README.md)
   - [QUICKSTART.md](QUICKSTART.md)
   - [CHECKLIST.md](CHECKLIST.md)

2. **Gere diagnóstico:**
   ```bash
   .\check_gpu.ps1 > diagnostico.txt
   .\monitor_status.ps1 -Models >> diagnostico.txt
   ```

3. **Issues no GitHub:**
   - https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/issues

---

## 🔄 Reset Completo (Último Recurso)

Se tudo falhar:

```bash
# 1. Backup de modelos
xcopy /E /I ComfyUI\models models_backup

# 2. Reinstalar PyTorch
pip uninstall -y torch torchvision torchaudio
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 3. Reinstalar ComfyUI dependencies
cd ComfyUI
pip install -r requirements.txt

# 4. Restaurar modelos
cd ..
xcopy /E /I models_backup ComfyUI\models

# 5. Testar
start_comfyui_gpu_fixed.bat
```

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**

[⬆ Voltar ao README](README.md)

</div>


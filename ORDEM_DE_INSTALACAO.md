# 📋 ORDEM DE INSTALAÇÃO - AIEXX GenAI Image to 3D

## ✅ Ordem Correta de Execução

Execute os arquivos `.bat` na ordem numérica indicada:

### **1️⃣ Instalar Visual Studio Build Tools**

```batch
1-INSTALL_VS_BUILDTOOLS_WINGET.bat
```

**O que faz:**
- Instala Visual Studio Build Tools 2022 via winget
- Instala compilador C++ (MSVC)
- Instala Windows SDK
- Instala CMake tools

**Tempo:** ~10-15 minutos
**Tamanho:** ~7GB
**⚠️ IMPORTANTE:** Reinicie o computador após esta etapa!

**Alternativa (se winget falhar):**
```batch
1-INSTALL_VS_BUILDTOOLS.bat
```

---

### **2️⃣ Configurar Ambiente Python e torch_scatter**

```batch
2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
```

**O que faz:**
- Cria/corrige ambiente virtual Python (.venv311)
- Instala PyTorch 2.7.0+cu128 (~2.5GB)
- Configura Visual Studio Build Tools
- Compila e instala torch_scatter

**Tempo:** ~15-25 minutos
**Requer:** Visual Studio Build Tools instalado (passo 1)

---

### **3️⃣ Instalar ComfyUI-3D-Pack**

```batch
3-RUN_INSTALL_3DPACK.bat
```

**O que faz:**
- Instala todas as dependências 3D
- Compila extensões CUDA necessárias
- Habilita nodes do TripoSR, InstantMesh, Zero123++
- Instala nvdiffrast, PyTorch3D, kiui, spconv

**Tempo:** ~10-15 minutos
**Requer:** torch_scatter instalado (passo 2)

---

### **4️⃣ Baixar Modelos AI (TripoSR, etc.)**

```batch
4-DOWNLOAD_3D_MODELS.bat
```

**O que faz:**
- Baixa modelo TripoSR (~1.6GB)
- Verifica Stable Diffusion 1.5 (~4.0GB)
- Cria estrutura de pastas de modelos

**Tempo:** ~5-15 minutos (dependendo da internet)
**Tamanho total:** ~5.6GB

---

### **5️⃣ Baixar Modelos Stable Diffusion (Opcional)**

```batch
5-SETUP_SD_MODELS.bat
```

**O que faz:**
- Baixa Stable Diffusion 1.5 (~4.0GB)
- Baixa VAE models
- Baixa CLIP models

**Tempo:** ~5-10 minutos
**Nota:** Execute apenas se não tiver os modelos SD

---

### **6️⃣ Iniciar o Sistema**

```batch
6-START_AIEXX.bat
```

**O que faz:**
- Verifica todos os requisitos
- Detecta GPU CUDA
- Configura otimizações RTX 5060
- Inicia ComfyUI em http://localhost:8188

**Requer:** Todos os passos anteriores concluídos

---

## 🔄 Instalação Rápida (Ordem Completa)

```batch
# Passo 1: VS Build Tools
1-INSTALL_VS_BUILDTOOLS_WINGET.bat
# ⚠️ REINICIE O COMPUTADOR

# Passo 2: Python + torch_scatter
2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat

# Passo 3: ComfyUI 3D Pack
3-RUN_INSTALL_3DPACK.bat

# Passo 4: Baixar modelos
4-DOWNLOAD_3D_MODELS.bat

# Passo 5 (Opcional): Modelos SD
5-SETUP_SD_MODELS.bat

# Passo 6: Iniciar sistema
6-START_AIEXX.bat
```

**Tempo total:** ~40-60 minutos (primeira instalação)

---

## 📁 Arquivos Organizados

| Arquivo | Descrição | Obrigatório |
|---------|-----------|-------------|
| `1-INSTALL_VS_BUILDTOOLS_WINGET.bat` | Instala VS Build Tools (winget) | ✅ Sim |
| `1-INSTALL_VS_BUILDTOOLS.bat` | Instala VS Build Tools (manual) | 🔄 Alternativa |
| `2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat` | Setup Python + torch_scatter | ✅ Sim |
| `3-RUN_INSTALL_3DPACK.bat` | Instala ComfyUI-3D-Pack | ✅ Sim |
| `4-DOWNLOAD_3D_MODELS.bat` | Baixa modelos AI | ✅ Sim |
| `5-SETUP_SD_MODELS.bat` | Baixa modelos SD | ⚠️ Opcional |
| `6-START_AIEXX.bat` | Launcher principal | ✅ Sim |

---

## 🗑️ Arquivos Movidos para `_deprecated/`

Estes arquivos foram movidos pois são versões antigas ou duplicatas:

- ❌ `install_pytorch_cuda.bat` (versão antiga)
- ❌ `install_comfyui_3d_pack.bat` (versão antiga)
- ❌ `INSTALL_TORCH_SCATTER.bat` (substituído por 2-FIX_VENV...)
- ❌ `SETUP_VENV_AND_TORCH_SCATTER.bat` (substituído por 2-FIX_VENV...)
- ❌ `find_vs_buildtools.ps1` (script auxiliar, não mais necessário)
- ❌ `calculate_sizes.ps1` (script auxiliar, não mais necessário)

**Não execute estes arquivos!** Use apenas os numerados (1- a 6-).

---

## ⚠️ Problemas Comuns

### Erro: "Python was not found"

**Causa:** Ambiente virtual não foi ativado corretamente

**Solução:**
```batch
2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
```

### Erro: "cl.exe not found" ou "Build Tools não encontrado"

**Causa:** Visual Studio Build Tools não instalado ou computador não foi reiniciado

**Solução:**
1. Execute: `1-INSTALL_VS_BUILDTOOLS_WINGET.bat`
2. **Reinicie o computador**
3. Execute novamente: `2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat`

### Erro: "CUDA out of memory"

**Causa:** Outros programas usando GPU

**Solução:**
- Feche navegadores, jogos, outros programas
- Reduza configurações no workflow
- Use modo `--lowvram` no launcher

---

## 📊 Requisitos de Sistema

| Componente | Requisito |
|------------|-----------|
| **OS** | Windows 10/11 (64-bit) |
| **GPU** | NVIDIA RTX 5060 (8GB VRAM) |
| **RAM** | 16GB mínimo, 32GB recomendado |
| **Disco** | ~55GB livre |
| **Python** | 3.11.9 |
| **CUDA** | 12.1+ |

---

## 🎯 Após Instalação Completa

1. Execute: `6-START_AIEXX.bat`
2. Acesse: http://localhost:8188
3. Carregue um workflow de `workflows/3d/`
4. Comece a criar modelos 3D!

---

## 📞 Suporte

Se encontrar problemas:
- Verifique: `COMO_USAR.md`
- Leia: `README.md`
- Issues: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/issues

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**
**Optimized for NVIDIA RTX 5060**

</div>

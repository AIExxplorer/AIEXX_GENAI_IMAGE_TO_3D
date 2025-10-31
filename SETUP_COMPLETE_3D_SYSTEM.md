# 🚀 Guia Completo: Instalação do Sistema 3D Completo

## 📋 O Que Falta Instalar

Para ter o sistema **100% funcional** com suporte a **Image to 3D** usando TripoSR, você precisa:

1. ✅ ~~Python 3.11.9~~
2. ✅ ~~PyTorch 2.7.0+cu128~~
3. ✅ ~~CUDA 12.8~~
4. ✅ ~~Stable Diffusion Models~~
5. ❌ **Visual Studio Build Tools 2022** (necessário para compilar extensões C++)
6. ❌ **torch_scatter** (dependência do 3D-Pack)
7. ❌ **ComfyUI-3D-Pack completo** (com TripoSRModelLoader, TripoSRSampler, SaveMesh)
8. ❌ **Modelo TripoSR** (~1.5GB)

---

## 🔧 Processo de Instalação (3 Passos)

### **Passo 1: Instalar Visual Studio Build Tools** ⏱️ ~15 minutos

```batch
INSTALL_VS_BUILDTOOLS.bat
```

**O que faz:**
- Baixa VS Build Tools 2022 (~3MB installer)
- Instala componentes C++:
  - MSVC v143 (compilador C++)
  - Windows 11 SDK
  - CMake tools
- Total: ~7GB instalado

**Após instalação:**
⚠️ **REINICIE O COMPUTADOR** (necessário!)

---

### **Passo 2: Instalar torch_scatter** ⏱️ ~10 minutos

```batch
INSTALL_TORCH_SCATTER.bat
```

**O que faz:**
- Verifica se Build Tools está instalado
- Compila torch_scatter compatível com PyTorch 2.7.0+cu128
- Testa a importação

---

### **Passo 3: Reinstalar ComfyUI-3D-Pack** ⏱️ ~15 minutos

```batch
RUN_INSTALL_3DPACK.bat
```

**O que faz:**
- Instala **TODOS** os pacotes 3D:
  - nvdiffrast ✅
  - diff-gaussian-rasterization
  - simple-knn
  - pytorch3d
  - kiui ✅
  - spconv ✅
  - torch_scatter ✅
- Baixa wheels pré-compilados quando disponível
- Compila extensões CUDA necessárias

**Resultado:**
✅ Nodes do TripoSR aparecerão no ComfyUI:
- `TripoSRModelLoader`
- `TripoSRSampler`
- `SaveMesh`

---

## 📥 Baixar Modelo TripoSR

Após instalar o 3D-Pack, baixe o modelo TripoSR:

### Opção 1: Download Automático (quando carregar workflow)
- ComfyUI-Manager irá detectar e oferecer download automático

### Opção 2: Download Manual

```batch
cd ComfyUI\models\checkpoints\triposr
```

Baixe de: https://huggingface.co/stabilityai/TripoSR/tree/main

Arquivo necessário:
- `model.ckpt` (~1.5GB)

Coloque em: `ComfyUI\models\checkpoints\triposr\model.ckpt`

---

## 🎨 Workflows Disponíveis

### 1. **Image to 3D (TripoSR)** ⭐ Recomendado
**Arquivo:** `workflows/3d/03_triposr_single_image_to_mesh.json`

**Funcionalidade:**
- 📷 **Input**: Imagem única (PNG, JPG)
- 🎯 **Output**: Modelo 3D (GLB)
- ⏱️ **Tempo**: ~15-30 segundos
- 💾 **VRAM**: ~3-4GB

**Como usar:**
1. Carregar workflow no ComfyUI
2. Fazer upload de uma imagem
3. Clicar "Queue Prompt"
4. Baixar o GLB gerado

---

### 2. **Prompt to 3D (Básico)**
**Arquivo:** `workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json`

**Funcionalidade:**
- ✍️ **Input**: Texto (prompt)
- 🖼️ **Passo 1**: SD 1.5 gera imagem
- 🎯 **Passo 2**: TripoSR converte em 3D
- ⏱️ **Tempo**: ~20-40 segundos
- 💾 **VRAM**: ~4-5GB

---

### 3. **Prompt to 3D (Avançado - InstantMesh)**
**Arquivo:** `workflows/3d/advanced/AIEXX_prompt_to_3d_instantmesh.json`

**Funcionalidade:**
- ✍️ **Input**: Texto (prompt)
- 🎯 **Output**: 3D de alta qualidade
- ⏱️ **Tempo**: ~45-90 segundos
- 💾 **VRAM**: ~5-6GB

**Requer:**
- Zero123++ (multi-view generation)
- InstantMesh (mesh reconstruction)

---

## 🔄 Ordem Correta de Execução

```
1. INSTALL_VS_BUILDTOOLS.bat  →  Reiniciar PC
                ↓
2. INSTALL_TORCH_SCATTER.bat
                ↓
3. RUN_INSTALL_3DPACK.bat
                ↓
4. START_AIEXX.bat  →  Acessar http://localhost:8188
                ↓
5. Carregar workflow e testar!
```

---

## ⚠️ Troubleshooting

### VS Build Tools: "cl.exe not found"
**Solução:** Reinicie o computador após instalar

### torch_scatter: Compilação falha
**Possíveis causas:**
- VS Build Tools não instalado
- CUDA_PATH não configurado

**Solução:**
```batch
set CUDA_PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8
INSTALL_TORCH_SCATTER.bat
```

### ComfyUI-3D-Pack: "IMPORT FAILED"
**Solução:** Certifique-se de que torch_scatter foi instalado com sucesso:
```batch
.venv311\Scripts\python.exe -c "import torch_scatter; print('OK')"
```

### Nodes TripoSR não aparecem
**Causa:** ComfyUI-3D-Pack não carregou
**Solução:** Verificar logs no terminal do ComfyUI

---

## 📊 Status Atual

### ✅ Já Instalado:
- Python 3.11.9
- PyTorch 2.7.0+cu128
- CUDA 12.8
- Stable Diffusion 1.5 + VAE + CLIP
- ComfyUI rodando (http://localhost:8188)
- nvdiffrast, kiui, spconv

### ❌ Faltando:
- Visual Studio Build Tools 2022
- torch_scatter
- ComfyUI-3D-Pack completo (com nodes TripoSR)
- Modelo TripoSR

---

## 🎯 Próxima Ação

**Execute agora:**
```batch
INSTALL_VS_BUILDTOOLS.bat
```

**Após reiniciar o PC:**
```batch
INSTALL_TORCH_SCATTER.bat
RUN_INSTALL_3DPACK.bat
START_AIEXX.bat
```

---

## 💡 Dicas

1. **Tempo total estimado**: ~45 minutos (incluindo downloads e compilação)
2. **Espaço em disco**: ~10GB adicionais
3. **Durante compilação**: CPU ficará em alta utilização (normal)
4. **Primeira execução**: TripoSR pode demorar ~1 minuto para carregar o modelo

---

## 🆘 Suporte

Se encontrar problemas:
1. Verifique os logs no terminal
2. Consulte `TROUBLESHOOTING.md`
3. Abra uma issue no GitHub

---

**Desenvolvido por AIEXX** | GPU Optimized for RTX 5060

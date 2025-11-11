# 🚀 AIEXX GenAI - Quick Start Guide

## Guia Rápido de Inicialização - GPU RTX 5060

```
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

  GenAI Image to 3D System
  GPU Accelerated - RTX 5060 Optimized
```

---

## 📋 Índice

1. [Início Rápido (3 Passos)](#início-rápido)
2. [Como Usar](#como-usar)
3. [Workflows Disponíveis](#workflows-disponíveis)
4. [Configurações GPU](#configurações-gpu)
5. [Troubleshooting](#troubleshooting)

---

## 🎯 Início Rápido

### Passo 1: Configurar Token Hugging Face (Primeira Vez)

Edite o arquivo `.env` e adicione seu token:

```env
HUGGING_FACE_HUB_TOKEN=hf_seu_token_real_aqui
```

**Como obter o token:**
1. Acesse: https://huggingface.co/settings/tokens
2. Crie um novo token com permissão de "Read"
3. Copie e cole no arquivo `.env`

### Passo 2: Baixar Modelos SD (Primeira Vez)

Execute o setup de modelos Stable Diffusion:

```batch
SETUP_SD_MODELS.bat
```

Este comando vai baixar (~6GB):
- ✅ Stable Diffusion 1.5
- ✅ VAE optimizado
- ✅ CLIP Vision

**Tempo estimado**: 10-30 minutos (depende da internet)

### Passo 3: Iniciar o Sistema

Execute o launcher principal:

```batch
START_AIEXX.bat
```

Pronto! O sistema vai:
1. Verificar GPU e CUDA
2. Verificar modelos instalados
3. Configurar otimizações
4. Iniciar ComfyUI na porta 8188

**Acesse**: http://localhost:8188

---

## 🎨 Como Usar

### Interface Web

1. **Abra o navegador** em `http://localhost:8188`

2. **Carregue um workflow**:
   - Clique no ícone de pasta (Load)
   - Navegue para: `workflows/3d/basic/`
   - Selecione: `AIEXX_prompt_to_3d_triposr.json`

3. **Configure seus prompts**:

   **Prompt Positivo** (o que você quer):
   ```
   a high quality 3d model of a futuristic robot, detailed,
   professional, clean background, centered, front view
   ```

   **Negative Prompt** (o que evitar):
   ```
   blurry, low quality, distorted, multiple views, text,
   watermark, bad anatomy
   ```

4. **Clique em "Queue Prompt"** para iniciar a geração

5. **Aguarde** (~20-40 segundos):
   - Primeiro gera a imagem 2D
   - Depois converte para 3D

6. **Resultado**:
   - Imagem: `ComfyUI/output/AIEXX_generated_*.png`
   - Modelo 3D: `ComfyUI/output/AIEXX_3d_model_*.glb`

---

## 📦 Workflows Disponíveis

### 🟢 Básico - TripoSR (Recomendado para Iniciar)

**Arquivo**: `workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json`

**Pipeline**: Prompt → SD 1.5 → Imagem → TripoSR → 3D GLB

**Vantagens**:
- ✅ Rápido (~20-30 segundos)
- ✅ Bom para objetos simples
- ✅ Baixo uso de VRAM (~3-4GB)

**Melhor para**: Objetos, props, assets simples

---

### 🔵 Avançado - InstantMesh (Melhor Qualidade)

**Arquivo**: `workflows/3d/advanced/AIEXX_prompt_to_3d_instantmesh.json`

**Pipeline**: Prompt → SD 1.5 → Imagem → Zero123Plus → Multi-view → InstantMesh → 3D GLB

**Vantagens**:
- ✅ Melhor qualidade
- ✅ Detalhes mais precisos
- ✅ Melhor topologia

**Desvantagens**:
- ⚠️ Mais lento (~40-60 segundos)
- ⚠️ Mais VRAM (~5-7GB)

**Melhor para**: Personagens, modelos complexos, assets premium

---

## ⚙️ Configurações GPU

### Otimizações Ativas

O launcher `START_AIEXX.bat` já configura automaticamente:

```
✓ CUDA 12.1 habilitado
✓ BF16 precision (UNet + VAE)
✓ PyTorch cross-attention
✓ Flash attention v2
✓ High VRAM mode
✓ Aggressive memory management
```

### Ajustes de Performance

**Se estiver lento**:
1. Feche outros programas que usam GPU
2. Reduza resolução para 256x256 no workflow
3. Use o workflow básico (TripoSR)

**Se der erro de memória**:
1. Use workflow básico
2. Feche navegadores/apps que usam VRAM
3. Reinicie o sistema

---

## 🔧 Troubleshooting

### ❌ Erro: "CUDA not available"

**Solução**:
```batch
install_pytorch_cuda.bat
```

Reinstala PyTorch com suporte CUDA.

---

### ❌ Erro: "Checkpoint not found"

**Causa**: Modelos SD não instalados

**Solução**:
```batch
SETUP_SD_MODELS.bat
```

---

### ❌ Erro: "Out of memory"

**Soluções**:

1. **Reduzir resolução** no workflow:
   - Mude `EmptyLatentImage` de 512x512 para 256x256

2. **Usar modo low VRAM**:
   - Edite `START_AIEXX.bat`
   - Troque `--highvram` por `--lowvram`

3. **Fechar outros programas**:
   - Chrome/Firefox (podem usar 1-2GB VRAM)
   - Jogos em background
   - Outros apps gráficos

---

### ❌ Modelo 3D com baixa qualidade

**Soluções**:

1. **Melhorar o prompt**:
   ```
   Ruim:  "robot"
   Bom:   "a high quality detailed robot character, professional 3d render,
          centered, front view, clean white background, studio lighting"
   ```

2. **Aumentar steps** no KSampler:
   - De 20 para 30-50 steps

3. **Usar melhor sampler**:
   - Tente: `dpmpp_2m` com scheduler `karras`

4. **Usar workflow avançado**:
   - `AIEXX_prompt_to_3d_instantmesh.json`

---

### 🌐 ComfyUI não abre no navegador

**Soluções**:

1. **Verificar se está rodando**:
   ```
   netstat -ano | findstr :8188
   ```
   Se não aparecer nada, o servidor não iniciou.

2. **Verificar logs** no console onde rodou `START_AIEXX.bat`

3. **Testar URL alternativa**:
   - http://127.0.0.1:8188
   - http://[seu-ip-local]:8188

---

## 📊 Performance Esperada (RTX 5060)

| Workflow | Resolução | Tempo | VRAM |
|----------|-----------|-------|------|
| TripoSR Basic | 256x256 | ~15s | 2-3GB |
| TripoSR Basic | 512x512 | ~25s | 3-4GB |
| InstantMesh | 512x512 | ~45s | 5-6GB |
| InstantMesh | 768x768 | ~70s | 7-8GB |

---

## 📁 Estrutura de Arquivos

```
C:\AIEXX_GENAI_IMAGE_TO_3D\
│
├── START_AIEXX.bat           ← INICIAR AQUI!
├── SETUP_SD_MODELS.bat       ← Configuração inicial
├── .env                      ← Suas configurações
│
├── ComfyUI\
│   ├── models\               ← Modelos AI
│   ├── input\                ← Suas imagens
│   └── output\               ← Resultados
│
├── workflows\
│   └── 3d\
│       ├── basic\            ← Workflows simples
│       └── advanced\         ← Workflows avançados
│
└── exports\                  ← Organizados por formato
    ├── glb\
    ├── obj\
    ├── fbx\
    └── stl\
```

---

## 🎓 Dicas de Prompts

### Para Personagens:
```
Positivo: "high quality 3d character model, detailed face,
          professional game asset, T-pose, centered, front view,
          clean background, 8k quality"

Negativo: "blurry, deformed, bad anatomy, multiple views,
          text, watermark, low quality, ugly"
```

### Para Objetos:
```
Positivo: "professional 3d product render, detailed, clean geometry,
          studio lighting, white background, centered, isometric view"

Negativo: "blurry, distorted, low poly, compressed, artifacts"
```

### Para Ambientes:
```
Positivo: "detailed 3d environment asset, game ready,
          realistic textures, good topology, professional"

Negativo: "low quality, distorted, bad geometry, compressed"
```

---

## 🔗 Links Úteis

- **Documentação Completa**: `README.md`
- **Workflows**: `workflows/3d/basic/README.md`
- **Troubleshooting**: `TROUBLESHOOTING.md`
- **ComfyUI Docs**: https://docs.comfy.org/

---

## 💬 Suporte

**Problemas comuns**: Veja `TROUBLESHOOTING.md`

**Logs**: Verifique `ComfyUI/user/comfyui_8188.log`

---

**Criado por AIEXX**
**Version 1.0.0**
**GPU Optimized for RTX 5060**

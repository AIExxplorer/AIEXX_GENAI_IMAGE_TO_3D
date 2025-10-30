<div align="center">

\`\`\`
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
\`\`\`

# AIEXX GenAI Image to 3D

### Sistema Avançado de Geração 3D Acelerado por GPU  
**Prompt → Imagem → Modelo 3D | De Texto a 3D em Segundos**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11](https://img.shields.io/badge/python-3.11-blue.svg)](https://www.python.org/downloads/)
[![GPU Optimized](https://img.shields.io/badge/GPU-RTX%205060%20Optimized-brightgreen.svg)](https://www.nvidia.com/)
[![ComfyUI](https://img.shields.io/badge/ComfyUI-Compatible-orange.svg)](https://github.com/comfyanonymous/ComfyUI)
[![Stable Diffusion](https://img.shields.io/badge/Stable%20Diffusion-1.5-purple.svg)](https://huggingface.co/)

---

**⚡ [Início Rápido](#-início-rápido)** • **🎨 [Workflows](#-workflows-disponíveis)** • **🚀 [Performance](#-performance)** • **📚 [Documentação](#-documentação)**

</div>

---

## 🎯 Sobre o Projeto

O **AIEXX GenAI Image to 3D** é um sistema completo e otimizado para **geração de modelos 3D a partir de prompts de texto** ou imagens 2D, utilizando **inteligência artificial de última geração** e **aceleração GPU**.

### ✨ Destaques

\`\`\`
🔥 PROMPT TO 3D
   Digite texto → Gera imagem 2D → Converte em 3D
   Tempo total: 20-60 segundos!

⚡ GPU ACCELERATED  
   Otimizado para NVIDIA RTX 5060
   CUDA 12.1 + BF16 Precision
   High Performance Mode

🎨 PROMPT + NEGATIVE PROMPT
   Controle total sobre a geração
   Stable Diffusion 1.5 integrado
   Qualidade profissional
\`\`\`

---

## ⚡ Início Rápido

### 🟢 Primeira Vez? (3 Passos)

#### **1. Configure o Token Hugging Face**

Edite `.env`:
\`\`\`env
HUGGING_FACE_HUB_TOKEN=hf_seu_token_aqui
\`\`\`

**Token**: https://huggingface.co/settings/tokens

#### **2. Baixe Modelos SD**

\`\`\`batch
SETUP_SD_MODELS.bat
\`\`\`

#### **3. Inicie**

\`\`\`batch
START_AIEXX.bat
\`\`\`

Acesse: **http://localhost:8188**

---

## 🎨 Workflows Disponíveis

### 🟢 Básico - TripoSR

**Arquivo**: \`workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json\`

- **Pipeline**: Prompt → SD 1.5 → TripoSR → GLB
- **Tempo**: ~20-30s
- **VRAM**: 3-4GB
- **Melhor para**: Objetos simples

### 🔵 Avançado - InstantMesh  

**Arquivo**: \`workflows/3d/advanced/AIEXX_prompt_to_3d_instantmesh.json\`

- **Pipeline**: Prompt → SD → Zero123Plus → InstantMesh → GLB
- **Tempo**: ~40-60s
- **VRAM**: 5-7GB
- **Melhor para**: Alta qualidade

---

## 🚀 Performance (RTX 5060)

| Workflow | Resolução | Tempo | VRAM |
|----------|-----------|-------|------|
| TripoSR | 512x512 | ~25s | 3-4GB |
| InstantMesh | 512x512 | ~45s | 5-6GB |

**Otimizações Ativas**:
- ✅ CUDA 12.1
- ✅ BF16 precision
- ✅ PyTorch cross-attention
- ✅ Flash attention v2

---

## 📚 Documentação

| Documento | Descrição |
|-----------|-----------|
| [START_HERE.md](START_HERE.md) | Início ultra-rápido |
| [QUICK_START_GUIDE.md](QUICK_START_GUIDE.md) | Guia completo |
| [workflows/3d/basic/README.md](workflows/3d/basic/README.md) | Workflows e dicas |

---

## 📦 Requisitos

- **GPU**: NVIDIA RTX 5060 (recomendado)
- **RAM**: 16GB mínimo, 32GB recomendado
- **Storage**: ~50GB
- **OS**: Windows 10/11
- **Python**: 3.11

---

## 📁 Estrutura

\`\`\`
AIEXX_GENAI_IMAGE_TO_3D/
├── START_AIEXX.bat          ⭐ LAUNCHER
├── SETUP_SD_MODELS.bat
├── ComfyUI/
│   ├── models/
│   ├── input/
│   └── output/
├── workflows/3d/
│   ├── basic/
│   └── advanced/
└── exports/
\`\`\`

---

## 📄 Licença

MIT License - veja [LICENSE](LICENSE)

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**

**GPU Optimized for RTX 5060**

[⬆ Voltar ao topo](#aiexx-genai-image-to-3d)

</div>

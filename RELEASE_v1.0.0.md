# 🚀 Release v1.0.0 - AIEXX GenAI Image to 3D System

## Sistema Completo de Geração 3D Acelerado por GPU

```
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
```

Sistema profissional de **geração de modelos 3D a partir de prompts de texto**, utilizando IA de última geração e aceleração GPU.

---

## ✨ Destaques Principais

🔥 **PROMPT TO 3D**
- Digite texto → Gera imagem 2D → Converte em 3D
- Tempo total: **20-60 segundos**!

⚡ **GPU ACCELERATED**
- Otimizado para **NVIDIA RTX 5060**
- **CUDA 12.1** + **BF16 Precision**
- High Performance Mode

🎨 **PROMPT + NEGATIVE PROMPT**
- Controle total sobre a geração
- **Stable Diffusion 1.5** integrado
- Qualidade profissional

---

## 🚀 Como Começar

### 1. Clone o Repositório
```bash
git clone https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D.git
cd AIEXX_GENAI_IMAGE_TO_3D
```

### 2. Configure o Token
Edite `.env`:
```env
HUGGING_FACE_HUB_TOKEN=hf_seu_token_aqui
```

### 3. Baixe Modelos SD
```batch
SETUP_SD_MODELS.bat
```

### 4. Inicie o Sistema
```batch
START_AIEXX.bat
```

Acesse: **http://localhost:8188**

📖 **Guias**: [START_HERE.md](START_HERE.md) | [QUICK_START_GUIDE.md](QUICK_START_GUIDE.md)

---

## 🎯 Novos Recursos

### Launcher Único
- ✅ **START_AIEXX.bat** - Launcher principal com ASCII art AIEXX
- ✅ Verificações automáticas de GPU, CUDA e modelos
- ✅ Otimizações GPU ativadas automaticamente

### Workflows com Prompts
- ✅ **Básico (TripoSR)**: Prompt → SD 1.5 → TripoSR → GLB (~25s)
- ✅ **Avançado (InstantMesh)**: Prompt → SD → Zero123Plus → InstantMesh → GLB (~45s)
- ✅ Suporte completo para **prompt e negative prompt**

### Download Automático
- ✅ Script `download_sd_models.py` para modelos Stable Diffusion
- ✅ **SETUP_SD_MODELS.bat** para configuração rápida

### Documentação Profissional
- ✅ README.md com ASCII art e badges
- ✅ START_HERE.md - Guia ultra-rápido
- ✅ QUICK_START_GUIDE.md - Guia completo
- ✅ TROUBLESHOOTING.md - Solução de problemas
- ✅ workflows/3d/basic/README.md - Dicas de workflows

---

## 📊 Performance (RTX 5060)

| Workflow | Resolução | Tempo | VRAM | Qualidade |
|----------|-----------|-------|------|-----------|
| **TripoSR Basic** | 512x512 | ~25s | 3-4GB | ⭐⭐⭐⭐ |
| **InstantMesh** | 512x512 | ~45s | 5-6GB | ⭐⭐⭐⭐⭐ |

### Otimizações Ativas
- ✅ CUDA 12.1 acceleration
- ✅ BF16 mixed precision (UNet + VAE)
- ✅ PyTorch cross-attention
- ✅ Flash attention v2
- ✅ High VRAM mode

---

## 🧹 Limpeza e Organização

### Arquivos Removidos (31)
- ❌ 7 launchers antigos consolidados em 1
- ❌ 10 scripts PowerShell desnecessários
- ❌ 11 documentações obsoletas/duplicadas
- ❌ 3 logs e temporários

### Resultado
- ✅ **73% redução** de arquivos
- ✅ Estrutura limpa e profissional
- ✅ Apenas arquivos essenciais mantidos
- ✅ Manutenção simplificada

---

## 📦 Arquivos Principais

```
AIEXX_GENAI_IMAGE_TO_3D/
├── START_AIEXX.bat          ⭐ LAUNCHER PRINCIPAL
├── SETUP_SD_MODELS.bat
├── README.md
├── START_HERE.md
├── QUICK_START_GUIDE.md
├── workflows/3d/
│   ├── basic/
│   │   └── AIEXX_prompt_to_3d_triposr.json
│   └── advanced/
│       └── AIEXX_prompt_to_3d_instantmesh.json
└── ...
```

---

## 🎨 Exemplos de Uso

### Exemplo 1: Personagem Robot
```
Prompt: "high quality robot character, detailed, professional, front view, clean background"
Negative: "blurry, low quality, distorted, multiple views, text, watermark"
Tempo: ~25s | Output: robot_model.glb
```

### Exemplo 2: Objeto 3D
```
Prompt: "professional 3d product render, detailed, studio lighting, white background"
Negative: "blurry, distorted, low poly, compressed, artifacts"
Tempo: ~45s | Output: product_model.glb
```

---

## 📦 Requisitos

- **GPU**: NVIDIA RTX 5060 (recomendado)
- **RAM**: 16GB mínimo, 32GB recomendado
- **Storage**: ~50GB
- **OS**: Windows 10/11
- **Python**: 3.11
- **CUDA**: 12.1+

---

## 🤝 Compatibilidade

| Software | GLB | OBJ | FBX | STL |
|----------|-----|-----|-----|-----|
| Blender | ✅ | ✅ | ✅ | ✅ |
| Unity | ✅ | ✅ | ✅ | ❌ |
| Unreal Engine | ✅ | ✅ | ✅ | ❌ |
| Three.js | ✅ | ✅ | ❌ | ❌ |
| Maya | ⚠️ | ✅ | ✅ | ⚠️ |

---

## 📝 Changelog Completo

### Added
- Sistema AIEXX completo de geração 3D
- Launcher START_AIEXX.bat com ASCII art
- Workflows com prompt/negative prompt support
- Download automático de modelos SD (download_sd_models.py)
- SETUP_SD_MODELS.bat para configuração rápida
- Documentação completa (START_HERE.md, QUICK_START_GUIDE.md)
- 2 workflows: básico (TripoSR) e avançado (InstantMesh)
- Otimizações GPU RTX 5060 (CUDA 12.1 + BF16)

### Changed
- README.md completamente redesenhado com ASCII art
- .gitignore atualizado com novos padrões
- .env.example atualizado com caminhos corretos
- Estrutura de pastas organizada

### Removed
- 31 arquivos obsoletos (73% redução)
- 7 launchers antigos consolidados em 1
- 10 scripts PowerShell desnecessários
- 11 documentações duplicadas/obsoletas
- Logs e arquivos temporários

---

## 📄 Licença

MIT License - veja [LICENSE](LICENSE)

---

## 🙏 Créditos

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI) - Framework base
- [Stability AI](https://stability.ai/) - Stable Diffusion, TripoSR
- [TencentARC](https://github.com/TencentARC) - InstantMesh
- [Sudo AI](https://github.com/sudo-ai) - Zero123++

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**

**GPU Optimized for RTX 5060**

[📖 Documentação](https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D) • [🐛 Issues](https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/issues) • [💬 Discussions](https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/discussions)

</div>

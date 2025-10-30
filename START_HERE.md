# 🎯 COMECE AQUI - AIEXX GenAI

```
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

  Sistema de Geração 3D por IA
  Acelerado por GPU RTX 5060
```

---

## ⚡ Início Ultra-Rápido

### 🟢 Primeira Vez?

Execute estes 2 arquivos em ordem:

1. **Configure seu token Hugging Face**:
   - Edite o arquivo `.env`
   - Adicione seu token: `HUGGING_FACE_HUB_TOKEN=hf_seu_token_aqui`
   - Token em: https://huggingface.co/settings/tokens

2. **Baixe os modelos necessários**:
   ```
   SETUP_SD_MODELS.bat
   ```
   Aguarde download (~6GB, 10-30 min)

### 🚀 Já Configurou? Inicie Agora!

Execute este arquivo:

```
START_AIEXX.bat
```

Acesse: **http://localhost:8188**

---

## 📝 Como Criar Modelos 3D

1. **Abra** http://localhost:8188 no navegador

2. **Carregue um workflow**:
   - Clique no ícone de pasta 📁
   - Escolha: `workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json`

3. **Digite seu prompt**:
   ```
   Exemplo: "a high quality robot character, detailed, professional, front view"
   ```

4. **Clique em "Queue Prompt"**

5. **Aguarde 20-40 segundos** ⏱️

6. **Resultado**:
   - Modelo 3D em: `ComfyUI/output/AIEXX_3d_model_*.glb`

---

## 📚 Documentação

- **Guia Completo**: `QUICK_START_GUIDE.md`
- **Workflows**: `workflows/3d/basic/README.md`
- **Problemas**: `TROUBLESHOOTING.md`

---

## 🎨 Exemplos de Prompts

### Personagem:
```
high quality 3d character model, detailed, professional game asset,
T-pose, centered, front view, clean background
```

### Objeto:
```
professional 3d product render, detailed, studio lighting,
white background, centered, isometric view
```

### Negative Prompt (sempre use):
```
blurry, low quality, distorted, multiple views, text, watermark,
bad anatomy, deformed
```

---

## ⚙️ Especificações

- **GPU**: NVIDIA RTX 5060
- **CUDA**: 12.1
- **Precision**: BF16
- **VRAM**: 3-6GB (dependendo do workflow)
- **Tempo**: 20-60 segundos por modelo

---

## 🎯 Arquivos Importantes

| Arquivo | Descrição |
|---------|-----------|
| `START_AIEXX.bat` | ⭐ **INICIAR SISTEMA** |
| `SETUP_SD_MODELS.bat` | Baixar modelos SD (primeira vez) |
| `.env` | Suas configurações e tokens |
| `QUICK_START_GUIDE.md` | Guia detalhado |

---

## 🆘 Problemas?

**Erro de CUDA?**
→ Execute: `install_pytorch_cuda.bat`

**Erro "checkpoint not found"?**
→ Execute: `SETUP_SD_MODELS.bat`

**Mais ajuda?**
→ Veja: `TROUBLESHOOTING.md`

---

**Versão**: 1.0.0
**Criado por**: AIEXX
**GPU**: RTX 5060 Optimized

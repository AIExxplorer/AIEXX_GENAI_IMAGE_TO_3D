# AIEXX GenAI - Basic Workflows

## 📁 Workflows Disponíveis

### 1. AIEXX_prompt_to_3d_triposr.json

**Descrição**: Workflow completo de texto para 3D usando Stable Diffusion 1.5 + TripoSR

**Pipeline**:
```
Prompt → SD 1.5 → Imagem 2D → TripoSR → Modelo 3D (GLB)
```

**Como usar**:

1. **Abra o workflow** no ComfyUI
2. **Configure o Prompt Positivo** (nó CLIPTextEncode verde):
   ```
   Exemplo: "a high quality 3d model of a robot character, detailed, professional, clean background, centered, front view"
   ```

3. **Configure o Negative Prompt** (nó CLIPTextEncode vermelho):
   ```
   Exemplo: "blurry, low quality, distorted, multiple views, text, watermark, bad anatomy"
   ```

4. **Ajuste parâmetros do KSampler** (opcional):
   - `seed`: 42 (use -1 para aleatório)
   - `steps`: 20 (mais steps = melhor qualidade)
   - `cfg`: 7.5 (guidance scale)
   - `sampler_name`: euler (ou dpmpp_2m, dpmpp_sde)
   - `scheduler`: normal

5. **Clique em "Queue Prompt"** para gerar

6. **Resultado**:
   - Imagem gerada: `output/AIEXX_generated_image_*.png`
   - Modelo 3D: `output/AIEXX_3d_model_*.glb`

---

## 🎨 Dicas para Prompts

### Prompts Positivos Efetivos:
- Sempre inclua: "high quality", "detailed", "professional"
- Para personagens: "character, centered, front view, clean background"
- Para objetos: "product photo, studio lighting, white background"
- Para estilização: "3d render", "game asset", "low poly", "realistic"

### Negative Prompts Recomendados:
```
blurry, low quality, distorted, multiple views, text, watermark,
bad anatomy, deformed, ugly, compressed, low resolution
```

---

## ⚙️ Requisitos

### Modelos Necessários:
- ✅ `checkpoints/v1-5-pruned-emaonly.safetensors` (SD 1.5)
- ✅ `triposr/model.ckpt`
- ✅ `vae/vae-ft-mse-840000-ema-pruned.safetensors` (opcional)

### Para instalar os modelos SD:
```bash
SETUP_SD_MODELS.bat
```

---

## 🚀 Performance

### GPU RTX 5060:
- Geração de imagem (512x512): ~5-10 segundos
- Conversão para 3D: ~15-30 segundos
- **Total**: ~20-40 segundos por modelo 3D

### Otimizações Ativas:
- ✅ CUDA acceleration
- ✅ BF16 precision
- ✅ High VRAM mode
- ✅ PyTorch cross-attention

---

## 📤 Formatos de Exportação

Você pode alterar o formato no nó `SaveMesh`:
- **GLB** (recomendado) - compatível com web
- **OBJ** - compatível com todos os softwares 3D
- **FBX** - para game engines
- **STL** - para impressão 3D

---

## 🔧 Troubleshooting

### Erro: "Checkpoint not found"
→ Execute `SETUP_SD_MODELS.bat` para baixar o SD 1.5

### Erro: "Out of memory"
→ Reduza a resolução para 256x256 no nó EmptyLatentImage

### Imagem borrada/baixa qualidade
→ Aumente os steps para 30-50
→ Melhore o prompt positivo
→ Use seed fixo para reproduzir bons resultados

---

**Criado por AIEXX GenAI**

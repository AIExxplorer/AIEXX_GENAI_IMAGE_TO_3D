# 🚀 Como Usar o Sistema AIEXX - Image to 3D

## ✅ Status da Instalação

**Tudo instalado e pronto para uso!**

```
✅ Python 3.11 + PyTorch 2.7.0+cu128
✅ CUDA 12.8 Funcionando
✅ GPU: NVIDIA GeForce RTX 5060 (8GB VRAM)
✅ Visual Studio Build Tools 2022
✅ torch_scatter 2.1.2+pt27cu128
✅ ComfyUI-3D-Pack Completo
✅ TripoSR Model (1.6 GB)
✅ Stable Diffusion 1.5 (4.0 GB)
✅ 6 Workflows Prontos
```

---

## 🎯 Início Rápido (3 Passos)

### **Passo 1: Iniciar o ComfyUI**

Execute o launcher:
```batch
START_AIEXX.bat
```

Aguarde a mensagem:
```
To see the GUI go to: http://127.0.0.1:8188
```

**Abra seu navegador em:** http://localhost:8188

---

### **Passo 2: Carregar um Workflow**

No ComfyUI:

1. Clique em **"Load"** (botão no canto superior direito)
2. Navegue até a pasta `workflows/3d/`
3. Escolha um dos workflows abaixo

---

### **Passo 3: Gerar seu Primeiro Modelo 3D**

Escolha um dos 3 workflows recomendados:

---

## 🎨 Workflows Disponíveis

### **1. Image → 3D (MAIS FÁCIL)** ⭐ **RECOMENDADO PARA COMEÇAR**

**Arquivo:** `workflows/3d/03_triposr_single_image_to_mesh.json`

**O que faz:**
- Você faz upload de uma **foto/imagem** de um objeto
- O sistema converte em modelo 3D usando TripoSR
- Download do arquivo `.glb` (compatível com Blender, Unity, etc.)

**Como usar:**
1. Carregue o workflow no ComfyUI
2. Clique no nó de **LoadImage**
3. Faça upload de uma imagem (PNG, JPG)
   - **Dica:** Use fotos com fundo limpo e objeto centralizado
4. Clique **"Queue Prompt"** (canto direito)
5. Aguarde ~15-30 segundos
6. Arquivo `.glb` salvo em: `ComfyUI/output/`

**Especificações:**
- ⏱️ Tempo: ~15-30 segundos
- 💾 VRAM: ~3-4GB
- 📷 Input: Imagem 2D
- 🎯 Output: Modelo 3D (GLB)

**Ideal para:**
- Converter fotos reais em 3D
- Protótipos rápidos
- Teste inicial do sistema

---

### **2. Prompt → 3D (Básico)**

**Arquivo:** `workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json`

**O que faz:**
- Você digita um **texto** descrevendo o que quer
- Stable Diffusion 1.5 gera uma imagem 2D
- TripoSR converte a imagem em 3D
- Download do arquivo `.glb`

**Como usar:**
1. Carregue o workflow no ComfyUI
2. Encontre o nó **CLIPTextEncode** (verde - positive prompt)
3. Digite seu prompt, exemplo:
   ```
   a high quality 3d model of a futuristic robot character,
   detailed, professional, clean background, centered, front view
   ```
4. Encontre o nó **CLIPTextEncode** (vermelho - negative prompt)
5. Defina o que NÃO quer:
   ```
   blurry, low quality, distorted, multiple views,
   text, watermark, bad anatomy
   ```
6. Clique **"Queue Prompt"**
7. Aguarde ~25-40 segundos
8. Arquivo `.glb` salvo em: `ComfyUI/output/`

**Especificações:**
- ⏱️ Tempo: ~25-40 segundos
- 💾 VRAM: ~4-5GB
- ✍️ Input: Texto (prompt)
- 🎯 Output: Modelo 3D (GLB)

**Pipeline:**
```
Prompt → SD 1.5 → Imagem 2D → TripoSR → Modelo 3D
```

**Ideal para:**
- Criar modelos 3D do zero
- Experimentar com diferentes prompts
- Geração criativa

---

### **3. Prompt → 3D (Alta Qualidade - Avançado)**

**Arquivo:** `workflows/3d/advanced/AIEXX_prompt_to_3d_instantmesh.json`

**O que faz:**
- Pipeline completo com múltiplas views
- Usa Zero123++ para gerar vistas de múltiplos ângulos
- InstantMesh reconstrói malha 3D de alta qualidade
- Melhor geometria e detalhes

**Especificações:**
- ⏱️ Tempo: ~45-90 segundos
- 💾 VRAM: ~5-6GB
- ✍️ Input: Texto (prompt)
- 🎯 Output: Modelo 3D de alta qualidade

**Pipeline:**
```
Prompt → SD → Zero123++ (multi-view) → InstantMesh → 3D
```

**Ideal para:**
- Modelos finais de alta qualidade
- Projetos profissionais
- Quando precisa de melhor geometria

**Nota:** Requer modelos adicionais (Zero123++, InstantMesh)

---

## 📂 Onde Ficam os Arquivos Gerados?

Após executar um workflow, os arquivos ficam em:

```
ComfyUI/output/
├── AIEXX_3d_model_00001_.glb     (modelo 3D)
├── AIEXX_generated_image_00001_.png  (imagem gerada)
└── ...
```

---

## 🎨 Dicas para Melhores Resultados

### **Para Image → 3D:**

✅ **Boas práticas:**
- Use imagens com **fundo limpo/uniforme**
- Objeto **centralizado** na imagem
- Boa **iluminação** uniforme
- Resolução **512x512** ou maior
- Objetos **simples e isolados**

❌ **Evite:**
- Fundos complexos/bagunçados
- Múltiplos objetos na mesma imagem
- Imagens muito escuras ou estouradas
- Objetos muito finos ou transparentes

---

### **Para Prompt → 3D:**

✅ **Prompts efetivos:**
```
a high quality 3d model of [objeto], detailed, professional,
clean background, centered, front view, single object
```

**Exemplos:**
- `a high quality 3d model of a futuristic robot character`
- `a detailed 3d model of a medieval sword, metallic, centered`
- `a professional 3d model of a coffee mug, ceramic, simple design`
- `a 3d model of a stylized tree, low poly, game asset`

✅ **Negative prompts úteis:**
```
blurry, low quality, distorted, multiple views,
text, watermark, bad anatomy, multiple objects
```

---

## ⚙️ Ajustar Parâmetros (Opcional)

No workflow, você pode ajustar:

### **Nó KSampler (Geração de Imagem):**
- `seed`: Número aleatório (mude para variações)
- `steps`: 20-30 (mais = melhor qualidade, mais lento)
- `cfg`: 7-10 (controle sobre o prompt)

### **Nó TripoSRSampler:**
- `mc_resolution`: 128-256 (resolução da malha)
- `texture_resolution`: 1024-2048 (qualidade da textura)

---

## 🔧 Solução de Problemas

### **"Modelo não encontrado"**
```batch
DOWNLOAD_3D_MODELS.bat
```

### **"CUDA out of memory"**
- Feche outros programas que usam GPU
- Reduza `mc_resolution` para 128
- Use workflows mais simples (TripoSR básico)

### **ComfyUI não inicia**
```batch
START_AIEXX.bat
```
Verifique se há erros no console

### **Modelo 3D com qualidade ruim**
- Melhore o prompt
- Use imagem de entrada melhor
- Aumente `steps` no KSampler
- Tente o workflow avançado (InstantMesh)

---

## 📚 Recursos Adicionais

### **Visualizar modelos 3D:**
- **Windows 3D Viewer** (nativo no Windows 10/11)
- **Blender** (gratuito): https://www.blender.org/
- **Online**: https://gltf-viewer.donmccurdy.com/

### **Editar modelos 3D:**
- **Blender** - Software completo de 3D
- **MeshLab** - Limpeza e otimização de malhas
- **Unity/Unreal** - Para uso em games

---

## 🚀 Fluxo de Trabalho Completo

```
1. START_AIEXX.bat
      ↓
2. Abrir http://localhost:8188
      ↓
3. Carregar workflow:
   - Iniciante: 03_triposr_single_image_to_mesh.json
   - Intermediário: basic/AIEXX_prompt_to_3d_triposr.json
   - Avançado: advanced/AIEXX_prompt_to_3d_instantmesh.json
      ↓
4. Configurar input (imagem ou prompt)
      ↓
5. Queue Prompt
      ↓
6. Aguardar processamento
      ↓
7. Baixar .glb de ComfyUI/output/
      ↓
8. Importar no Blender/Unity/etc.
```

---

## 📊 Performance Esperada (RTX 5060 8GB)

| Workflow | Resolução | Tempo | VRAM | Qualidade |
|----------|-----------|-------|------|-----------|
| Image→3D (TripoSR) | 512x512 | ~20s | 3-4GB | Boa |
| Prompt→3D (Básico) | 512x512 | ~30s | 4-5GB | Boa |
| Prompt→3D (Avançado) | 512x512 | ~60s | 5-6GB | Excelente |

---

## 🎯 Exemplos de Uso

### **Caso 1: Converter foto de produto em 3D**
1. Tire foto do produto com fundo branco
2. Use workflow: `03_triposr_single_image_to_mesh.json`
3. Upload da foto
4. Resultado: Modelo 3D do produto

### **Caso 2: Criar assets para game**
1. Use workflow: `basic/AIEXX_prompt_to_3d_triposr.json`
2. Prompt: `"a low poly tree, game asset, simple design"`
3. Resultado: Asset 3D pronto para Unity/Unreal

### **Caso 3: Protótipo de personagem**
1. Use workflow: `basic/AIEXX_prompt_to_3d_triposr.json`
2. Prompt: `"a stylized character, cartoon style, simple design"`
3. Resultado: Conceito 3D do personagem

---

## ✨ Você está pronto!

Execute `START_AIEXX.bat` e comece a criar! 🎨

**Divirta-se criando modelos 3D com IA!** 🚀

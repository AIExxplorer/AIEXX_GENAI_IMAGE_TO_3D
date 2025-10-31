# 🎨 Workflows Disponíveis - AIEXX Image to 3D

## 📋 Visão Geral

O sistema AIEXX oferece **2 workflows** para transformar fotos em modelos 3D:

| Workflow | Nível | Tempo | Recursos | Melhor Para |
|----------|-------|-------|----------|-------------|
| **SIMPLE** | Iniciante | 30 seg | Básico | Aprender, prototipar rápido |
| **COMPLETE** | Avançado | 1-2 min | Completo | Produção, visualização, multi-export |

---

## 1️⃣ SIMPLE - Workflow Básico

### 📁 Arquivo
```
workflows/3d/AIEXX_image_to_3d_triposr_SIMPLE.json
```

### 🎯 Para Quem
- Iniciantes no ComfyUI
- Quem quer resultado rápido
- Prototipagem e testes
- Aprendizado do sistema

### ✨ Recursos
- ✅ Upload de foto
- ✅ Geração de modelo 3D
- ✅ Exportação em 1 formato (OBJ padrão)
- ✅ Interface minimalista (4 nós)

### 📊 Nós Incluídos
```
📸 LoadImage → 🤖 TripoSRModelLoader
              ↓
        ⚙️ TripoSRSampler
              ↓
          💾 SaveMesh
```

### ⏱️ Tempo de Processamento
- **Rápido:** ~30 segundos
- **Balanceado:** ~1 minuto
- **Qualidade:** ~2 minutos

### 💾 Formatos de Exportação
Escolha 1 formato no nó SaveMesh:
- `obj` → Blender, Maya, 3ds Max
- `glb` → Unity, Unreal, Web
- `stl` → Impressão 3D
- `ply` → MeshLab

### 📖 Documentação
Ver: **COMO_TRANSFORMAR_FOTO_EM_3D.md**

---

## 2️⃣ COMPLETE - Workflow Avançado

### 📁 Arquivo
```
workflows/3d/AIEXX_image_to_3d_COMPLETE.json
```

### 🎯 Para Quem
- Usuários experientes
- Produção profissional
- Quem precisa de múltiplos formatos
- Visualização e aprovação de clientes

### ✨ Recursos
- ✅ Upload de foto com preview
- ✅ Geração de modelo 3D
- ✅ **Visualizador 3D INTERATIVO** (rotação 360°)
- ✅ **Exportação simultânea em 4 formatos**
- ✅ **Renders automáticos** (4 ângulos)
- ✅ Preview multi-ângulos
- ✅ Interface organizada por grupos
- ✅ Títulos descritivos em português

### 📊 Nós Incluídos
```
INPUT (Azul):
  📸 LoadImage
  🤖 TripoSRModelLoader
         ↓
PROCESSAMENTO (Verde):
  ⚙️ TripoSRSampler
  🖼️ PreviewImage (foto original)
         ↓
VISUALIZAÇÃO (Vermelho):
  👁️ Preview3DMesh (VISUALIZADOR INTERATIVO)
  📷 MeshToImage (gera renders)
  🎬 PreviewImage (multi-ângulos)
         ↓
EXPORTAÇÃO (Roxo):
  💾 SaveMesh OBJ
  💾 SaveMesh GLB
  💾 SaveMesh STL
  💾 SaveMesh PLY
  💾 SaveImage (renders)
```

### ⏱️ Tempo de Processamento
- **Rápido:** ~1 minuto
- **Balanceado:** ~2 minutos ✅ **RECOMENDADO**
- **Qualidade:** ~5 minutos

### 👁️ Visualizador 3D Interativo

O workflow COMPLETE inclui visualizador 3D com:

**Controles:**
- 🖱️ **Rotação:** Clique e arraste
- 🔍 **Zoom:** Scroll do mouse
- ↔️ **Pan:** Ctrl + Clique e arraste
- 🔄 **Reset:** Duplo clique

**Opções:**
- Wireframe (malha)
- Texturas
- Normais
- Shading (flat/smooth)
- Escala

### 💾 Formatos de Exportação
**TODOS os formatos exportados simultaneamente:**

| Formato | Tamanho | Texturas | Arquivo |
|---------|---------|----------|---------|
| **OBJ** | ~10 MB | ✅ Sim (separado) | model_3d.obj + .mtl + .png |
| **GLB** | ~15 MB | ✅ Sim (embutido) | model_3d.glb |
| **STL** | ~5 MB | ❌ Não | model_3d.stl |
| **PLY** | ~8 MB | ✅ Cores vertex | model_3d.ply |

**Bônus: Renders automáticos**
- 4 imagens PNG (model_3d_preview_0.png, _1, _2, _3)
- Ângulos: 0°, 90°, 180°, 270°

### 📖 Documentação
Ver: **WORKFLOW_COMPLETO_GUIA.md**

---

## 🔄 Comparação Detalhada

### Interface

**SIMPLE:**
```
┌────────────────┐
│  LoadImage     │
│  ModelLoader   │
│  Sampler       │
│  SaveMesh      │
└────────────────┘
4 nós, 1 coluna
```

**COMPLETE:**
```
┌─────────┬──────────┬────────────┬───────────┐
│ INPUT   │ PROCESS  │ VISUAL     │ EXPORT    │
├─────────┼──────────┼────────────┼───────────┤
│ Load    │ Generate │ Preview3D  │ OBJ       │
│ Model   │ Preview  │ Renders    │ GLB       │
│         │          │ Multi-View │ STL       │
│         │          │            │ PLY       │
└─────────┴──────────┴────────────┴───────────┘
12 nós, 4 grupos coloridos
```

### Outputs

**SIMPLE:**
- 1 modelo 3D no formato escolhido
- Textura (se aplicável)

**COMPLETE:**
- 4 modelos 3D (OBJ, GLB, STL, PLY)
- Texturas para cada formato
- 4 renders PNG em ângulos diferentes
- Visualização interativa no navegador

### Uso de Recursos

| Recurso | SIMPLE | COMPLETE |
|---------|--------|----------|
| **VRAM** | 3-4 GB | 4-6 GB |
| **RAM** | 8 GB | 12 GB |
| **Disco** | ~15 MB | ~50 MB |
| **CPU** | Baixo | Médio |

---

## 🎯 Qual Escolher?

### Use **SIMPLE** se:
- ❓ É sua primeira vez usando o sistema
- ⚡ Precisa de resultado rápido
- 🧪 Está testando/experimentando
- 💻 Tem PC com recursos limitados
- 📦 Precisa de apenas 1 formato
- 🎓 Está aprendendo ComfyUI

### Use **COMPLETE** se:
- 💼 Está fazendo trabalho profissional
- 👁️ Precisa visualizar o modelo antes de exportar
- 📊 Precisa apresentar para cliente/equipe
- 🎨 Quer múltiplos formatos de uma vez
- 🔄 Precisa de renders em vários ângulos
- 💪 Tem PC potente (RTX 5060 é suficiente)

---

## 🚀 Início Rápido

### Para SIMPLE:
```batch
# 1. Inicie o sistema
6-START_AIEXX.bat

# 2. Acesse no navegador
http://localhost:8188

# 3. Carregue o workflow
Load > AIEXX_image_to_3d_triposr_SIMPLE.json

# 4. Carregue sua foto e clique "Queue Prompt"
```

### Para COMPLETE:
```batch
# 1. Inicie o sistema
6-START_AIEXX.bat

# 2. Acesse no navegador
http://localhost:8188

# 3. Carregue o workflow
Load > AIEXX_image_to_3d_COMPLETE.json

# 4. Carregue sua foto e clique "Queue Prompt"

# 5. Visualize o modelo 3D no nó "👁️ VISUALIZADOR 3D INTERATIVO"
```

---

## 📊 Fluxograma de Decisão

```
┌─────────────────────────────────┐
│ Precisa visualizar o modelo 3D │
│ antes de exportar?              │
└───────────┬─────────────────────┘
            │
      ┌─────┴─────┐
      │           │
     SIM         NÃO
      │           │
      ▼           ▼
  COMPLETE    ┌──────────────────────┐
              │ Precisa de múltiplos │
              │ formatos?            │
              └────┬─────────────────┘
                   │
             ┌─────┴─────┐
             │           │
            SIM         NÃO
             │           │
             ▼           ▼
         COMPLETE    SIMPLE
```

---

## 🔧 Customização

Ambos os workflows podem ser customizados:

### Mudar Qualidade
No nó **TripoSRSampler**:
- `resolution`: 128 (rápido) → 256 (normal) → 512 (alto)

### Mudar Textura
No nó **SaveMesh**:
- `texture_resolution`: 1024 → 2048 → 4096

### Adicionar Formatos
Duplique um nó **SaveMesh** e mude o `format`

### Remover Formatos (COMPLETE)
Clique com botão direito no nó → **Bypass** (ou pressione `B`)

---

## 📚 Documentação Adicional

- **COMO_TRANSFORMAR_FOTO_EM_3D.md** → Guia básico para iniciantes
- **WORKFLOW_COMPLETO_GUIA.md** → Guia avançado do workflow COMPLETE
- **workflows/3d/README.md** → Documentação técnica completa

---

## 🎓 Tutoriais em Vídeo (Futuros)

- [ ] Tutorial: Primeiro modelo 3D com SIMPLE
- [ ] Tutorial: Usando o visualizador 3D interativo
- [ ] Tutorial: Exportando para Blender
- [ ] Tutorial: Exportando para Unity
- [ ] Tutorial: Preparando para impressão 3D

---

## 🆘 Suporte

Se tiver dúvidas sobre qual workflow usar:
1. Comece com **SIMPLE** para aprender
2. Migre para **COMPLETE** quando precisar de mais recursos
3. Consulte os guias específicos de cada workflow
4. Abra issue no GitHub se tiver problemas

---

## ✨ Workflows Adicionais (Futuro)

Em desenvolvimento:
- **BATCH** → Processar múltiplas fotos de uma vez
- **ADVANCED** → Zero123++ + InstantMesh (qualidade máxima)
- **CONTROLNET** → Guiado por pose/depth
- **ANIMATION** → Gerar animação 360° do modelo

---

**Desenvolvido com ❤️ por AIEXX**
**Powered by TripoSR + ComfyUI-3D-Pack | Optimized for RTX 5060**

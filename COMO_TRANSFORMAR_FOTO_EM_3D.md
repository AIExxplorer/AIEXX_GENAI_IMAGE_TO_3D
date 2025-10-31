# 📸 Como Transformar Sua Foto em Modelo 3D

## ✅ Pré-requisitos

Você **JÁ TEM TUDO INSTALADO**:
- ✅ TripoSR instalado (1.6 GB em `ComfyUI/models/triposr/model.ckpt`)
- ✅ ComfyUI 3D Pack instalado
- ✅ CUDA configurado (RTX 5060)
- ✅ Ambiente virtual Python pronto

## 🚀 Passo a Passo

### 1️⃣ Inicie o ComfyUI

```batch
6-START_AIEXX.bat
```

Aguarde até ver a mensagem:
```
Server URL: http://localhost:8188
```

### 2️⃣ Abra o ComfyUI no navegador

Acesse: **http://localhost:8188**

### 3️⃣ Carregue o Workflow

No ComfyUI:
1. Clique em **"Load"** (canto superior direito)
2. Navegue até: `C:\AIEXX_GENAI_IMAGE_TO_3D\workflows\3d\`
3. Selecione: **`AIEXX_image_to_3d_triposr_SIMPLE.json`**

### 4️⃣ Carregue Sua Foto

1. Você verá 4 nós conectados:
   - **LoadImage** (nó verde à esquerda)
   - **TripoSRModelLoader** (embaixo)
   - **TripoSRSampler** (meio)
   - **SaveMesh** (direita)

2. Clique no nó **"LoadImage"**
3. Clique em **"Choose File"** ou **"Upload Image"**
4. Selecione a foto do seu PC

### 5️⃣ Configure a Exportação (Opcional)

No nó **"SaveMesh"**:
- **filename**: Nome do arquivo de saída (padrão: `triposr_output`)
- **format**: Formato de saída
  - `obj` → Blender, Maya, 3ds Max, ZBrush ✅ RECOMENDADO
  - `stl` → Impressão 3D
  - `glb` → Web, Unity, Unreal Engine
  - `ply` → MeshLab, CloudCompare
- **save_texture**: `true` (salva texturas junto)
- **texture_resolution**: `2048` (qualidade da textura)

### 6️⃣ Gere o Modelo 3D

Clique no botão **"Queue Prompt"** (canto superior direito)

Aguarde o processamento (10-30 segundos dependendo da resolução)

### 7️⃣ Encontre Seu Modelo 3D

O modelo será salvo em:
```
C:\AIEXX_GENAI_IMAGE_TO_3D\ComfyUI\output\
```

Você terá:
- `triposr_output.obj` → Modelo 3D
- `triposr_output.mtl` → Material
- `triposr_output.png` → Textura

## 📋 Dicas para Melhores Resultados

### ✅ Foto Ideal:
- Fundo limpo (branco, transparente ou removido)
- Objeto centralizado
- Boa iluminação (sem sombras fortes)
- Resolução: 512x512 ou 1024x1024
- Formato: PNG, JPG, JPEG

### ❌ Evite:
- Fundos complexos/com muitos elementos
- Objeto muito pequeno na imagem
- Fotos muito escuras ou estouradas
- Múltiplos objetos na mesma imagem

### 🎨 Remover Fundo da Foto:

**Online (grátis):**
- https://www.remove.bg/
- https://www.photoroom.com/tools/background-remover

**Software:**
- Photoshop (Select Subject → Delete)
- GIMP (camada com transparência)

## 🔧 Parâmetros Avançados

No nó **"TripoSRSampler"**:

- **resolution**: Resolução da malha 3D
  - `128` → Rápido, menos detalhes
  - `256` → Balanceado ✅ RECOMENDADO
  - `512` → Lento, mais detalhes (muito VRAM)

- **chunk_size**: `auto` (deixe automático)

## 📦 Usar o Modelo em Outros Softwares

### Blender:
1. File → Import → Wavefront (.obj)
2. Navegue até `ComfyUI/output/triposr_output.obj`
3. Importe

### Maya:
1. File → Import
2. Selecione o arquivo `.obj`

### Unity:
1. Converta para GLB (no SaveMesh, mude format para `glb`)
2. Arraste o .glb para a pasta Assets do Unity

### Impressão 3D:
1. Use formato STL (no SaveMesh, mude format para `stl`)
2. Abra no Cura, PrusaSlicer ou outro slicer
3. Ajuste escala e fatie

## ❓ Problemas Comuns

### "Model not found"
**Solução:** Execute novamente `4-DOWNLOAD_3D_MODELS.bat`

### "Out of memory"
**Solução:**
1. Reduza resolution para 128
2. Reduza texture_resolution para 1024
3. Feche outros programas

### Modelo 3D com buracos/artefatos
**Solução:**
1. Use foto com fundo removido
2. Certifique-se que o objeto está bem iluminado
3. Tente diferentes ângulos da foto

### Textura incorreta
**Solução:**
1. Aumente texture_resolution para 4096
2. Verifique se a imagem original tem boa qualidade
3. Evite fotos com reflexos/brilhos intensos

## 🎯 Workflow Alternativo (Mais Detalhes)

Para modelos com **mais qualidade** (porém mais lento):

Use o workflow: `workflows/3d/01_zero123_multiview.json` + `02_multiview_to_mesh_instantmesh.json`

Esse workflow:
1. Gera 6-8 vistas diferentes do objeto
2. Reconstrói o 3D com InstantMesh
3. Resulta em mais detalhes, mas leva ~2-5 minutos

## 📚 Exemplos de Uso

### Exemplo 1: Transformar produto em 3D
```
Foto de tênis → TripoSR → Modelo 3D para loja online/AR
```

### Exemplo 2: Personagem/Escultura
```
Foto de escultura → TripoSR → Modelo 3D para animação
```

### Exemplo 3: Objeto para jogo
```
Foto de objeto → TripoSR → GLB → Import no Unity/Unreal
```

## 🆘 Suporte

Se tiver problemas:
1. Verifique os logs no terminal onde executou `6-START_AIEXX.bat`
2. Consulte `workflows/3d/README.md` para documentação completa
3. Abra issue no GitHub: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/issues

---

## ✨ Pronto para Começar!

1. Execute `6-START_AIEXX.bat`
2. Acesse http://localhost:8188
3. Carregue `AIEXX_image_to_3d_triposr_SIMPLE.json`
4. Escolha sua foto
5. Clique "Queue Prompt"
6. Pronto! Seu modelo 3D está em `ComfyUI/output/`

---

**Desenvolvido com ❤️ por AIEXX**
**Powered by TripoSR + ComfyUI | Optimized for RTX 5060**

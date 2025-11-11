# 🚀 Como Usar o Sistema Image to 3D LOCAL (GPU)

## 📋 Índice
- [Visão Geral](#-visão-geral)
- [Por Que LOCAL é Melhor?](#-por-que-local-é-melhor)
- [Métodos de Uso](#-métodos-de-uso)
- [Guia Passo a Passo](#-guia-passo-a-passo)
- [Exemplos Práticos](#-exemplos-práticos)
- [Dicas e Truques](#-dicas-e-truques)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Visão Geral

O **AIEXX Image to 3D LOCAL** permite que você transforme qualquer imagem em modelo 3D usando **sua própria GPU**, sem depender de APIs pagas ou serviços online.

### ✨ Características Principais

| Característica | Valor |
|---------------|-------|
| 💰 **Custo** | **R$ 0,00** (sem mensalidades ou créditos) |
| 🔒 **Privacidade** | **100% local** - suas imagens nunca saem do PC |
| ⚡ **Velocidade** | **30-60 segundos** por modelo |
| 🎨 **Qualidade** | Texturas até **4K** |
| 📦 **Formatos** | GLB, OBJ, STL, PLY |
| 💻 **GPU** | Otimizado para **RTX 5060** e similares |

---

## 💡 Por Que LOCAL é Melhor?

### Comparação: LOCAL vs API Tripo

| Aspecto | 🟢 AIEXX LOCAL | 🔴 Tripo API |
|---------|----------------|--------------|
| **Custo por modelo** | **R$ 0,00** | ~R$ 0,50 - R$ 1,25 |
| **Custo 100 modelos** | **R$ 0,00** | ~R$ 50,00 - R$ 125,00 |
| **Privacidade** | ✅ Imagens ficam no seu PC | ❌ Enviadas para servidor |
| **Internet necessária** | ❌ Só no primeiro download | ✅ Sempre |
| **Velocidade** | ⚡ 30-60s (direto na GPU) | 🐌 40-120s (latência de rede) |
| **Controle** | ✅ Total sobre parâmetros | ⚠️ Limitado pela API |
| **Limite de uso** | ✅ Ilimitado | ⚠️ Baseado em créditos |

**💰 ECONOMIA ANUAL:** Se você gerar 50 modelos por mês, economiza **R$ 300 - R$ 750/ano**!

---

## 🎮 Métodos de Uso

Existem **3 formas** de usar o sistema:

### 1. 🖱️ **Arrasta e Solta (MAIS FÁCIL)**

```bash
# Arraste sua imagem para o arquivo:
TRANSFORM_IMAGE_TO_3D_LOCAL.bat
```

**Vantagens:**
- ✅ Mais simples
- ✅ Não precisa digitar comandos
- ✅ Ideal para iniciantes

---

### 2. 🎨 **ComfyUI Interface Gráfica**

```bash
# 1. Inicie o sistema
START.bat

# 2. Abra o navegador
http://localhost:8188

# 3. Carregue o workflow
workflows/3d/AIEXX_image_to_3d_LOCAL_GPU.json
```

**Vantagens:**
- ✅ Interface visual
- ✅ Preview em tempo real
- ✅ Ajuste parâmetros visualmente
- ✅ Salva configurações

---

### 3. 💻 **Linha de Comando (AVANÇADO)**

```bash
# Básico
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py sua_foto.png

# Avançado com opções
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py sua_foto.png modelo.glb --quality high --remove-bg
```

**Vantagens:**
- ✅ Automação (scripts)
- ✅ Processamento em lote
- ✅ Controle total

---

## 📖 Guia Passo a Passo

### 🎯 Método 1: Arrasta e Solta

#### **Passo 1:** Prepare sua imagem

📸 **Requisitos da imagem:**
- ✅ Formato: PNG, JPG, JPEG
- ✅ Resolução: 512x512 até 2048x2048
- ✅ Objeto centralizado
- ⭐ **IDEAL:** Fundo limpo ou transparente

#### **Passo 2:** Arraste para o BAT

1. Abra a pasta do projeto
2. Encontre o arquivo `TRANSFORM_IMAGE_TO_3D_LOCAL.bat`
3. **Arraste sua imagem** para cima deste arquivo
4. Solte!

#### **Passo 3:** Aguarde

```
⏳ Processamento em andamento...
[1/7] Carregando bibliotecas... ✅
[2/7] Verificando GPU... ✅
[3/7] Carregando modelo TripoSR... ✅
[4/7] Processando imagem... ✅
[5/7] Gerando modelo 3D... ⏱️ 30-60s
[6/7] Extraindo malha 3D... ✅
[7/7] Salvando modelo 3D... ✅

✅ SUCESSO! Modelo 3D criado!
📁 output_3d\sua_foto_3D.glb
```

#### **Passo 4:** Visualize seu modelo

Abra o modelo 3D em:
- 🌐 **Online:** [3dviewer.net](https://3dviewer.net)
- 🎨 **Blender:** File > Import > glTF (.glb)
- 🎮 **Unity:** Arraste direto para Assets
- 🔷 **Unreal:** Import como FBX

---

### 🎨 Método 2: ComfyUI (Interface Gráfica)

#### **Passo 1:** Inicie o ComfyUI

```bash
# Opção A: Clique duplo em
START.bat

# Opção B: Use o launcher
00-LAUNCHER\START_AIEXX.bat
```

#### **Passo 2:** Abra o navegador

Automaticamente abrirá: `http://localhost:8188`

#### **Passo 3:** Carregue o workflow

1. Clique no botão **"Load"** (canto superior)
2. Navegue até: `workflows/3d/`
3. Selecione: `AIEXX_image_to_3d_LOCAL_GPU.json`
4. Clique **"Load"**

#### **Passo 4:** Configure os nós

```
┌─────────────────────────────────────┐
│ 📷 Carregar Sua Imagem              │
│                                     │
│ [Clique aqui para selecionar]      │
│ ou arraste a imagem                 │
└─────────────────────────────────────┘
         ↓
┌─────────────────────────────────────┐
│ 🎨 Gerar Modelo 3D (GPU Local)      │
│                                     │
│ Resolution: [256] ⬅️ rápido         │
│             [512] ⬅️ qualidade      │
│ chunk_size: [auto]                  │
└─────────────────────────────────────┘
         ↓
┌─────────────────────────────────────┐
│ 💾 Salvar Modelo 3D (GLB)           │
│                                     │
│ prefix: AIEXX_3D_OUTPUT             │
│ format: glb                         │
│ save_texture: ✅ true               │
│ texture_resolution: 2048            │
└─────────────────────────────────────┘
```

#### **Passo 5:** Execute

1. Clique em **"Queue Prompt"** (botão laranja no topo)
2. Aguarde 30-60 segundos
3. Modelo aparecerá no preview
4. Arquivo salvo em `ComfyUI/output/`

---

### 💻 Método 3: Linha de Comando

#### **Script Básico:**

```bash
# Ativar ambiente virtual (se não estiver ativo)
.venv311\Scripts\activate

# Executar conversão
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py MINHAS_IMAGENS_TESTE\familia.png
```

#### **Script Avançado:**

```bash
# Alta qualidade com remoção de fundo
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py ^
    MINHAS_IMAGENS_TESTE\familia.png ^
    output_3d\familia_HD.glb ^
    --quality high ^
    --remove-bg ^
    --texture-size 4096 ^
    --mc-resolution 512
```

#### **Opções Avançadas:**

| Opção | Valores | Descrição | Impacto |
|-------|---------|-----------|---------|
| `--quality` | low, medium, high | Qualidade geral | Tempo + VRAM |
| `--remove-bg` | flag | Remove fundo | +5-10s |
| `--texture-size` | 512-4096 | Resolução textura | VRAM |
| `--mc-resolution` | 64-512 | Detalhes da malha | Tempo + VRAM |
| `--format` | glb, obj, stl, ply | Formato saída | - |
| `--no-optimize` | flag | Desabilita otimização | +faces |

---

## 🎯 Exemplos Práticos

### Exemplo 1: Foto de Família (como sua imagem)

```bash
# Entrada: MINHAS_IMAGENS_TESTE\familia.png
# Saída: Modelo 3D com 3 pessoas

# Comando:
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py ^
    MINHAS_IMAGENS_TESTE\familia.png ^
    output_3d\familia_3d.glb ^
    --quality high ^
    --remove-bg ^
    --texture-size 2048

# Resultado:
# ✅ familia_3d.glb (modelo principal)
# ✅ familia_3d.json (relatório de performance)
# ⏱️ Tempo: ~45 segundos
# 💾 VRAM: ~5.2GB
```

### Exemplo 2: Produto para E-commerce

```bash
# Entrada: produto.png
# Saída: Modelo otimizado para web

python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py ^
    produto.png ^
    produtos\produto_web.glb ^
    --quality medium ^
    --remove-bg ^
    --texture-size 1024 ^
    --mc-resolution 128

# Ideal para:
# ✅ Visualizador 3D em site
# ✅ Carregamento rápido
# ✅ Mobile-friendly
```

### Exemplo 3: Batch - Múltiplas Imagens

```bash
# Processar pasta inteira
TRANSFORM_IMAGE_TO_3D_LOCAL.bat

# Escolher opção [3] Processar pasta
# Digite: MINHAS_IMAGENS_TESTE
# Aguarde processamento de todas
```

---

## 💡 Dicas e Truques

### 📸 Como Tirar a Foto Perfeita

**✅ FAÇA:**
- Ilumine bem o objeto
- Use fundo liso (branco, cinza, verde)
- Centralize o objeto
- Mantenha distância adequada
- Evite sombras fortes

**❌ NÃO FAÇA:**
- Fundo bagunçado
- Objeto cortado
- Muito escuro ou claro
- Imagem tremida/borrada
- Reflexos intensos

### ⚙️ Configurações Recomendadas

#### Para Fotos de Pessoas:
```
--quality: high
--remove-bg: sim
--texture-size: 2048
--mc-resolution: 256
```

#### Para Objetos Pequenos:
```
--quality: high
--remove-bg: sim
--texture-size: 2048
--mc-resolution: 512  (mais detalhes)
```

#### Para Processamento Rápido:
```
--quality: low
--texture-size: 1024
--mc-resolution: 128
```

### 🚀 Otimizações de Performance

**Se está lento ou travando:**

1. **Reduza resolução:**
   ```bash
   --mc-resolution 128  # ao invés de 256
   ```

2. **Feche programas pesados:**
   - Navegadores com muitas abas
   - Jogos
   - Outros apps usando GPU

3. **Limpe cache da GPU:**
   ```python
   import torch
   torch.cuda.empty_cache()
   ```

4. **Use imagem menor:**
   - Redimensione para 1024x1024 antes

---

## 🔧 Troubleshooting

### ❌ Erro: "CUDA out of memory"

**Causa:** GPU sem VRAM suficiente

**Soluções:**
```bash
# 1. Reduza resolução
--mc-resolution 128

# 2. Reduza textura
--texture-size 1024

# 3. Feche outros apps
# 4. Reinicie o PC
```

### ❌ Erro: "Model not found"

**Causa:** Modelo TripoSR não baixado

**Solução:**
```bash
# Execute o downloader:
4-DOWNLOAD_3D_MODELS.bat
```

### ❌ Erro: "No module named 'rembg'"

**Causa:** Biblioteca de remoção de fundo não instalada

**Solução:**
```bash
.venv311\Scripts\pip.exe install rembg
```

**OU** use sem `--remove-bg`:
```bash
python AIEXX_IMAGE_TO_3D.py foto.png  # sem --remove-bg
```

### ❌ Modelo 3D com qualidade ruim

**Possíveis causas e soluções:**

1. **Imagem de baixa qualidade:**
   - Use imagem com pelo menos 512x512
   - Evite imagens muito comprimidas (JPG baixa qualidade)

2. **Configuração baixa:**
   ```bash
   # Aumente qualidade:
   --quality high
   --mc-resolution 512
   --texture-size 4096
   ```

3. **Objeto mal enquadrado:**
   - Recorte/edite a imagem primeiro
   - Centralize o objeto
   - Use `--remove-bg`

### ❌ ComfyUI não abre

**Soluções:**

1. **Verifique se porta 8188 está livre:**
   ```bash
   netstat -ano | findstr :8188
   ```

2. **Tente outra porta:**
   ```bash
   cd ComfyUI
   ..\\.venv311\\Scripts\\python.exe main.py --port 8189
   ```

3. **Verifique logs:**
   ```bash
   START_AIEXX.log
   ```

---

## 📊 Benchmarks de Performance

### RTX 5060 (8GB VRAM)

| Resolução MC | Textura | Tempo Médio | VRAM Usada | Qualidade |
|--------------|---------|-------------|------------|-----------|
| 128 | 1024 | ~25s | 2.8 GB | ⭐⭐ |
| 256 | 2048 | ~40s | 4.2 GB | ⭐⭐⭐⭐ |
| 512 | 4096 | ~90s | 6.8 GB | ⭐⭐⭐⭐⭐ |

### Comparação de Qualidade vs Velocidade

```
QUALIDADE    VELOCIDADE    USO      QUANDO USAR
═══════════════════════════════════════════════════════════
Low          ████████████  2.8GB    • Testes rápidos
Medium       ████████      4.2GB    • Uso geral ⭐
High         ████          6.8GB    • Qualidade final
```

---

## 🎓 Próximos Passos

Depois de dominar o básico:

1. **Explore outros workflows:**
   ```
   workflows/3d/01_zero123_multiview.json
   workflows/3d/02_multiview_to_mesh_instantmesh.json
   ```

2. **Integre com Blender:**
   - Importe GLB
   - Edite malha
   - Adicione materiais
   - Renderize

3. **Crie animações:**
   - Use Mixamo para rigging
   - Anime no Blender
   - Exporte para Unity/Unreal

4. **Automatize:**
   - Crie scripts batch
   - Configure CI/CD
   - Integre com pipeline

---

## 📚 Recursos Adicionais

- 📖 [Documentação Completa](./README.md)
- 🎨 [Workflows Disponíveis](../04-WORKFLOWS/WORKFLOWS_DISPONIVEIS.md)
- 🔧 [Troubleshooting Geral](./TROUBLESHOOTING_BATCH_FILES.md)
- 🚀 [Guia de Instalação](./README_INSTALLATION_GUIDE.md)

---

## 💬 Suporte

Se tiver dúvidas:

1. **Verifique troubleshooting** acima
2. **Leia documentação** completa
3. **Abra issue** no GitHub com:
   - Mensagem de erro completa
   - Passos para reproduzir
   - Specs do sistema

---

**🎉 Agora você está pronto para transformar QUALQUER imagem em 3D usando sua própria GPU!**

**💰 Lembre-se: Cada modelo que você criar custa R$ 0,00 - totalmente FREE!**

---

<div align="center">

**Desenvolvido com ❤️ pela equipe AIEXX**

[![GPU](https://img.shields.io/badge/GPU-Powered-76B900?style=for-the-badge&logo=nvidia)](https://www.nvidia.com/)
[![Local](https://img.shields.io/badge/100%25-LOCAL-blue?style=for-the-badge)](.)
[![Free](https://img.shields.io/badge/CUSTO-R$%200,00-green?style=for-the-badge)](.)

</div>


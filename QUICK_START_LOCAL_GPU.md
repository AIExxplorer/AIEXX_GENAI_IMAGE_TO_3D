# 🚀 QUICK START - Image to 3D Local GPU

## ⚡ Início Rápido (5 minutos)

### 1️⃣ Coloque sua imagem

Copie sua foto para a pasta:
```
MINHAS_IMAGENS_TESTE\
```

### 2️⃣ Escolha um método

#### 🖱️ Método 1: Arrasta e Solta (MAIS FÁCIL)
```
Arraste sua imagem → TRANSFORM_IMAGE_TO_3D_LOCAL.bat
```

#### 💻 Método 2: Linha de Comando
```bash
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D.py MINHAS_IMAGENS_TESTE\sua_foto.png
```

#### 🎨 Método 3: ComfyUI (Interface Gráfica)
```bash
START.bat
# Abra: http://localhost:8188
# Load: workflows/3d/AIEXX_image_to_3d_LOCAL_GPU.json
```

### 3️⃣ Aguarde 30-60 segundos

### 4️⃣ Pegue seu modelo 3D
```
📁 output_3d\sua_foto_3D.glb
```

### 5️⃣ Visualize
- 🌐 Online: https://3dviewer.net
- 🎨 Blender: File > Import > glTF
- 🎮 Unity: Arraste para Assets

---

## 💰 Custo: R$ 0,00

✅ **100% Local - Sem API - Sem Mensalidades**

---

## ⚙️ Opções Avançadas

### Alta Qualidade
```bash
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py ^
    MINHAS_IMAGENS_TESTE\sua_foto.png ^
    output_3d\modelo_HD.glb ^
    --quality high ^
    --remove-bg ^
    --texture-size 2048
```

### Rápido (Low Quality)
```bash
python 02-PYTHON-SCRIPTS\AIEXX_IMAGE_TO_3D_ADVANCED.py ^
    MINHAS_IMAGENS_TESTE\sua_foto.png ^
    --quality low ^
    --mc-resolution 128
```

### Processamento em Lote
```bash
TRANSFORM_IMAGE_TO_3D_LOCAL.bat
# Escolha opção [3]
# Digite: MINHAS_IMAGENS_TESTE
```

---

## 📋 Requisitos do Sistema

| Item | Requisito |
|------|-----------|
| GPU | NVIDIA com CUDA (RTX 5060 ou similar) |
| VRAM | 4GB mínimo, 8GB recomendado |
| RAM | 16GB |
| Espaço | ~55GB |
| SO | Windows 10/11 |

---

## 🎯 Dicas Rápidas

### Para Fotos de Pessoas:
```bash
--quality high --remove-bg
```

### Para Objetos Pequenos:
```bash
--quality high --mc-resolution 512
```

### Para Teste Rápido:
```bash
--quality low --mc-resolution 128
```

---

## ❓ Problemas?

### Erro "CUDA out of memory"
```bash
# Use configuração mais leve:
--quality low --mc-resolution 128
```

### Erro "Model not found"
```bash
# Baixe os modelos:
4-DOWNLOAD_3D_MODELS.bat
```

### Qualidade ruim
```bash
# Use configurações melhores:
--quality high --mc-resolution 512 --texture-size 4096
```

---

## 📚 Documentação Completa

Para guia detalhado, veja:
- 📖 [COMO_USAR_LOCAL_GPU.md](03-DOCUMENTATION/COMO_USAR_LOCAL_GPU.md)
- 🚀 [README.md](README.md)

---

## 🎉 Pronto!

**Você está pronto para criar modelos 3D ilimitados de graça!**

**💰 Economia comparada ao Tripo API:**
- 10 modelos: ~R$ 5,00 - R$ 12,50
- 100 modelos: ~R$ 50,00 - R$ 125,00
- 1000 modelos: ~R$ 500,00 - R$ 1.250,00

**Com AIEXX Local: R$ 0,00 sempre! 🎊**


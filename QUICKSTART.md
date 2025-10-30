# Guia de Início Rápido - ComfyUI 3D Pipeline

Este guia vai te ajudar a configurar e executar o pipeline completo de geração 3D em menos de 30 minutos.

## Pré-requisitos

Antes de começar, certifique-se de ter:

- [ ] **Windows** com PowerShell
- [ ] **Python 3.11+** instalado e no PATH
- [ ] **Git** instalado
- [ ] **Blender 3.x ou 4.x** instalado (para exportação FBX)
- [ ] **Conta Hugging Face** com token de API
- [ ] **GPU compatível** (recomendado: NVIDIA com 8GB+ VRAM ou AMD com DirectML)
- [ ] **50-100 GB** de espaço em disco livre

---

## Passo 1: Obter Token do Hugging Face

1. Acesse: https://huggingface.co/settings/tokens
2. Clique em **"New token"**
3. Nome: `ComfyUI-3D-Pipeline`
4. Tipo: **Read**
5. Copie o token (começa com `hf_`)

---

## Passo 2: Configurar Ambiente

Abra PowerShell no diretório `C:\ComfyUI` e execute:

```powershell
# Configurar token do Hugging Face
.\setup_env.ps1 -HF_TOKEN "seu_token_aqui"
```

**Exemplo**:
```powershell
.\setup_env.ps1 -HF_TOKEN "hf_SEU_TOKEN_AQUI"
```

O script vai:
- ✓ Configurar variável de ambiente `HUGGING_FACE_HUB_TOKEN`
- ✓ Criar arquivo `.env`
- ✓ Verificar configuração

**Importante**: Reinicie o PowerShell após este passo!

---

## Passo 3: Criar Estrutura de Diretórios

```powershell
.\create_directories.ps1
```

Isso vai criar:
- `ComfyUI/models/` (modelos AI)
- `exports/` (arquivos 3D exportados)
- `workflows/3d/` (workflows ComfyUI)
- `tools/` e `scripts/` (utilitários)

---

## Passo 4: Baixar Modelos

```powershell
# Baixar todos os modelos (recomendado)
.\download_models.ps1

# OU baixar modelos específicos
.\download_models.ps1 -Models controlnet,triposr
```

**Tempo estimado**: 30-60 minutos (dependendo da conexão)

**Tamanho total**: ~25-40 GB

### Modelos que serão baixados:

1. **ControlNet SD1.5** (~5 GB)
   - Depth, OpenPose, Canny, Tile

2. **Zero123 / Zero123++** (~5-8 GB)
   - Multi-view generation

3. **TripoSR** (~8-10 GB)
   - Reconstrução 3D rápida

4. **InstantMesh** (~10-15 GB)
   - Reconstrução 3D de alta qualidade

### Acompanhar progresso:

Em outra janela PowerShell:
```powershell
.\monitor_status.ps1 -Live
```

Ou verificar resumo:
```powershell
.\monitor_status.ps1 -Summary
```

---

## Passo 5: Verificar Instalação

```powershell
.\monitor_status.ps1 -Models
```

Você deve ver algo como:
```
ControlNet SD1.5:
  [OK] control_v11f1p_sd15_depth.safetensors (1433.52 MB)
  [OK] control_v11p_sd15_openpose.safetensors (1456.32 MB)
  ...

Resumo: 10 de 10 arquivos encontrados
```

---

## Passo 6: Instalar Dependências do ComfyUI

Se você ainda não tem o ComfyUI configurado:

```powershell
cd ComfyUI
python -m pip install -r requirements.txt
```

Instalar nodes personalizados necessários:

```powershell
cd custom_nodes

# ComfyUI-3D-Pack (TripoSR, InstantMesh, etc)
git clone https://github.com/MrForExample/ComfyUI-3D-Pack
cd ComfyUI-3D-Pack
pip install -r requirements.txt
cd ..

# ComfyUI-Zero123 (se disponível)
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-zero123
# OU procurar alternativa no ComfyUI Manager

cd ..\..
```

---

## Passo 7: Executar ComfyUI

```powershell
cd ComfyUI
python main.py
```

Ou se estiver usando GPU AMD com DirectML:
```powershell
python main.py --directml
```

Acesse: http://localhost:8188

---

## Passo 8: Testar Pipeline

### Teste 1: TripoSR (Mais simples)

1. Abra ComfyUI no navegador
2. Carregar workflow: `workflows/3d/03_triposr_single_image_to_mesh.json`
3. Carregar uma imagem de teste
4. Clique em **"Queue Prompt"**
5. Aguarde processamento (~2-5 minutos)
6. Verifique output em: `exports/obj/`

### Teste 2: Zero123++ Multi-View

1. Carregar workflow: `workflows/3d/01_zero123_multiview.json`
2. Carregar imagem de entrada
3. Ajustar parâmetros:
   - `num_views`: 6
   - `elevation`: 30
4. Executar workflow
5. Verificar vistas geradas

### Teste 3: Pipeline Completo

1. Gerar multi-view com workflow 01
2. Usar vistas no workflow 02 (InstantMesh)
3. Exportar para OBJ/FBX/STL/GLB
4. Abrir em Blender/Maya para verificar

---

## Exportação FBX

Para converter OBJ → FBX:

```powershell
blender -b -P tools\blender_export_fbx.py -- "exports\obj\model.obj" "exports\fbx\model.fbx"
```

---

## Troubleshooting

### Erro: "Token not found"
```powershell
# Reconfigurar token
.\setup_env.ps1 -HF_TOKEN "seu_token"

# Reiniciar PowerShell
```

### Erro: "Out of memory"
- Reduzir `texture_resolution` nos workflows
- Fechar outros programas
- Usar modelos menores (TripoSR em vez de InstantMesh)

### Erro: "Model not found"
```powershell
# Verificar modelos
.\monitor_status.ps1 -Models

# Re-baixar modelos faltantes
.\download_models.ps1 -Models triposr
```

### ComfyUI não carrega workflows
- Verificar se custom nodes estão instalados
- Verificar logs do ComfyUI
- Reinstalar dependencies: `pip install -r requirements.txt`

### Blender não encontrado
```powershell
# Adicionar Blender ao PATH ou especificar caminho completo
"C:\Program Files\Blender Foundation\Blender 4.0\blender.exe" -b -P tools\blender_export_fbx.py -- input.obj output.fbx
```

---

## Próximos Passos

Agora que tudo está configurado:

1. **Explorar workflows**: Abrir e entender cada workflow em `workflows/3d/`
2. **Documentação detalhada**: Ler `workflows/3d/README.md`
3. **Personalizar parâmetros**: Ajustar para seu caso de uso
4. **Integrar com pipeline**: Conectar com Maya/Blender/Unreal/Unity
5. **Automatizar**: Criar batch scripts para processar múltiplas imagens

---

## Recursos Úteis

### Comandos Principais

```powershell
# Monitoramento
.\monitor_status.ps1              # Status geral
.\monitor_status.ps1 -Live        # Log ao vivo
.\monitor_status.ps1 -Models      # Verificar modelos

# Downloads
.\download_models.ps1             # Baixar todos
.\download_models.ps1 -Models controlnet,triposr  # Específicos

# Exportação
blender -b -P tools\blender_export_fbx.py -- input.obj output.fbx
```

### Estrutura de Diretórios

```
C:\ComfyUI\
├── ComfyUI/
│   ├── models/
│   │   ├── controlnet/      # ControlNet SD1.5
│   │   ├── zero123/         # Zero123/Zero123++
│   │   ├── triposr/         # TripoSR
│   │   └── instantmesh/     # InstantMesh
│   └── custom_nodes/        # Nodes ComfyUI
├── workflows/
│   └── 3d/                  # Workflows pipeline 3D
├── exports/
│   ├── obj/                 # Arquivos OBJ
│   ├── fbx/                 # Arquivos FBX
│   ├── stl/                 # Arquivos STL
│   └── glb/                 # Arquivos GLB
├── tools/                   # Scripts utilitários
├── scripts/                 # Scripts auxiliares
├── setup_env.ps1            # Configurar ambiente
├── create_directories.ps1   # Criar estrutura
├── download_models.ps1      # Baixar modelos
├── monitor_status.ps1       # Monitorar status
└── QUICKSTART.md           # Este arquivo
```

### Links Úteis

- **ComfyUI**: https://github.com/comfyanonymous/ComfyUI
- **ComfyUI-3D-Pack**: https://github.com/MrForExample/ComfyUI-3D-Pack
- **Zero123++**: https://huggingface.co/TencentARC/Zero123Plus
- **TripoSR**: https://huggingface.co/stabilityai/TripoSR
- **InstantMesh**: https://huggingface.co/TencentARC/InstantMesh
- **ControlNet**: https://huggingface.co/lllyasviel/ControlNet-v1-1

---

## Suporte

Para problemas ou dúvidas:

1. Verificar logs: `downloads_status.log`
2. Verificar status: `.\monitor_status.ps1 -Summary`
3. Consultar README detalhado: `workflows/3d/README.md`
4. Issues no GitHub do projeto

---

**Versão**: 1.0
**Última atualização**: 2025-10-30
**Projeto**: AIEXX GenAI Image to 3D

Bom uso! 🚀

# Checklist de Configuração - ComfyUI 3D Pipeline

Use este checklist para garantir que tudo está configurado corretamente antes de começar a usar o pipeline.

## Fase 1: Pré-requisitos

- [ ] **Sistema Operacional**: Windows 10/11
- [ ] **PowerShell**: Versão 5.1+ (verificar: `$PSVersionTable.PSVersion`)
- [ ] **Python**: 3.11+ instalado (verificar: `python --version`)
- [ ] **Git**: Instalado (verificar: `git --version`)
- [ ] **Blender**: 3.x ou 4.x instalado (verificar: `blender --version`)
- [ ] **Espaço em Disco**: Mínimo 50 GB livres
- [ ] **GPU**: NVIDIA 8GB+ VRAM ou AMD com DirectML
- [ ] **Conta Hugging Face**: Criada em https://huggingface.co

---

## Fase 2: Configuração Inicial

- [ ] **Token HF obtido**: Acessar https://huggingface.co/settings/tokens
- [ ] **Token HF configurado**: Executado `.\setup_env.ps1 -HF_TOKEN "..."`
- [ ] **Variável de ambiente verificada**: `$env:HUGGING_FACE_HUB_TOKEN` retorna valor
- [ ] **Arquivo .env criado**: Existe `C:\ComfyUI\.env`
- [ ] **PowerShell reiniciado**: Para carregar variáveis de ambiente

---

## Fase 3: Estrutura de Diretórios

Execute: `.\create_directories.ps1`

- [ ] `C:\ComfyUI\ComfyUI\models\controlnet` criado
- [ ] `C:\ComfyUI\ComfyUI\models\zero123` criado
- [ ] `C:\ComfyUI\ComfyUI\models\triposr` criado
- [ ] `C:\ComfyUI\ComfyUI\models\instantmesh` criado
- [ ] `C:\ComfyUI\ComfyUI\models\checkpoints` criado
- [ ] `C:\ComfyUI\ComfyUI\models\vae` criado
- [ ] `C:\ComfyUI\ComfyUI\models\loras` criado
- [ ] `C:\ComfyUI\workflows\3d` criado
- [ ] `C:\ComfyUI\exports\obj` criado
- [ ] `C:\ComfyUI\exports\fbx` criado
- [ ] `C:\ComfyUI\exports\stl` criado
- [ ] `C:\ComfyUI\exports\glb` criado
- [ ] `C:\ComfyUI\exports\temp` criado
- [ ] `C:\ComfyUI\tools` criado
- [ ] `C:\ComfyUI\scripts` criado

---

## Fase 4: Download de Modelos

Execute: `.\download_models.ps1`

### ControlNet SD1.5
- [ ] `control_v11f1p_sd15_depth.safetensors` (~1.4 GB)
- [ ] `control_v11p_sd15_openpose.safetensors` (~1.5 GB)
- [ ] `control_v11p_sd15_canny.safetensors` (~1.5 GB)
- [ ] `control_v11f1e_sd15_tile.safetensors` (~1.5 GB)

### Zero123 / Zero123++
- [ ] `105000.ckpt` (Zero123 base, ~5 GB)
- [ ] `zero123plus_v1.1.safetensors` (Zero123++, ~5 GB)

### TripoSR
- [ ] `model.safetensors` (~8 GB)
- [ ] `config.yaml`

### InstantMesh
- [ ] `diffusion_pytorch_model.safetensors` (~10 GB)
- [ ] `config.json`

**Verificar**: Execute `.\monitor_status.ps1 -Models`

---

## Fase 5: Instalação ComfyUI

- [ ] **ComfyUI clonado**: `git clone https://github.com/comfyanonymous/ComfyUI`
- [ ] **Requirements instalados**: `cd ComfyUI && pip install -r requirements.txt`
- [ ] **ComfyUI executa**: `python main.py` (ou `python main.py --directml` para AMD)
- [ ] **Interface acessível**: http://localhost:8188 abre no navegador

---

## Fase 6: Custom Nodes (Obrigatório)

### ComfyUI-3D-Pack (TripoSR, InstantMesh, etc)
- [ ] Clonado: `cd ComfyUI/custom_nodes && git clone https://github.com/MrForExample/ComfyUI-3D-Pack`
- [ ] Dependencies instaladas: `cd ComfyUI-3D-Pack && pip install -r requirements.txt`

### ComfyUI Manager (Recomendado)
- [ ] Clonado: `cd ComfyUI/custom_nodes && git clone https://github.com/ltdrdata/ComfyUI-Manager`

### ComfyUI ControlNet Aux (Para preprocessadores)
- [ ] Clonado: `git clone https://github.com/Fannovel16/comfyui_controlnet_aux`
- [ ] Dependencies: `cd comfyui_controlnet_aux && pip install -r requirements.txt`

---

## Fase 7: Workflows

- [ ] **01_zero123_multiview.json** existe em `workflows/3d/`
- [ ] **02_multiview_to_mesh_instantmesh.json** existe
- [ ] **03_triposr_single_image_to_mesh.json** existe
- [ ] **04_openpose_or_depth_guided_recon.json** existe
- [ ] **README.md** existe em `workflows/3d/` com documentação

---

## Fase 8: Scripts e Ferramentas

- [ ] **setup_env.ps1** existe e executável
- [ ] **create_directories.ps1** existe e executável
- [ ] **download_models.ps1** existe e executável
- [ ] **monitor_status.ps1** existe e executável
- [ ] **tools/blender_export_fbx.py** existe
- [ ] **QUICKSTART.md** existe
- [ ] **CHECKLIST.md** existe (este arquivo)

---

## Fase 9: Teste Funcional

### Teste 1: ComfyUI Básico
- [ ] ComfyUI inicia sem erros
- [ ] Interface carrega corretamente
- [ ] Consegue carregar imagem de teste
- [ ] Nodes estão disponíveis (verificar menu Add Node)

### Teste 2: TripoSR (Teste mais simples)
- [ ] Workflow 03 carrega sem erros
- [ ] Imagem de entrada carregada
- [ ] Workflow executa (Queue Prompt)
- [ ] Processamento completa (~2-5 min)
- [ ] Arquivo OBJ gerado em `exports/obj/`
- [ ] Arquivo abre em Blender/visualizador 3D

### Teste 3: Zero123++ Multi-View
- [ ] Workflow 01 carrega sem erros
- [ ] Gera 6-8 vistas de diferentes ângulos
- [ ] Vistas são consistentes e reconhecíveis
- [ ] Vistas salvas em `ComfyUI/output/multiview/`

### Teste 4: InstantMesh
- [ ] Workflow 02 carrega sem erros
- [ ] Aceita multi-view como entrada
- [ ] Gera malha 3D com texturas
- [ ] Arquivos exportados: OBJ + MTL + texturas

### Teste 5: Exportação FBX
- [ ] Script Blender executa sem erros
- [ ] OBJ converte para FBX
- [ ] FBX abre em Blender/Maya/Cinema 4D
- [ ] Materiais e UV mapping preservados

### Teste 6: ControlNet
- [ ] Workflow 04 carrega sem erros
- [ ] Preprocessadores baixam automaticamente
- [ ] Gera imagens condicionadas (depth/pose/canny)
- [ ] Qualidade é adequada

---

## Fase 10: Integração com Pipeline

### Maya
- [ ] Import OBJ funciona
- [ ] Escala está correta (cm)
- [ ] UV mapping está correto
- [ ] Materiais mapeiam corretamente

### Blender
- [ ] Import OBJ/FBX/GLB funciona
- [ ] Texturas carregam automaticamente
- [ ] Geometria está limpa (sem duplicados)

### After Effects + Element 3D
- [ ] FBX importa em Element 3D
- [ ] Texturas mapeiam corretamente
- [ ] Escala está adequada

### Unreal Engine / Unity
- [ ] FBX ou GLB importa
- [ ] Materiais PBR funcionam
- [ ] Collision mesh (STL) importa

### Impressão 3D
- [ ] STL exporta corretamente
- [ ] Mesh é watertight (sem furos)
- [ ] Escala está em mm
- [ ] Fatiador aceita o arquivo (Cura/PrusaSlicer)

---

## Fase 11: Otimização e Performance

- [ ] **GPU detectada**: ComfyUI reconhece GPU (verificar logs)
- [ ] **VRAM suficiente**: Modelos carregam sem OOM
- [ ] **Tempo de processamento aceitável**:
  - TripoSR: 2-5 min por imagem
  - Zero123++: 5-10 min para 6-8 vistas
  - InstantMesh: 10-20 min para reconstrução completa
- [ ] **Qualidade de output satisfatória**:
  - Geometria sem artefatos graves
  - Texturas nítidas e bem mapeadas
  - UV mapping sem distorções

---

## Fase 12: Documentação e Backup

- [ ] **README.md** lido e compreendido
- [ ] **QUICKSTART.md** seguido passo a passo
- [ ] **workflows/3d/README.md** consultado para parâmetros
- [ ] **Backup de modelos**: Modelos baixados salvos externamente
- [ ] **Backup de workflows**: Workflows personalizados salvos
- [ ] **Token HF seguro**: Token armazenado com segurança

---

## Troubleshooting Comum

Se algum item falhou, consulte as soluções:

### Token HF não funciona
```powershell
# Reconfigurar
.\setup_env.ps1 -HF_TOKEN "seu_token_novo"
# Reiniciar PowerShell
```

### Modelos não baixam
- Verificar conexão com internet
- Verificar espaço em disco
- Verificar se precisa aceitar licença no HF (algumas models exigem)
- Tentar download manual e colocar em `ComfyUI/models/`

### ComfyUI não inicia
```powershell
# Reinstalar requirements
cd ComfyUI
pip install --upgrade -r requirements.txt

# Verificar Python
python --version  # deve ser 3.11+

# Verificar GPU
python -c "import torch; print(torch.cuda.is_available())"
```

### Workflows não carregam
- Verificar custom nodes instalados
- Verificar logs do ComfyUI para erros
- Instalar ComfyUI Manager para instalar nodes faltantes automaticamente

### Out of Memory
- Reduzir `texture_resolution` nos workflows
- Usar menos vistas no Zero123++ (6 em vez de 8)
- Fechar outros programas
- Usar TripoSR em vez de InstantMesh (menos VRAM)

### Blender não encontrado
```powershell
# Verificar instalação
blender --version

# Se não estiver no PATH, usar caminho completo
"C:\Program Files\Blender Foundation\Blender 4.0\blender.exe" --version

# Adicionar ao PATH (PowerShell como Admin)
$env:Path += ";C:\Program Files\Blender Foundation\Blender 4.0"
```

### Exportações com erros
- Verificar geometria está limpa (sem faces internas)
- Verificar UV mapping existe
- Simplificar malha se muito complexa
- Tentar exportar primeiro para OBJ (mais simples)

---

## Status Final

Data: _______________

Todas as fases completadas? [ ] Sim [ ] Não

Se não, fases pendentes:
- ___________________________________
- ___________________________________
- ___________________________________

Observações:
_______________________________________________
_______________________________________________
_______________________________________________

---

## Próximos Passos Após Completar Checklist

1. **Experimentar com suas próprias imagens**
2. **Ajustar parâmetros dos workflows** para seu caso de uso
3. **Criar workflows personalizados**
4. **Automatizar pipeline** com batch scripts
5. **Integrar com seu software 3D principal**
6. **Explorar custom nodes adicionais**
7. **Compartilhar resultados e feedback**

---

**Versão**: 1.0
**Última atualização**: 2025-10-30
**Projeto**: AIEXX GenAI Image to 3D

Boa configuração! 🎯

# Workflows 3D - ComfyUI Pipeline

Este diretório contém workflows para o pipeline completo de geração 3D: imagem → multi-view → malha 3D → exportação.

## Estrutura dos Workflows

### 01_zero123_multiview.json
**Propósito**: Gerar múltiplas vistas de um objeto a partir de uma única imagem

**Inputs**:
- Imagem única (512x512 ou 1024x1024 recomendado)
- Fundo limpo, objeto centralizado

**Parâmetros Principais**:
- `views`: 4, 6 ou 8 (recomendado: 6-8 para melhor reconstrução)
- `seed`: controle de aleatoriedade
- `guidance`: 3.0-4.0 (aumentar para mais fidelidade à entrada)
- `elevation`: 20-45 graus (ângulo vertical da câmera)

**Outputs**:
- 6-8 imagens de diferentes ângulos azimutais
- Salvos em: `ComfyUI/output/multiview/`

**Modelos Necessários**:
- Zero123++ v1.1 (recomendado): `zero123plus_v1.1.safetensors`
- Alternativa: Zero123 XL: `105000.ckpt`
- Localização: `C:\ComfyUI\ComfyUI\models\zero123\`

**Como Criar no ComfyUI**:
1. Adicionar nó `Load Image` para entrada
2. Adicionar nó `Zero123 Model Loader`
3. Adicionar nó `Zero123 Multi-View Generator`
4. Conectar: Image → Generator + Model → Generator
5. Adicionar nós `Preview Image` e `Save Image` para outputs

---

### 02_multiview_to_mesh_instantmesh.json
**Propósito**: Reconstruir malha 3D a partir de múltiplas vistas usando InstantMesh

**Inputs**:
- 6-8 imagens multi-view (output do workflow 01)
- Ou: batch de imagens carregadas

**Parâmetros Principais**:
- `texture_resolution`: 1024, 2048 ou 4096 (qualidade da textura)
- `clean_up`: remover geometria solta/artefatos
- `remesh`: retriangular para topologia uniforme
- `target_faces`: número de faces (10K-100K)

**Outputs**:
- Malha 3D com texturas
- Formatos: OBJ (+ MTL + texturas), GLB, STL, FBX
- Salvos em: `C:\ComfyUI\exports\{obj,fbx,stl,glb}\`

**Modelos Necessários**:
- InstantMesh: `diffusion_pytorch_model.safetensors` + `config.json`
- Localização: `C:\ComfyUI\ComfyUI\models\instantmesh\`

**Pipeline de Exportação**:
1. Reconstrução → mesh bruto
2. Cleanup (opcional) → remover artefatos
3. Remesh (opcional) → topologia uniforme
4. Export OBJ → com UV + MTL
5. Export FBX → via Blender headless (script separado)
6. Export STL → para impressão 3D (binário, watertight)
7. Export GLB → para web/realtime (texturas embutidas, Draco opcional)

**Configurações de Exportação**:

**OBJ**:
- UV mapping preservado
- MTL com caminhos relativos
- Sem triangulação (compat Maya/ZBrush)
- Escala: cm (consistente)
- Texturas separadas (PNG/JPG)

**FBX** (via Blender):
- FBX 2018/2019 (compat After Effects/Cinema 4D)
- Sem embed textures (manter arquivos separados)
- Smoothing groups ON
- Tangents ON
- Bake transform

**STL**:
- Binário (menor, mais rápido)
- Somente geometria (sem cor/textura)
- Unidades: mm (padrão impressão 3D)
- Watertight (sem furos)

**GLB**:
- Texturas embutidas
- PBR básico (base color + normal + roughness)
- Draco opcional (compressão)
- Optimizado para web/realtime

---

### 03_triposr_single_image_to_mesh.json
**Propósito**: Reconstrução direta imagem → malha 3D usando TripoSR (método alternativo mais rápido)

**Inputs**:
- Imagem única
- Fundo transparente ou limpo recomendado

**Parâmetros Principais**:
- `texture_resolution`: 1024 ou 2048
- `scale_units`: cm ou m
- `mesh_simplification`: % de redução (0-50%)

**Outputs**:
- Malha 3D (mesmos formatos que workflow 02)

**Modelos Necessários**:
- TripoSR: `model.safetensors` + `config.yaml`
- Localização: `C:\ComfyUI\ComfyUI\models\triposr\`

**Vantagens vs Zero123++**:
- Mais rápido (1 imagem → direto para malha)
- Menos VRAM necessária
- Boa para objetos simples/simétricos

**Desvantagens**:
- Menor detalhe em objetos complexos
- Menos controle sobre vistas intermediárias

---

### 04_openpose_or_depth_guided_recon.json
**Propósito**: Reconstrução guiada por pose/depth usando ControlNet

**Inputs**:
- Imagem base
- Control type: openpose, depth, canny ou normal

**Parâmetros Principais**:
- `controlnet_model`: tipo de controle
- `guidance`: 2.0-3.5 (força do condicionamento)
- `preprocessor`: automático ou manual

**Outputs**:
- Imagens condicionadas → feed para workflow 02 ou 03

**Modelos Necessários**:
- ControlNet SD1.5:
  - `control_v11p_sd15_openpose.safetensors`
  - `control_v11f1p_sd15_depth.safetensors`
  - `control_v11p_sd15_canny.safetensors`
  - `control_v11f1e_sd15_tile.safetensors`
- Localização: `C:\ComfyUI\ComfyUI\models\controlnet\`

**Preprocessadores** (download automático na primeira execução):
- OpenPose: body, hand, face (separados)
- Depth: MiDaS, ZoeDepth
- Canny: threshold ajustável
- Normal: Bae Normal

**Casos de Uso**:
- OpenPose: personagens/criaturas humanoides
- Depth: arquitetura, interiores, objetos com profundidade clara
- Canny: objetos com bordas nítidas
- Normal: controle de iluminação/superfície

---

## Ordem Recomendada de Execução

### Pipeline Completo (Qualidade Máxima):
```
Imagem → 01_zero123_multiview → 02_multiview_to_mesh_instantmesh → Exports
```

### Pipeline Rápido (Prototipagem):
```
Imagem → 03_triposr_single_image_to_mesh → Exports
```

### Pipeline Guiado (Controle Específico):
```
Imagem → 04_openpose_or_depth_guided → 01_zero123_multiview → 02_multiview_to_mesh → Exports
```

---

## Checklist Pré-Execução

### Modelos Instalados:
- [ ] Zero123++: `C:\ComfyUI\ComfyUI\models\zero123\zero123plus_v1.1.safetensors`
- [ ] InstantMesh: `C:\ComfyUI\ComfyUI\models\instantmesh\diffusion_pytorch_model.safetensors`
- [ ] TripoSR: `C:\ComfyUI\ComfyUI\models\triposr\model.safetensors`
- [ ] ControlNet SD1.5 (4 arquivos): `C:\ComfyUI\ComfyUI\models\controlnet\*.safetensors`

### Ambiente:
- [ ] Token HF configurado: `$env:HUGGING_FACE_HUB_TOKEN`
- [ ] Python 3.11 com DirectML ou CUDA
- [ ] Blender instalado (para export FBX)

### Diretórios:
- [ ] `C:\ComfyUI\exports\{obj,fbx,stl,glb}` criados
- [ ] `C:\ComfyUI\workflows\3d` criado
- [ ] `C:\ComfyUI\tools` criado

---

## Otimização e Limpeza

Antes de exportar, execute checklist de `00_cleanup_optimize.README.txt`:

1. **Remover vértices duplicados** (threshold 0.0001)
2. **Remover faces internas** (não visíveis)
3. **Recalcular normais** (outside)
4. **Remeshing** (target poly count)
5. **UV unwrap** (Smart UV Project ou Lightmap)
6. **Bake textures** (se necessário consolidar)
7. **Escala consistente** (verificar units)
8. **Pivot point** (centrar na origem)

---

## Troubleshooting

### Problema: "Model not found"
**Solução**: Execute `.\download_models.ps1` para baixar modelos faltantes

### Problema: "Out of memory"
**Solução**:
- Reduzir `texture_resolution` (2048 → 1024)
- Reduzir `num_views` (8 → 6 ou 4)
- Fechar outros programas

### Problema: "Export failed" (FBX)
**Solução**:
- Verificar Blender instalado e no PATH
- Testar export OBJ primeiro (mais simples)
- Verificar script: `C:\ComfyUI\tools\blender_export_fbx.py`

### Problema: Malha com buracos/artefatos
**Solução**:
- Aumentar `num_views` (6 → 8)
- Ajustar `elevation` (tentar 30-40 graus)
- Habilitar `clean_up` no workflow 02
- Usar fundo mais limpo na imagem de entrada

### Problema: Texturas incorretas
**Solução**:
- Aumentar `texture_resolution`
- Verificar UV mapping (deve estar entre 0-1)
- Re-bake textures em resolução maior

---

## Acompanhamento de Progresso

Logs em tempo real:
```powershell
Get-Content "C:\ComfyUI\downloads_status.log" -Wait
```

Status resumido:
```powershell
Get-Content "C:\ComfyUI\workflows\3d\STATUS.txt"
```

---

## Exportações para Software Específico

### Maya:
- Formato: **OBJ** (preserva UV, smoothing)
- Import settings: cm, Y-up
- Material: Standard Surface com file textures

### ZBrush:
- Formato: **OBJ** (sem triangulação)
- Import settings: flip Z se necessário
- GoZ para round-trip

### After Effects + Element 3D:
- Formato: **FBX 2018** ou **OBJ**
- Texturas: PNG/JPG separadas
- Escala: verificar units (cm recomendado)

### Cinema 4D:
- Formato: **FBX 2019** ou **OBJ**
- Import settings: cm, Y-up

### Blender:
- Formato: **GLB** (mais simples) ou **FBX**
- Import settings: automático

### Unreal Engine / Unity:
- Formato: **FBX** ou **GLB**
- Texturas: PBR (BaseColor, Normal, Roughness, Metallic)
- Collision: STL mesh simplificado

### Impressão 3D:
- Formato: **STL** (binário, watertight)
- Unidades: mm
- Verificar em Meshmixer/Netfabb antes de fatiar

---

## Próximos Passos

1. **Baixar modelos**: `.\download_models.ps1`
2. **Testar workflows**: começar com 03 (mais simples)
3. **Refinar parâmetros**: ajustar para seu caso de uso
4. **Automatizar**: criar batch scripts para pipeline completo
5. **Integrar**: conectar com seus softwares de pipeline 3D

---

## Referências

- Zero123++: https://huggingface.co/TencentARC/Zero123Plus
- InstantMesh: https://huggingface.co/TencentARC/InstantMesh
- TripoSR: https://huggingface.co/stabilityai/TripoSR
- ControlNet: https://huggingface.co/lllyasviel/ControlNet-v1-1

---

**Versão**: 1.0
**Última atualização**: 2025-10-30
**Projeto**: AIEXX GenAI Image to 3D

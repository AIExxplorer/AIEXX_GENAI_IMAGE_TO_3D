# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-10-30

### 🎉 Release Inicial

Este é o primeiro release do **AIEXX GenAI Image to 3D**, estabelecendo a fundação completa do projeto.

### ✨ Added (Adicionado)

#### Estrutura do Projeto
- Estrutura completa de diretórios para ComfyUI, modelos, workflows e exportações
- Sistema de organização de arquivos com pastas dedicadas para cada tipo de modelo
- Diretórios de exportação para OBJ, FBX, STL e GLB

#### Scripts de Automação
- **setup_env.ps1**: Configuração de token Hugging Face em variáveis de ambiente
- **create_directories.ps1**: Criação automática de estrutura de diretórios
- **download_models.py**: Download automatizado de modelos do Hugging Face com:
  - Sistema de retry e verificação de integridade
  - Suporte a múltiplos modelos e priorização
  - Logging detalhado de progresso
  - Resumo final de downloads
- **download_models.ps1**: Wrapper PowerShell para execução simplificada
- **monitor_status.ps1**: Monitoramento de status de downloads e verificação de modelos
- **tools/blender_export_fbx.py**: Script de conversão OBJ → FBX via Blender headless

#### Modelos de IA (12 arquivos, ~20 GB)
- ✅ **ControlNet SD1.5**: 4 modelos .pth (depth, openpose, canny, tile)
  - Repositório: lllyasviel/ControlNet-v1-1
  - Total: ~5.8 GB
- ✅ **Zero123**: Modelo base para geração multi-view
  - Arquivo: 105000.ckpt
  - Repositório: cvlab/zero123-weights
  - Tamanho: ~4.5 GB
- ✅ **Zero123++ v1.2**: Componentes diffusers para multi-view avançado
  - Arquivos: unet, vae, text_encoder, vision_encoder
  - Repositório: sudo-ai/zero123plus-v1.2
  - Tamanho: ~3.5 GB
- ✅ **TripoSR**: Reconstrução 3D single-image
  - Arquivos: model.ckpt, config.yaml
  - Repositório: stabilityai/TripoSR
  - Tamanho: ~1.7 GB
- ✅ **InstantMesh**: Reconstrução 3D multi-view (modelo large)
  - Arquivo: instant_mesh_large.ckpt
  - Repositório: TencentARC/InstantMesh
  - Tamanho: ~5 GB

#### Workflows ComfyUI
- **01_zero123_multiview.json**: Geração de múltiplas vistas com Zero123++
- **02_multiview_to_mesh_instantmesh.json**: Conversão multi-view para malha 3D
- **03_triposr_single_image_to_mesh.json**: Reconstrução 3D direta de imagem única
- **04_openpose_or_depth_guided_recon.json**: Reconstrução guiada por ControlNet

#### Documentação
- **README.md**: Documentação principal completa com:
  - Badges de status (versão, licença, modelos baixados)
  - Diagramas Mermaid de arquitetura e pipeline
  - Guia de instalação e configuração
  - Documentação de workflows
  - Tabela de compatibilidade de software
- **QUICKSTART.md**: Guia de início rápido (30 minutos)
- **CHECKLIST.md**: Checklist completo de verificação e troubleshooting
- **SECURITY.md**: Guia de boas práticas de segurança
- **MCP_GUIDE.md**: Guia de ferramentas Model Context Protocol
- **workflows/3d/README.md**: Documentação detalhada de workflows e parâmetros
- **TODO.md**: Lista de tarefas e roadmap
- **CHANGELOG.md**: Este arquivo

#### Configuração e Controle de Versão
- **.gitignore**: Proteção completa de tokens, credenciais e arquivos sensíveis
- **package.json**: Configuração do projeto com Husky e commitlint
- **commitlint.config.js**: Validação de Conventional Commits
- **.husky/commit-msg**: Hook de validação automática de commits
- **LICENSE**: Licença MIT
- **.env.example**: Template de variáveis de ambiente

#### Integração Hugging Face
- **.huggingface.yml**: Configuração de metadados do projeto
- **.github/workflows/sync-to-huggingface.yml**: Sincronização automática
- **HUGGING_FACE_SETUP.md**: Guia de configuração do Hugging Face Space

### 🐛 Fixed (Corrigido)

#### Nomes de Arquivos dos Modelos
- **ControlNet**: Corrigida extensão de `.safetensors` para `.pth`
  - Arquivos afetados: depth, openpose, canny, tile
- **Zero123++**: Alterado repositório de TencentARC para sudo-ai/zero123plus-v1.2
  - Estrutura diffusers com 4 componentes separados
- **TripoSR**: Corrigido nome de arquivo de `model.safetensors` para `model.ckpt`
- **InstantMesh**: Especificado arquivo correto `instant_mesh_large.ckpt`

#### Encoding e Logging
- Resolvidos problemas de encoding UTF-8 em logs
- Tratamento de caracteres especiais em mensagens de log

### 🔧 Changed (Modificado)

#### Estrutura de Modelos
- Reorganização da estrutura de pastas de modelos para melhor organização
- Zero123++ agora usa diretório dedicado `zero123plus/` separado de `zero123/`
- Modelos diffusers organizados em subpastas (unet, vae, text_encoder, vision_encoder)

### 📝 Technical Details (Detalhes Técnicos)

#### Tecnologias Utilizadas
- **Python**: 3.11.x
- **Node.js**: 18.x+ (Husky, commitlint)
- **Git**: Controle de versão com Conventional Commits
- **PowerShell**: Scripts de automação Windows
- **Hugging Face Hub**: Download e gerenciamento de modelos
- **ComfyUI**: Framework base para workflows

#### Tamanhos e Estatísticas
- **Total de arquivos criados**: ~25 arquivos (scripts, docs, configs)
- **Total de modelos baixados**: 12 arquivos (~20 GB)
- **Linhas de código**: ~2000+ linhas (Python + PowerShell + JSON)
- **Tempo de download**: ~5-10 minutos (dependendo da conexão)
- **Commits**: 4 commits seguindo Conventional Commits

#### Performance
- Sistema de download com retry automático
- Suporte a resume de downloads interrompidos
- Verificação de integridade de arquivos
- Logging detalhado para debugging

### 🎯 Known Issues (Problemas Conhecidos)

1. **Encoding de Caracteres**: Símbolos Unicode (✓, ✗) podem não exibir corretamente em alguns terminais Windows
   - **Impacto**: Cosmético, não afeta funcionalidade
   - **Workaround**: Logs são salvos corretamente em arquivo

2. **Xet Storage**: Warnings sobre hf_xet package não instalado
   - **Impacto**: Performance de download ligeiramente reduzida
   - **Workaround**: Downloads funcionam normalmente via HTTP padrão

3. **Workflows**: Templates criados mas não testados completamente
   - **Status**: Requer validação prática no ComfyUI

### 🚀 Next Steps (Próximos Passos)

Para v0.2.0:
- [ ] Preencher workflows com nós completos e testados
- [ ] Criar Hugging Face Space
- [ ] Adicionar testes automatizados
- [ ] Criar exemplos de imagens de entrada e saída
- [ ] Documentar parâmetros avançados dos modelos
- [ ] Otimizar performance de download (hf_xet)

### 📊 Statistics (Estatísticas)

```
Repository Statistics (v0.1.0):
├── Files Created: 25+
├── Lines of Code: 2000+
├── Models Downloaded: 12 (100%)
├── Total Download Size: ~20 GB
├── Documentation Pages: 7
├── Scripts: 6 PowerShell + 2 Python
├── Workflows: 4 templates
└── Commits: 4 (Conventional Commits)
```

### 🙏 Acknowledgments (Agradecimentos)

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI) - Framework base
- [Hugging Face](https://huggingface.co/) - Hospedagem de modelos
- [Stability AI](https://stability.ai/) - TripoSR
- [TencentARC](https://github.com/TencentARC) - InstantMesh
- [lllyasviel](https://github.com/lllyasviel) - ControlNet
- [sudo-ai](https://huggingface.co/sudo-ai) - Zero123++ v1.2

---

## Links

- **Repository**: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
- **Release**: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases/tag/v0.1.0
- **Documentation**: [README.md](README.md)
- **Quick Start**: [QUICKSTART.md](QUICKSTART.md)

---

**Desenvolvido com ❤️ por AIEXX**

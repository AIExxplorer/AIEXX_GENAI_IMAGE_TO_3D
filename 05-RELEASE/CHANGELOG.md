# 📋 Changelog - AIEXX GenAI Image to 3D

## [1.0.1] - 2025-01-31

### ✨ Adicionado
- **Numeração sequencial de scripts** - Todos os arquivos `.bat` agora têm numeração (1- a 6-) indicando ordem de execução
- **ORDEM_DE_INSTALACAO.md** - Guia completo com ordem de instalação e troubleshooting
- **Pasta `_deprecated/`** - Arquivos obsoletos movidos para manter organização
- **Troubleshooting aprimorado** - Nova seção para erro "Python was not found"
- **Assinatura ASCII centralizada** - Logo AIEXX agora em tabela centralizada no README.md

### 🔄 Modificado
- **README.md** - Assinatura ASCII centralizada em tabela
- **README.md** - Todas as referências aos scripts atualizadas com numeração
- **README.md** - Adicionado link para ORDEM_DE_INSTALACAO.md
- **Estrutura de arquivos** - Reorganização completa com numeração clara

### 🗑️ Movido para `_deprecated/`
- `install_pytorch_cuda.bat` (versão antiga)
- `install_comfyui_3d_pack.bat` (versão antiga)
- `INSTALL_TORCH_SCATTER.bat` (substituído por 2-FIX_VENV...)
- `SETUP_VENV_AND_TORCH_SCATTER.bat` (substituído por 2-FIX_VENV...)
- `find_vs_buildtools.ps1` (script auxiliar não mais necessário)
- `calculate_sizes.ps1` (script auxiliar não mais necessário)

### 📝 Renomeados
```
INSTALL_VS_BUILDTOOLS_WINGET.bat  → 1-INSTALL_VS_BUILDTOOLS_WINGET.bat
INSTALL_VS_BUILDTOOLS.bat         → 1-INSTALL_VS_BUILDTOOLS.bat
FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat → 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
RUN_INSTALL_3DPACK.bat            → 3-RUN_INSTALL_3DPACK.bat
DOWNLOAD_3D_MODELS.bat            → 4-DOWNLOAD_3D_MODELS.bat
SETUP_SD_MODELS.bat               → 5-SETUP_SD_MODELS.bat
START_AIEXX.bat                   → 6-START_AIEXX.bat
```

### 🐛 Corrigido
- **Confusão de scripts** - Agora está claro qual arquivo executar e em qual ordem
- **Arquivos duplicados** - Removidos scripts obsoletos que causavam confusão
- **Documentação** - Todas as referências atualizadas para novos nomes

---

## [1.0.0] - 2025-01-31

### ✨ Lançamento Inicial
- **README.md profissional** com badges, logos e tabelas
- **.gitignore completo** excluindo arquivos grandes (~55 GB)
- **GitHub Actions** para releases automáticos
- **Versionamento semântico** configurado
- **Sistema completo** de Image to 3D funcionando
- **6 workflows prontos** para uso
- **Modelos AI** instalados (TripoSR, SD 1.5)
- **GPU acceleration** otimizada para RTX 5060

### 📊 Estatísticas
- **Tamanho total:** 55.50 GB
- **Modelos AI:** 38.42 GB (73 arquivos)
- **ComfyUI:** 38.91 GB
- **Python Env:** 16.58 GB
- **Workflows:** 6 prontos
- **Tempo instalação:** ~40-60 minutos

---

## 🔗 Links Importantes

- [README.md](README.md) - Documentação principal
- [ORDEM_DE_INSTALACAO.md](ORDEM_DE_INSTALACAO.md) - Ordem de instalação
- [COMO_USAR.md](COMO_USAR.md) - Guia de uso completo
- [RELEASE_GUIDE.md](RELEASE_GUIDE.md) - Guia de releases

---

## 📝 Formato do Changelog

Este changelog segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e o projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

### Tipos de Mudanças
- **✨ Adicionado** - Novas funcionalidades
- **🔄 Modificado** - Mudanças em funcionalidades existentes
- **🗑️ Obsoleto** - Funcionalidades que serão removidas
- **🐛 Corrigido** - Correções de bugs
- **🔒 Segurança** - Correções de vulnerabilidades

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**
**Powered by AI | Optimized for NVIDIA RTX 5060**

</div>

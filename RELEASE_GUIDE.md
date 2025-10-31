# 🚀 AIEXX - Guia de Release e Versionamento

## ✅ Atualizações Realizadas

### 1. **README.md Profissional** ✨

O README.md foi completamente reformulado com:

- ✅ ASCII art do logo AIEXX no topo
- ✅ Badges profissionais (versão, licença, tecnologias)
- ✅ Logos dos softwares compatíveis (Blender, Unity, Unreal, Maya, etc.)
- ✅ Tabela completa de tecnologias utilizadas
- ✅ Tamanhos dos modelos e do projeto total (55.50 GB)
- ✅ Estrutura visual e intuitiva
- ✅ Documentação técnica detalhada
- ✅ Seções de troubleshooting e roadmap
- ✅ Badges de GitHub (stars, forks, issues)
- ✅ Tabelas de performance e benchmarks

### 2. **.gitignore Profissional** 🔒

Criado/atualizado .gitignore com:

- ✅ Exclusão de modelos grandes (*.ckpt, *.safetensors)
- ✅ Exclusão de ambiente virtual (.venv311/)
- ✅ Exclusão de tokens e credenciais
- ✅ Exclusão de arquivos temporários
- ✅ Manutenção de estrutura de diretórios
- ✅ Comentários organizados por categoria

### 3. **GitHub Actions para Releases Automáticos** ⚙️

Criado workflow `.github/workflows/release.yml` que:

- ✅ Cria release automático a cada push na branch `main`
- ✅ Incrementa versão automaticamente (semver)
- ✅ Gera changelog categorizado (features, fixes, docs, etc.)
- ✅ Cria arquivo ZIP do projeto (sem modelos grandes)
- ✅ Publica release no GitHub com notas completas
- ✅ Atualiza arquivo `VERSION` e `package.json`

### 4. **Arquivos de Versionamento** 📊

- ✅ `VERSION` - Arquivo de versão atual
- ✅ Workflow configurado para criar `package.json` automaticamente

---

## 🎯 Como Fazer Commit e Release

### **Passo 1: Verificar Status do Git**

```batch
git status
```

### **Passo 2: Adicionar Arquivos Modificados**

```batch
git add .
```

### **Passo 3: Fazer Commit com Mensagem Semântica**

Use os prefixos abaixo para categorização automática:

```batch
# Para novas funcionalidades
git commit -m "feat: adiciona novo workflow de alta qualidade"

# Para correções de bugs
git commit -m "fix: corrige erro de importação do torch_scatter"

# Para documentação
git commit -m "docs: atualiza README com informações de GPU"

# Para melhorias de performance
git commit -m "perf: otimiza processamento de imagens"

# Para refatoração
git commit -m "refactor: reorganiza estrutura de workflows"

# Para alterações de build
git commit -m "chore: atualiza dependências do projeto"
```

### **Passo 4: Push para o GitHub**

```batch
git push origin main
```

### **Passo 5: Release Automático** 🎉

O GitHub Actions irá automaticamente:

1. ✅ Detectar o push na branch `main`
2. ✅ Calcular nova versão (incremento do patch: 1.0.0 → 1.0.1)
3. ✅ Gerar changelog baseado nos commits
4. ✅ Criar tag Git (ex: `v1.0.1`)
5. ✅ Criar arquivo ZIP do projeto
6. ✅ Publicar release no GitHub
7. ✅ Atualizar `VERSION` e `package.json`

**Acesse:** https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases

---

## 📋 Exemplo de Commit Completo

```batch
# 1. Verificar o que foi modificado
git status

# 2. Adicionar todos os arquivos
git add .

# 3. Fazer commit com mensagem descritiva
git commit -m "feat: adiciona README profissional com badges e tabelas

- Adiciona ASCII art do logo AIEXX
- Inclui badges de tecnologias (PyTorch, CUDA, etc.)
- Adiciona tabela completa de tecnologias utilizadas
- Documenta tamanhos dos modelos (55.50 GB total)
- Adiciona seção de softwares compatíveis com logos
- Inclui benchmarks de performance RTX 5060

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

# 4. Push para o repositório
git push origin main
```

---

## 🔄 Versionamento Semântico (SemVer)

O projeto segue o padrão **Semantic Versioning 2.0.0**:

```
MAJOR.MINOR.PATCH

Exemplo: 1.2.3
         │ │ └─ Patch: correções de bugs
         │ └─── Minor: novas funcionalidades (compatível)
         └───── Major: mudanças incompatíveis
```

### Quando Incrementar:

| Tipo | Incrementa | Exemplo | Quando usar |
|------|------------|---------|-------------|
| **MAJOR** | 1.0.0 → 2.0.0 | Breaking changes | API incompatível, mudanças drásticas |
| **MINOR** | 1.0.0 → 1.1.0 | Novas features | Novo workflow, novo modelo AI |
| **PATCH** | 1.0.0 → 1.0.1 | Bug fixes | Correções, pequenas melhorias |

### Incremento Automático vs Manual

**Automático (padrão):**
- Todo commit incrementa o PATCH automaticamente
- `1.0.0 → 1.0.1 → 1.0.2 → ...`

**Manual (para MAJOR ou MINOR):**
Se precisar incrementar MAJOR ou MINOR, crie a tag manualmente:

```batch
# Minor release (nova funcionalidade)
git tag -a v1.1.0 -m "Release v1.1.0 - Novo workflow InstantMesh"
git push origin v1.1.0

# Major release (breaking change)
git tag -a v2.0.0 -m "Release v2.0.0 - Nova arquitetura"
git push origin v2.0.0
```

---

## 📊 Monitoramento de Releases

### Ver Releases Publicados

```batch
# Listar todas as tags/releases
git tag -l

# Ver detalhes do último release
git describe --tags --abbrev=0

# Ver changelog desde o último release
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

### Acessar no GitHub

1. Vá para: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases
2. Veja o histórico completo de releases
3. Baixe os arquivos ZIP de qualquer versão

---

## 🎨 Convenções de Commit (Conventional Commits)

Para melhor organização, use estes prefixos:

| Prefixo | Descrição | Aparece no Changelog |
|---------|-----------|---------------------|
| `feat:` | Nova funcionalidade | ✨ Features |
| `fix:` | Correção de bug | 🐛 Bug Fixes |
| `docs:` | Atualização de documentação | 📚 Documentation |
| `perf:` | Melhoria de performance | ⚡ Performance |
| `refactor:` | Refatoração de código | 🔧 Other Changes |
| `test:` | Adição/modificação de testes | 🔧 Other Changes |
| `chore:` | Tarefas de manutenção | 🔧 Other Changes |
| `style:` | Formatação de código | 🔧 Other Changes |
| `ci:` | Mudanças no CI/CD | 🔧 Other Changes |

### Exemplos:

```batch
feat: adiciona suporte para modelos Zero123++
fix: corrige vazamento de memória GPU no TripoSR
docs: atualiza guia de instalação para RTX 5060
perf: otimiza carregamento de texturas em 40%
refactor: reorganiza estrutura de workflows 3D
test: adiciona testes unitários para mesh export
chore: atualiza dependências do PyTorch 2.7.0
style: formata código com black
ci: adiciona workflow de testes automatizados
```

---

## 🚀 Primeiro Release Manual (Opcional)

Se quiser criar o primeiro release manualmente:

```batch
# 1. Fazer commit de todas as mudanças
git add .
git commit -m "feat: release v1.0.0 - sistema AIEXX completo

- README profissional com badges e documentação
- .gitignore configurado para não incluir modelos
- GitHub Actions para releases automáticos
- Sistema completo de Image to 3D com GPU acceleration

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

# 2. Criar tag v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0 - Initial Production Release"

# 3. Push com tags
git push origin main --tags

# 4. O GitHub Actions criará o release automaticamente
```

---

## 📁 Estrutura de Arquivos de Versionamento

```
AIEXX_GENAI_IMAGE_TO_3D/
├── .github/
│   └── workflows/
│       └── release.yml          ← Workflow de releases automáticos
├── VERSION                       ← Versão atual do projeto
├── README.md                     ← README profissional atualizado
├── .gitignore                    ← Git ignore profissional
└── RELEASE_GUIDE.md             ← Este arquivo
```

---

## 🔍 Verificação Antes do Commit

Antes de fazer commit, verifique:

```batch
# 1. Ver arquivos modificados
git status

# 2. Ver diferenças
git diff

# 3. Ver arquivos que serão commitados
git add .
git status

# 4. Ver tamanho do que será enviado
git count-objects -vH
```

---

## ⚠️ Arquivos que NUNCA devem ser commitados

O .gitignore já está configurado para excluir:

- ❌ `.venv311/` - Ambiente virtual Python (16.58 GB)
- ❌ `ComfyUI/models/**/*.ckpt` - Modelos TripoSR (1.60 GB)
- ❌ `ComfyUI/models/**/*.safetensors` - Modelos SD (4.07 GB)
- ❌ `ComfyUI/output/*` - Arquivos 3D gerados
- ❌ `.env` - Variáveis de ambiente
- ❌ `*.token` - Tokens do Hugging Face
- ❌ `.venv*` - Qualquer ambiente virtual

**Total excluído: ~55 GB de arquivos grandes**

---

## 📊 Estatísticas do Projeto

| Item | Tamanho | Status |
|------|---------|--------|
| **README.md** | ~25 KB | ✅ Atualizado |
| **.gitignore** | ~8 KB | ✅ Atualizado |
| **Workflows** | ~5 KB | ✅ Criado |
| **Documentação** | ~200 KB | ✅ Completa |
| **Scripts** | ~50 KB | ✅ Funcionais |
| **Total Commitável** | ~300 KB | ✅ Pronto |

---

## 🎉 Resumo

✅ **README.md profissional** com badges, tabelas e logos
✅ **.gitignore configurado** para excluir arquivos grandes
✅ **GitHub Actions** para releases automáticos
✅ **Versionamento semântico** configurado
✅ **Arquivo VERSION** criado
✅ **Sistema de changelog** automático

**Próximo passo:**
```batch
git add .
git commit -m "feat: adiciona sistema completo de releases automáticos"
git push origin main
```

**O primeiro release será criado automaticamente!** 🚀

---

<div align="center">

**Built with ❤️ by AIEXX | Powered by AI**

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/status-production%20ready-brightgreen.svg?style=for-the-badge)

</div>

# 🔧 Guia de Ferramentas MCP - Model Context Protocol

Este guia explica como usar ferramentas MCP (Model Context Protocol) para otimizar o desenvolvimento do pipeline 3D.

## 📚 O que é MCP?

**Model Context Protocol (MCP)** é um protocolo aberto que permite que modelos de linguagem (LLMs) interajam com ferramentas externas de forma padronizada.

### Benefícios

- 🔗 **Integração Simplificada**: Acesso a GitHub, filesystem, memória persistente
- 🚀 **Produtividade**: Automatize tarefas repetitivas
- 🧠 **Contexto Persistente**: Mantenha contexto entre sessões
- 🔒 **Segurança**: Tokens gerenciados via variáveis de ambiente

---

## 🛠️ Servidores MCP Disponíveis

### 1. GitHub MCP Server

Acesso a repositórios, issues, PRs, commits do GitHub.

**Capabilities**:
- Buscar repositórios
- Ler conteúdo de arquivos
- Criar issues
- Listar commits
- Buscar código

**Uso**:
```json
{
  "server": "github",
  "action": "search_repositories",
  "query": "ComfyUI 3D"
}
```

**Exemplo**:
- "Busque repositórios relacionados a Zero123 no GitHub"
- "Leia o README do repositório TencentARC/InstantMesh"
- "Crie uma issue para rastrear bug X"

---

### 2. Filesystem MCP Server

Acesso ao sistema de arquivos local.

**Capabilities**:
- Ler arquivos
- Escrever arquivos
- Listar diretórios
- Buscar arquivos

**Uso**:
```json
{
  "server": "filesystem",
  "action": "read_file",
  "path": "C:\\ComfyUI\\workflows\\3d\\01_zero123_multiview.json"
}
```

**Exemplo**:
- "Liste todos os arquivos .json em workflows/3d"
- "Leia o conteúdo de download_models.py"
- "Crie um novo workflow baseado no template X"

---

### 3. Memory MCP Server

Armazenamento persistente de contexto.

**Capabilities**:
- Armazenar memórias
- Recuperar memórias
- Buscar em memórias

**Uso**:
```json
{
  "server": "memory",
  "action": "store_memory",
  "key": "last_workflow_config",
  "value": {...}
}
```

**Exemplo**:
- "Lembre que eu prefiro TripoSR para protótipos rápidos"
- "Qual foi a configuração que usamos ontem?"
- "Armazene estes parâmetros como padrão"

---

## 🚀 Instalação e Configuração

### Passo 1: Verificar Pré-requisitos

```powershell
# Verificar Node.js (necessário)
node --version  # Deve ser 18.x ou superior

# Verificar npm
npm --version
```

Se não tiver Node.js:
- Windows: https://nodejs.org/
- Linux: `sudo apt install nodejs npm`
- macOS: `brew install node`

### Passo 2: Instalar Servidores MCP

```powershell
# Executar script de instalação
.\scripts\setup_mcp.ps1 -Install
```

Ou manualmente:
```bash
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory
```

### Passo 3: Configurar Credenciais

```powershell
# Configurar tokens
.\setup_env.ps1 -HF_TOKEN "seu_token_hf"

# Editar .env para adicionar GitHub token (opcional)
# GITHUB_TOKEN=ghp_xxxxxxxxxx
```

Ou usar script:
```powershell
.\scripts\setup_mcp.ps1 -Configure
```

### Passo 4: Testar Configuração

```powershell
.\scripts\setup_mcp.ps1 -Test
```

---

## 📖 Exemplos de Uso

### Buscar Modelos no GitHub

```
"Busque no GitHub repositórios com implementações de Zero123"
```

**MCP Action**:
```json
{
  "server": "github",
  "action": "search_repositories",
  "params": {
    "query": "Zero123 implementation",
    "sort": "stars",
    "order": "desc"
  }
}
```

### Analisar Código de Modelo

```
"Leia o código do modelo TripoSR no repositório stabilityai/TripoSR"
```

**MCP Action**:
```json
{
  "server": "github",
  "action": "get_file_contents",
  "params": {
    "owner": "stabilityai",
    "repo": "TripoSR",
    "path": "tsr/models/triposr.py"
  }
}
```

### Criar Novo Workflow

```
"Crie um novo workflow baseado em 01_zero123_multiview.json mas com 8 vistas"
```

**MCP Actions**:
1. Read: `filesystem:read_file(01_zero123_multiview.json)`
2. Modify: Ajustar parâmetro `num_views: 8`
3. Write: `filesystem:write_file(01_zero123_multiview_8views.json)`

### Armazenar Configuração

```
"Lembre desta configuração de exportação FBX:
- Smoothing: ON
- Tangents: ON
- Version: 2018"
```

**MCP Action**:
```json
{
  "server": "memory",
  "action": "store_memory",
  "params": {
    "key": "fbx_export_config",
    "value": {
      "smoothing": true,
      "tangents": true,
      "version": "2018"
    }
  }
}
```

### Recuperar Configuração

```
"Qual era minha configuração padrão de exportação FBX?"
```

**MCP Action**:
```json
{
  "server": "memory",
  "action": "retrieve_memory",
  "params": {
    "key": "fbx_export_config"
  }
}
```

---

## 🎯 Casos de Uso Avançados

### 1. Pipeline Automatizado de Pesquisa

**Objetivo**: Encontrar e documentar novos modelos 3D

```
Workflow:
1. GitHub: Buscar "3D reconstruction model"
2. GitHub: Ler READMEs dos top 5 repositórios
3. Memory: Armazenar comparação de modelos
4. Filesystem: Criar documento markdown com análise
```

**Comando**:
```
"Pesquise os 5 melhores modelos de reconstrução 3D no GitHub,
analise os READMEs e crie um documento comparativo em docs/model_comparison.md"
```

### 2. Otimização de Workflows

**Objetivo**: Analisar e otimizar workflows existentes

```
Workflow:
1. Filesystem: Ler todos workflows em workflows/3d/
2. Analisar parâmetros e performance
3. Memory: Comparar com configurações anteriores
4. Filesystem: Criar versões otimizadas
```

**Comando**:
```
"Analise todos os workflows em workflows/3d/, compare com as configurações
que deram melhor resultado (em memória) e crie versões otimizadas"
```

### 3. Monitoramento de Issues

**Objetivo**: Rastrear issues relacionadas aos modelos usados

```
Workflow:
1. GitHub: Listar issues abertas em TencentARC/InstantMesh
2. GitHub: Filtrar issues relacionadas a performance
3. Memory: Armazenar issues relevantes
4. Filesystem: Criar relatório
```

**Comando**:
```
"Monitore issues abertas no repositório InstantMesh,
filtre as relacionadas a performance e VRAM, e crie um relatório"
```

---

## 📝 Configuração Avançada

### Personalizar mcp_config.json

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      },
      "rateLimiting": {
        "requestsPerHour": 5000,
        "burstSize": 100
      }
    }
  },
  "tools": {
    "github": {
      "enabled": true,
      "autoConnect": true
    }
  }
}
```

### Rate Limiting

Evite exceder limites de API:

```json
{
  "rateLimiting": {
    "requestsPerHour": 5000,
    "burstSize": 100
  }
}
```

### Caminhos Permitidos

Restrinja acesso do Filesystem MCP:

```json
{
  "filesystem": {
    "allowedPaths": [
      "C:\\ComfyUI\\workflows",
      "C:\\ComfyUI\\exports"
    ],
    "excludePaths": [
      "C:\\ComfyUI\\.env"
    ]
  }
}
```

---

## 🔒 Segurança com MCP

### Boas Práticas

1. **Use Variáveis de Ambiente**
   ```json
   "env": {
     "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
   }
   ```

2. **Restrinja Caminhos**
   - Liste apenas diretórios necessários em `allowedPaths`
   - Exclua arquivos sensíveis em `excludePaths`

3. **Rate Limiting**
   - Configure limites adequados
   - Evite exceder quotas de API

4. **Permissões Mínimas**
   - GitHub: apenas `repo:read` para operações de leitura
   - Filesystem: apenas diretórios do projeto

### Arquivo de Configuração Seguro

**NÃO** coloque tokens diretamente em `mcp_config.json`:

❌ **ERRADO**:
```json
{
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxx"
  }
}
```

✅ **CORRETO**:
```json
{
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

E configure token via `.env`:
```
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

---

## 🧪 Testes e Troubleshooting

### Testar Conexão GitHub

```bash
# Teste manual
npx -y @modelcontextprotocol/server-github

# Ou via script
.\scripts\setup_mcp.ps1 -Test
```

### Testar Filesystem

```powershell
# Verificar permissões
Test-Path C:\ComfyUI\workflows\3d
```

### Verificar Logs

```powershell
# Logs do MCP (se configurado)
Get-Content .mcp\logs\mcp.log -Wait
```

### Problemas Comuns

**Erro: "GITHUB_TOKEN not found"**
```powershell
# Solução
.\setup_env.ps1 -HF_TOKEN "seu_token"
# Adicione GITHUB_TOKEN ao .env
```

**Erro: "Permission denied"**
```powershell
# Solução: Verificar allowedPaths em mcp_config.json
# Adicionar caminho necessário
```

**Erro: "Rate limit exceeded"**
```json
// Solução: Ajustar rate limiting em mcp_config.json
{
  "rateLimiting": {
    "requestsPerHour": 3000
  }
}
```

---

## 📚 Recursos Adicionais

### Documentação Oficial

- **MCP Specification**: https://modelcontextprotocol.io/
- **GitHub MCP Server**: https://github.com/modelcontextprotocol/servers/tree/main/src/github
- **Filesystem MCP Server**: https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem

### Tutoriais

- Criando Custom MCP Servers
- Integrando MCP com Claude Code
- Automação Avançada com MCP

### Comunidade

- Discord MCP Community
- GitHub Discussions
- Stack Overflow (tag: model-context-protocol)

---

## 🚀 Próximos Passos

1. **Instalar MCP**: `.\scripts\setup_mcp.ps1 -Install`
2. **Configurar tokens**: `.\scripts\setup_mcp.ps1 -Configure`
3. **Testar**: `.\scripts\setup_mcp.ps1 -Test`
4. **Experimentar**: Use comandos naturais para interagir com MCP
5. **Automatizar**: Crie workflows personalizados

---

**Versão**: 1.0
**Última atualização**: 2025-10-30
**Projeto**: AIEXX GenAI Image to 3D

Aproveite o poder do MCP para otimizar seu desenvolvimento! 🎯

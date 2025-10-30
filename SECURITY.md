# 🔐 Guia de Segurança - AIEXX GenAI Image to 3D

Este documento descreve as práticas de segurança e como proteger suas credenciais no projeto.

## ⚠️ IMPORTANTE: Token Exposto Detectado

Se você chegou aqui porque expôs um token, siga imediatamente:

### 1. Revogue o Token Comprometido

**Hugging Face**: https://huggingface.co/settings/tokens
- Encontre o token exposto
- Clique em "Revoke" ou "Delete"
- Confirme

**GitHub**: https://github.com/settings/tokens
- Encontre o token
- Clique em "Delete"
- Confirme

### 2. Crie Novo Token

Crie um novo token com apenas as permissões necessárias:
- **Hugging Face**: Read apenas
- **GitHub**: `repo:read` apenas (se necessário)

### 3. Configure Localmente

```powershell
# Configure o novo token
.\setup_env.ps1 -HF_TOKEN "novo_token_aqui"

# Verifique se está configurado
$env:HUGGING_FACE_HUB_TOKEN
```

### 4. Limpe o Histórico do Git (se necessário)

Se você já commitou o token:

```bash
# CUIDADO: Isso reescreve o histórico!
# Faça backup antes!

# Usar BFG Repo-Cleaner (recomendado)
# https://rtyley.github.io/bfg-repo-cleaner/

bfg --replace-text passwords.txt

# OU usar git filter-branch (mais complexo)
git filter-branch --tree-filter 'git ls-files -z "*.env" | xargs -0 rm -f' -- --all
```

---

## 🛡️ Boas Práticas de Segurança

### ✅ O QUE FAZER

1. **Use Variáveis de Ambiente**
   ```powershell
   # Sempre use .env
   HUGGING_FACE_HUB_TOKEN=hf_seu_token
   ```

2. **Verifique o .gitignore**
   ```bash
   # Certifique-se que .env está incluído
   cat .gitignore | grep .env
   ```

3. **Use o Script de Segurança**
   ```powershell
   # Antes de cada commit
   .\scripts\check_security.ps1
   ```

4. **Use .env.example como Template**
   ```bash
   # Copie e preencha
   cp .env.example .env
   ```

5. **Permissões Mínimas**
   - Tokens: apenas Read quando possível
   - API Keys: escopo limitado

6. **Rotação Regular**
   - Troque tokens a cada 3-6 meses
   - Revogue tokens não utilizados

### ❌ O QUE NÃO FAZER

1. ❌ **NUNCA** hardcode tokens no código
   ```python
   # ERRADO!
   token = "hf_xxxxxxxxxxxxx"
   ```

2. ❌ **NUNCA** commite arquivos .env
   ```bash
   # ERRADO!
   git add .env
   ```

3. ❌ **NUNCA** compartilhe tokens em:
   - Chats (Claude, ChatGPT, etc)
   - Issues do GitHub
   - Pull Requests
   - Discord, Slack, email
   - Screenshots

4. ❌ **NUNCA** use tokens de produção em desenvolvimento

5. ❌ **NUNCA** reutilize tokens entre projetos

---

## 📝 Arquivos Sensíveis Protegidos

O `.gitignore` está configurado para ignorar:

### Variáveis de Ambiente
```
.env
.env.local
.env.*.local
.env.production
.env.development
```

### Tokens e Credenciais
```
.huggingface/
.hf_token
*.token
*_token.txt
hf_token*
huggingface_token*
```

### API Keys
```
*api_key*
*apikey*
*.key
*.pem
*.cert
credentials.json
secrets.json
```

### Configurações Locais
```
config.local.json
mcp_config.local.json
.mcp/credentials/
```

---

## 🔍 Verificação de Segurança

### Script Automático

Execute antes de cada commit:

```powershell
# Verificação básica
.\scripts\check_security.ps1

# Verificação verbose
.\scripts\check_security.ps1 -Verbose
```

### Verificação Manual

1. **Procurar padrões perigosos**:
   ```powershell
   # Procurar tokens HF
   Get-ChildItem -Recurse -Include *.py,*.ps1,*.js | Select-String "hf_[a-zA-Z0-9]{20,}"

   # Procurar tokens GitHub
   Get-ChildItem -Recurse -Include *.py,*.ps1,*.js | Select-String "ghp_[a-zA-Z0-9]{36,}"
   ```

2. **Verificar staged files**:
   ```bash
   git diff --cached --name-only
   ```

3. **Verificar .gitignore**:
   ```bash
   git check-ignore -v .env
   ```

---

## 🔐 Configuração Segura de Tokens

### Hugging Face

```powershell
# Método 1: Via script (recomendado)
.\setup_env.ps1 -HF_TOKEN "hf_xxxxxxxxxx"

# Método 2: Manual
[System.Environment]::SetEnvironmentVariable("HUGGING_FACE_HUB_TOKEN", "hf_xxx", "User")

# Método 3: Via .env
echo "HUGGING_FACE_HUB_TOKEN=hf_xxx" > .env
```

### GitHub (para MCP)

```powershell
# Via .env
echo "GITHUB_TOKEN=ghp_xxx" >> .env

# Ou variável de ambiente
[System.Environment]::SetEnvironmentVariable("GITHUB_TOKEN", "ghp_xxx", "User")
```

### Context7 (se aplicável)

```powershell
# Via .env
echo "CONTEXT7_API_KEY=xxx" >> .env
```

---

## 🚨 Incidentes de Segurança

### Se Você Expôs um Token

1. **PARE** imediatamente
2. **REVOGUE** o token (links acima)
3. **CRIE** novo token
4. **CONFIGURE** localmente
5. **VERIFIQUE** histórico do git
6. **LIMPE** se necessário (BFG, filter-branch)
7. **NOTIFIQUE** equipe (se aplicável)

### Se Suspeitar de Comprometimento

1. Revogue TODOS os tokens imediatamente
2. Verifique logs de acesso:
   - Hugging Face: https://huggingface.co/settings/access-tokens
   - GitHub: https://github.com/settings/security-log
3. Crie novos tokens
4. Atualize em todos os ambientes
5. Documente o incidente

---

## 🛠️ Ferramentas de Segurança

### git-secrets

Previne commits acidentais de secrets:

```bash
# Instalar
git clone https://github.com/awslabs/git-secrets
cd git-secrets
make install

# Configurar
cd /path/to/projeto
git secrets --install
git secrets --register-aws
```

### BFG Repo-Cleaner

Remove secrets do histórico:

```bash
# Download: https://rtyley.github.io/bfg-repo-cleaner/

# Criar arquivo com secrets a remover
echo "hf_xxxxxxxxxx" > passwords.txt

# Executar
bfg --replace-text passwords.txt
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

### TruffleHog

Scanneia repositório em busca de secrets:

```bash
# Instalar
pip install truffleHog

# Executar
truffleHog --regex --entropy=False .
```

---

## 📋 Checklist de Segurança

Antes de cada commit:

- [ ] Executei `.\scripts\check_security.ps1`
- [ ] Não há tokens hardcoded no código
- [ ] `.env` está no `.gitignore`
- [ ] Não estou commitando arquivos sensíveis
- [ ] Tokens têm permissões mínimas necessárias
- [ ] Revisei as mudanças com `git diff`

Mensalmente:

- [ ] Revisei tokens ativos
- [ ] Revoquei tokens não utilizados
- [ ] Atualizei dependências
- [ ] Revisei logs de acesso

---

## 📞 Contato para Incidentes

Se descobrir uma vulnerabilidade de segurança:

1. **NÃO** abra issue pública
2. Entre em contato diretamente (se houver equipe)
3. Forneça detalhes:
   - Descrição da vulnerabilidade
   - Passos para reproduzir
   - Impacto potencial
   - Sugestão de correção (se tiver)

---

## 📚 Recursos Adicionais

- **Hugging Face Security**: https://huggingface.co/docs/hub/security
- **GitHub Security**: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure
- **OWASP Top 10**: https://owasp.org/www-project-top-ten/
- **Git Secrets**: https://github.com/awslabs/git-secrets

---

## 🔄 Versionamento

| Versão | Data | Mudanças |
|--------|------|----------|
| 1.0 | 2025-10-30 | Versão inicial |

---

**Lembre-se**: Segurança é responsabilidade de todos! 🛡️

Se tiver dúvidas, consulte este documento ou entre em contato com a equipe.

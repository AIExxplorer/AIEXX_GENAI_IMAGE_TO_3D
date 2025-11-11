# AIEXX - Guia de Solução de Problemas dos Scripts Batch

## ✨ NOVIDADE - Auto-Setup no START_AIEXX.bat (v1.1.0)

O `6-START_AIEXX.bat` agora cria **automaticamente** o ambiente virtual Python se ele não existir! Isso significa que você pode executá-lo diretamente após instalar o ComfyUI, e ele irá configurar o que estiver faltando.

**Recursos Auto-Setup:**
- ✅ Cria `.venv311` automaticamente se não existir
- ✅ Detecta e valida versão do Python
- ✅ Instala PyTorch com CUDA automaticamente
- ✅ Mensagens claras sobre o que está acontecendo
- ✅ Fallback para instalação manual se necessário

---

## 🔧 Ordem Correta de Execução

Para que o sistema funcione corretamente, você **PODE** executar os scripts na seguinte ordem:

```
1. 1-INSTALL_VS_BUILDTOOLS_WINGET.bat
   └─ ⚠️ REINICIE O COMPUTADOR APÓS ESTE PASSO!

2. 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
   └─ Cria o ambiente virtual Python (.venv311)

3. 3-RUN_INSTALL_3DPACK.bat
   └─ Instala o ComfyUI e ComfyUI-3D-Pack

4. 4-DOWNLOAD_3D_MODELS.bat
   └─ Baixa os modelos 3D necessários

5. 5-SETUP_SD_MODELS.bat (OPCIONAL)
   └─ Baixa modelos Stable Diffusion para workflows de prompt

6. 6-START_AIEXX.bat
   └─ Inicia o sistema AIEXX
   └─ **NOVO:** Cria venv automaticamente se não existir!
```

### 🚀 Modo Rápido (Novo na v1.1.0)

Se você já tem o ComfyUI instalado (via script 3), pode simplesmente executar:

```batch
6-START_AIEXX.bat
```

O launcher irá:
1. ✅ Detectar que o ambiente virtual não existe
2. ✅ Criar automaticamente o `.venv311`
3. ✅ Instalar PyTorch com CUDA 12.1
4. ✅ Iniciar o ComfyUI

**Nota:** A instalação completa (via scripts 2-4) ainda é recomendada para configuração ideal, mas o auto-setup do launcher funciona para iniciar rapidamente!

---

## ❌ Problemas Comuns e Soluções

### 1. Caracteres Ilegíveis nos Scripts

**Problema:** Ao executar os scripts batch, você vê caracteres estranhos como `├─`, `─`, etc.

**Solução:**
- ✅ **JÁ CORRIGIDO!** Os scripts agora incluem `chcp 65001` no início
- Se ainda ver problemas, feche e reabra o terminal
- Certifique-se de estar usando CMD ou PowerShell (não Git Bash)

**Scripts corrigidos:**
- ✅ 4-DOWNLOAD_3D_MODELS.bat
- ✅ 5-SETUP_SD_MODELS.bat
- ✅ 6-START_AIEXX.bat

---

### 2. Erro: "ComfyUI not found!"

**Mensagem completa:**
```
[ERROR] ComfyUI not found!
[ERROR] Expected path: C:\AIEXX_GENAI_IMAGE_TO_3D\ComfyUI\main.py
```

**Causa:** Você tentou executar `6-START_AIEXX.bat` sem executar os scripts de instalação primeiro.

**Solução:**
1. Execute `2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat`
2. Execute `3-RUN_INSTALL_3DPACK.bat` (isso instala o ComfyUI)
3. Execute `4-DOWNLOAD_3D_MODELS.bat`
4. Agora execute `6-START_AIEXX.bat`

---

### 3. Erro: "Virtual environment not found!"

**Mensagem completa:**
```
[ERROR] Virtual environment not found!
[ERROR] Expected path: C:\AIEXX_GENAI_IMAGE_TO_3D\.venv311
```

**Causa:** O ambiente virtual Python não foi criado.

**Solução:**
1. Execute `2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat`
   - Este script cria o ambiente virtual `.venv311`
2. Aguarde o script completar sem erros
3. Tente novamente executar o script que estava falhando

---

### 4. Erro: "CUDA not detected!"

**Mensagem completa:**
```
[WARNING] CUDA not detected!
Your GPU may not be utilized!
```

**Causa:** PyTorch não está detectando sua GPU NVIDIA.

**Solução:**
1. Verifique se os drivers NVIDIA estão atualizados
2. Execute o script de instalação do PyTorch CUDA:
   ```batch
   install_pytorch_cuda.bat
   ```
3. Reinicie o computador
4. Tente executar `6-START_AIEXX.bat` novamente

**Nota:** O sistema pode funcionar sem CUDA, mas será MUITO mais lento.

---

### 5. Erro: "nvcc not found in PATH!"

**Mensagem completa:**
```
[ERRO] nvcc não encontrado no PATH!
```

**Causa:** CUDA Toolkit não está instalado ou não está no PATH do sistema.

**Solução:**
1. Instale o CUDA Toolkit 12.8:
   - Download: https://developer.nvidia.com/cuda-12-8-0-download-archive
2. Durante a instalação, marque "Add to PATH"
3. **REINICIE O COMPUTADOR**
4. Abra um NOVO terminal
5. Execute novamente `3-RUN_INSTALL_3DPACK.bat`

---

### 6. Erro no Download de Modelos

**Problema:** Os scripts 4 ou 5 falham ao baixar modelos.

**Possíveis Causas e Soluções:**

**A. Problema de conexão com internet:**
- Verifique sua conexão
- Desative VPN temporariamente
- Tente novamente mais tarde

**B. Token HuggingFace ausente (para alguns modelos):**
1. Crie uma conta em: https://huggingface.co/
2. Gere um token de acesso em: https://huggingface.co/settings/tokens
3. Crie um arquivo `.env` na raiz do projeto:
   ```
   HUGGING_FACE_HUB_TOKEN=seu_token_aqui
   ```
4. Execute o script de download novamente

**C. Espaço em disco insuficiente:**
- Verifique se você tem pelo menos 55GB livres
- Limpe espaço se necessário
- Execute o script novamente

---

## 🆘 Começar do Zero

Se nada funcionar, você pode começar a instalação do zero:

```batch
# 1. Deletar ambiente virtual
rmdir /s /q .venv311

# 2. Deletar ComfyUI (opcional - irá redownload tudo)
rmdir /s /q ComfyUI

# 3. Executar scripts na ordem
1-INSTALL_VS_BUILDTOOLS_WINGET.bat
# ⚠️ REINICIAR!
2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
3-RUN_INSTALL_3DPACK.bat
4-DOWNLOAD_3D_MODELS.bat
6-START_AIEXX.bat
```

---

## 📋 Checklist de Verificação

Antes de executar `6-START_AIEXX.bat`, verifique se:

- [ ] Você executou `1-INSTALL_VS_BUILDTOOLS_WINGET.bat` e reiniciou
- [ ] Você executou `2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat` com sucesso
- [ ] Você executou `3-RUN_INSTALL_3DPACK.bat` com sucesso
- [ ] Você executou `4-DOWNLOAD_3D_MODELS.bat` com sucesso
- [ ] Existe o diretório `.venv311` com `Scripts\python.exe` dentro
- [ ] Existe o diretório `ComfyUI` com `main.py` dentro
- [ ] Você tem pelo menos 55GB de espaço livre

---

## 📞 Suporte Adicional

Se o problema persistir:

1. Verifique os logs de erro detalhados
2. Consulte: [README.md](README.md)
3. Consulte: [ORDEM_DE_INSTALACAO.md](ORDEM_DE_INSTALACAO.md)
4. Abra uma issue no GitHub com:
   - Mensagem de erro completa
   - Qual script estava executando
   - Versão do Windows
   - Modelo da GPU

---

**Última Atualização:** 2025-11-01
**Versão:** 1.1.0

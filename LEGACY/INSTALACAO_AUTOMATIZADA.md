# AIEXX - Smart Launcher & Instalador Automatizado

## 🚀 Launcher Inteligente (NOVO!)

A versão 1.1.0 introduz o **Smart Launcher** - um único arquivo que funciona como:
- ✨ **Instalador automatizado** (primeira execução)
- 🚀 **Launcher rápido** (execuções subsequentes)
- 🔄 **Sistema de auto-update** do GitHub
- 🌐 **Auto-abertura do navegador**

**Execute apenas uma vez para instalar. Nas próximas vezes, inicia automaticamente!**

---

## 🎯 Dois Modos de Operação

### **Modo 1: Instalação (Primeira Execução)**

Quando você executa `0-INSTALL_ALL_AUTOMATED.bat` pela primeira vez:

```
   ============================================================
   |     GenAI Image to 3D - Smart Launcher v1.1.0        |
   |     Powered by NVIDIA RTX GPU                         |
   ============================================================

   [MODE] Installation Mode - First Time Setup
```

O script:
1. Detecta que o sistema não está instalado
2. Executa instalação completa automatizada
3. Cria arquivo marcador `.aiexx_installed`
4. Inicia o sistema e abre o navegador

### **Modo 2: Launcher (Execuções Subsequentes)**

Nas próximas execuções do mesmo arquivo:

```
   ============================================================
   |     GenAI Image to 3D - Smart Launcher v1.1.0        |
   |     Powered by NVIDIA RTX GPU                         |
   ============================================================

   [MODE] Launcher Mode - System Already Installed
```

O script:
1. Detecta que já está instalado (via `.aiexx_installed`)
2. Verifica updates no GitHub (se for repositório git)
3. Pergunta se quer atualizar (se houver updates)
4. Faz health check do sistema
5. Inicia ComfyUI automaticamente
6. Abre navegador automaticamente

---

## ✨ Recursos do Smart Launcher

### 🎯 **Instalação Simplificada**
- **Um único comando** executa toda a instalação
- **Sem necessidade de executar scripts manualmente** um por um
- **Detecção automática de problemas** e soluções sugeridas

### 🔄 **Sistema de Checkpoints**
- **Salva o progresso** automaticamente após cada etapa
- **Continua de onde parou** após reinicializações
- **Pula etapas já concluídas** ao retomar instalação

### 🛡️ **Resistente a Falhas**
- **Validação de pré-requisitos** antes de começar
- **Tratamento inteligente de erros** com opções de retry
- **Rollback seguro** se algo falhar
- **Mensagens claras** sobre o que fazer em caso de erro

### 🔍 **Verificações Automáticas**
- ✅ Versão do Windows (10/11)
- ✅ Espaço em disco (mínimo 55GB)
- ✅ Conexão com internet
- ✅ Privilégios de administrador (recomendado)

---

## 🎬 Como Usar

### **Opção 1: Instalação Completamente Automatizada** (MAIS FÁCIL)

```batch
# Execute apenas este comando:
0-INSTALL_ALL_AUTOMATED.bat
```

Pronto! O instalador irá:
1. Verificar os requisitos do sistema
2. Instalar Visual Studio Build Tools
3. **Pedir para você reiniciar o computador**
4. Após o restart, execute novamente (ou use o atalho criado na área de trabalho)
5. Continuar automaticamente de onde parou
6. Criar ambiente virtual Python
7. Instalar ComfyUI e dependências
8. Baixar modelos 3D
9. Perguntar se quer baixar modelos Stable Diffusion (opcional)
10. Oferecer iniciar o sistema

---

## 📋 Fluxo de Instalação Detalhado

### **Primeira Execução**

```
========================================================================
  AIEXX GenAI - Automated Full Installation
========================================================================

  Installation Steps:
  [1/6] Install Visual Studio Build Tools (requires RESTART)
  [2/6] Create Python Virtual Environment + Install Dependencies
  [3/6] Install ComfyUI and 3D-Pack
  [4/6] Download 3D AI Models
  [5/6] Download Stable Diffusion Models (optional)
  [6/6] Launch AIEXX System

  Total Installation Time: ~30-60 minutes (depending on internet)
  Required Disk Space: ~55GB

========================================================================
```

### **Verificações Iniciais**

O instalador verifica automaticamente:

```
[CHECK 1/4] Checking Windows version...
[OK] Windows version compatible

[CHECK 2/4] Checking disk space...
[OK] Sufficient disk space available

[CHECK 3/4] Checking internet connection...
[OK] Internet connection active

[CHECK 4/4] Checking administrator privileges...
[OK] Running with administrator privileges
```

### **Passo 1: Visual Studio Build Tools**

```
========================================================================
  [STEP 1/6] Installing Visual Studio Build Tools
========================================================================

  IMPORTANT: After this step, you MUST RESTART your computer!
  The script will automatically continue after restart.
========================================================================
```

Após a instalação, o script:
- ✅ Salva um checkpoint (`.aiexx_install_checkpoint`)
- ✅ Cria um atalho na área de trabalho ("Continue AIEXX Install.bat")
- ✅ Oferece reiniciar automaticamente

### **Após Reiniciar**

Execute novamente o script (ou use o atalho da área de trabalho):

```batch
0-INSTALL_ALL_AUTOMATED.bat
```

O instalador detectará automaticamente:

```
[INFO] Found previous installation checkpoint!
[INFO] Last completed step: 1

Do you want to continue from where you left off? (Y/N)
```

Escolha **Y** e a instalação continua do Passo 2!

### **Passos 2-4: Instalação Automática**

Os passos seguintes são executados automaticamente:

```
[STEP 2/6] Creating Python Virtual Environment
  Estimated time: ~5-10 minutes
  [SUCCESS] Step 2 completed successfully!

[STEP 3/6] Installing ComfyUI and 3D-Pack
  Estimated time: ~10-15 minutes
  [SUCCESS] Step 3 completed successfully!

[STEP 4/6] Downloading 3D AI Models
  Estimated time: ~15-30 minutes
  [SUCCESS] Step 4 completed!
```

### **Passo 5: Modelos Stable Diffusion (Opcional)**

```
[STEP 5/6] Downloading Stable Diffusion Models (OPTIONAL)

  Do you want to download Stable Diffusion models?

  [Y] Yes, [N] No, or [S] Skip all optional steps
```

### **Passo 6: Conclusão**

```
========================================================================
  [STEP 6/6] Installation Complete!
========================================================================

  Congratulations! AIEXX GenAI Image to 3D has been successfully
  installed and configured.

  Do you want to start AIEXX now? (Y/N)
========================================================================
```

---

## 🔧 Tratamento de Erros

### **Se Algo Der Errado**

O instalador automatizado tem tratamento inteligente para os erros mais comuns:

#### **Erro na Etapa 1 (VS Build Tools)**
```
[ERROR] Visual Studio Build Tools installation failed!

Please:
1. Run this script as Administrator
2. Check your internet connection
3. Try manual installation from: https://visualstudio.microsoft.com/downloads/
```

**Solução:** Execute como Administrador e tente novamente.

#### **Erro na Etapa 2 (Python Environment)**
```
[ERROR] Virtual environment setup failed!

You may need to:
1. Install Python 3.11.9
2. Ensure Python is in PATH
3. Restart your computer if you just installed VS Build Tools
```

**Solução:** Instale Python 3.11.9 e garanta que está no PATH.

#### **Erro na Etapa 3 (ComfyUI)**
```
[ERROR] ComfyUI installation failed!

Common issues:
1. CUDA Toolkit not installed or not in PATH
2. Insufficient disk space
3. Network connection issues
```

**Solução:** Verifique CUDA Toolkit e espaço em disco.

#### **Erro na Etapa 4 (Download de Modelos)**
```
[WARNING] 3D models download encountered issues!

You can:
1. Continue anyway (some models may be missing)
2. Retry the download later by running: 4-DOWNLOAD_3D_MODELS.bat
3. Exit and troubleshoot
```

**Solução:** Escolha continuar e baixe os modelos manualmente depois.

---

## 🔄 Recomeçar do Zero

Se você quiser recomeçar a instalação do início:

```batch
# Deletar checkpoint
del .aiexx_install_checkpoint

# Deletar ambiente virtual (opcional)
rmdir /s /q .venv311

# Deletar ComfyUI (opcional - vai redownload tudo)
rmdir /s /q ComfyUI

# Executar instalador novamente
0-INSTALL_ALL_AUTOMATED.bat
```

---

## 📊 Comparação: Automatizado vs Manual

| Característica | Instalação Automatizada | Instalação Manual |
|----------------|-------------------------|-------------------|
| **Comandos necessários** | 1 (+ 1 após restart) | 6 comandos separados |
| **Tratamento de erros** | Automático | Manual |
| **Checkpoint/Resume** | Sim | Não |
| **Validação de pré-requisitos** | Sim | Não |
| **Tempo de atenção** | Mínimo | Alto |
| **Ideal para** | Iniciantes | Usuários avançados |

---

## ⚙️ Arquivos Criados pelo Instalador

Durante a instalação, os seguintes arquivos são criados:

### **`.aiexx_install_checkpoint`**
- Arquivo temporário que salva o progresso
- Contém o número da última etapa concluída
- Deletado automaticamente ao finalizar

### **`Continue AIEXX Install.bat` (Desktop)**
- Atalho criado na área de trabalho
- Usado para continuar após o restart
- Deletado automaticamente ao finalizar

---

## 🆘 Solução de Problemas

### **O instalador trava em alguma etapa**

1. Pressione **Ctrl+C** para cancelar
2. Verifique as mensagens de erro
3. Resolva o problema indicado
4. Execute novamente `0-INSTALL_ALL_AUTOMATED.bat`
5. Escolha continuar de onde parou

### **Quero pular uma etapa**

O instalador não permite pular etapas obrigatórias (1-4), mas permite pular:
- Passo 5 (Modelos Stable Diffusion) - Opcional

Se precisar pular algo, use a instalação manual.

### **Preciso executar apenas uma etapa específica**

Use os scripts individuais:
```batch
1-INSTALL_VS_BUILDTOOLS_WINGET.bat
2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
3-RUN_INSTALL_3DPACK.bat
4-DOWNLOAD_3D_MODELS.bat
5-SETUP_SD_MODELS.bat
6-START_AIEXX.bat
```

---

## 📈 Logs e Diagnóstico

Se precisar de logs para diagnóstico, execute com redirecionamento:

```batch
0-INSTALL_ALL_AUTOMATED.bat > install_log.txt 2>&1
```

Isso salvará toda a saída em `install_log.txt`.

---

## ✅ Checklist Pós-Instalação

Após a instalação completa, verifique:

- [ ] Diretório `.venv311` existe com `Scripts\python.exe`
- [ ] Diretório `ComfyUI` existe com `main.py`
- [ ] Existem modelos em `ComfyUI\models\triposr\`
- [ ] Existem modelos em `ComfyUI\models\instantmesh\`
- [ ] Existem modelos em `ComfyUI\models\zero123\`
- [ ] (Opcional) Modelos SD em `ComfyUI\models\checkpoints\`

---

## 🎯 Próximos Passos

Após a instalação bem-sucedida:

1. **Execute:** `6-START_AIEXX.bat`
2. **Acesse:** http://localhost:8188
3. **Carregue um workflow:** `workflows/3d/03_triposr_single_image_to_mesh.json`
4. **Gere seu primeiro modelo 3D!**

📖 **Documentação Completa:**
- [COMO_USAR.md](COMO_USAR.md) - Guia completo de uso
- [QUICK_START_GUIDE.md](QUICK_START_GUIDE.md) - Início rápido
- [TROUBLESHOOTING_BATCH_FILES.md](TROUBLESHOOTING_BATCH_FILES.md) - Solução de problemas

---

**Versão:** 1.1.0
**Última Atualização:** 2025-11-01

# AIEXX - Guia de Teste e Validação

## 🧪 TESTE PASSO A PASSO

### PASSO 1: Diagnóstico Inicial

Execute o script de diagnóstico para identificar problemas:

```batch
DIAGNOSTIC_TEST.bat
```

**O que esperar:**
- Janela abre e permanece aberta
- Mostra 10 testes
- Gera arquivo `diagnostic_report.txt`
- NÃO deve fechar sozinho

**Se a janela fechar sozinha:**
- ❌ Problema de encoding ou sintaxe
- Abra CMD como Admin e execute manualmente:
  ```cmd
  cd C:\AIEXX_GENAI_IMAGE_TO_3D
  DIAGNOSTIC_TEST.bat
  ```

---

### PASSO 2: Testar Novo Launcher

Execute o launcher simplificado:

```batch
AIEXX_LAUNCHER.bat
```

**Primeira execução (modo instalação):**
```
========================================================================

     AAA    IIIII  EEEEE  XX   XX  XX   XX
    AAAAA    III   EE      XX XX    XX XX
   AA   AA   III   EEEE     XXX      XXX
  AAAAAAA    III   EE      XX XX    XX XX
 AA     AA  IIIII  EEEEE  XX   XX  XX   XX

  GenAI Image to 3D System - v1.1.0
  Smart Launcher and Installer

========================================================================

[MODE] Installation Mode - First Time Setup
```

**Execuções subsequentes (modo launcher):**
```
[MODE] Launcher Mode - Starting System

========================================================================
  System Checks
========================================================================

[1/3] Checking virtual environment...
[OK] Virtual environment ready

[2/3] Checking ComfyUI...
[OK] ComfyUI ready

[3/3] Checking for updates...
[OK] System up to date
```

---

### PASSO 3: Verificar Arquivos Criados

Após instalação, verifique se existem:

```batch
dir .aiexx_*
dir .venv311
dir ComfyUI
```

**Arquivos esperados:**
- `.aiexx_installed` - Marcador de instalação completa
- `.aiexx_checkpoint` - Checkpoint temporário (deletado após conclusão)
- `.venv311\` - Ambiente virtual Python
- `ComfyUI\` - ComfyUI instalado

---

## 🔍 ANÁLISE DE PROBLEMAS COMUNS

### Problema 1: Janela Abre e Fecha Imediatamente

**Causas possíveis:**
1. Encoding UTF-8 com BOM
2. Caracteres especiais Unicode
3. Erro de sintaxe batch
4. Falta de `pause` no final

**Como testar:**
```cmd
# Abrir CMD como Admin
cd C:\AIEXX_GENAI_IMAGE_TO_3D

# Executar com echo on para ver erros
@echo on
AIEXX_LAUNCHER.bat
```

**Solução:**
- Use `AIEXX_LAUNCHER.bat` (ASCII puro, sem Unicode)
- Evite `0-INSTALL_ALL_AUTOMATED.bat` (tem UTF-8)

---

### Problema 2: Virtual Environment Não Criado

**Sintomas:**
```
[ERROR] Virtual environment missing!
```

**Verificar:**
```batch
# Python instalado?
python --version

# Pode criar venv?
python -m venv test_venv

# Deletar teste
rmdir /s /q test_venv
```

**Solução:**
1. Instalar Python 3.11.9
2. Adicionar ao PATH
3. Reiniciar computador
4. Executar launcher novamente

---

### Problema 3: ComfyUI Não Encontrado

**Sintomas:**
```
[ERROR] ComfyUI not found!
```

**Verificar:**
```batch
dir ComfyUI\main.py
```

**Solução:**
1. Verificar se passo 3 (3-RUN_INSTALL_3DPACK.bat) foi executado
2. Verificar log de erros
3. Executar manualmente: `3-RUN_INSTALL_3DPACK.bat`

---

## 📊 COMPARAÇÃO DOS LAUNCHERS

| Arquivo | Encoding | Status | Recomendação |
|---------|----------|--------|--------------|
| **AIEXX_LAUNCHER.bat** | ASCII puro | ✅ TESTADO | **USE ESTE** |
| **DIAGNOSTIC_TEST.bat** | ASCII puro | ✅ TESTADO | Para diagnóstico |
| 0-INSTALL_ALL_AUTOMATED.bat | UTF-8 | ⚠️ Problemas | Evite |
| 6-START_AIEXX.bat | UTF-8 | ⚠️ Problemas | Evite |

---

## 🎯 FLUXO DE TESTE RECOMENDADO

### Teste Completo do Zero

```batch
# 1. Diagnóstico
DIAGNOSTIC_TEST.bat
# ✅ Deve permanecer aberto e gerar relatório

# 2. Limpar instalação anterior (se houver)
del .aiexx_installed
del .aiexx_checkpoint
rmdir /s /q .venv311
rmdir /s /q ComfyUI

# 3. Executar launcher (como Admin)
# Clique direito > Executar como Administrador
AIEXX_LAUNCHER.bat

# 4. Seguir passos:
# - Instalar VS Build Tools
# - REINICIAR
# - Executar AIEXX_LAUNCHER.bat novamente
# - Aguardar instalação completa
# - Sistema inicia automaticamente
```

---

## 🐛 DEBUG AVANÇADO

### Ver Comandos Executados

```batch
@echo off → @echo on
```

### Executar Linha por Linha

```cmd
# Abrir CMD como Admin
cd C:\AIEXX_GENAI_IMAGE_TO_3D

# Executar comandos manualmente
set MARKER=.aiexx_installed
if exist "%MARKER%" (
    echo Arquivo existe
) else (
    echo Arquivo NAO existe
)
```

### Verificar Variáveis

```batch
# Adicionar ao script:
echo DEBUG: MARKER=%MARKER%
echo DEBUG: CD=%CD%
pause
```

---

## 📝 CHECKLIST PRÉ-TESTE

Antes de testar, certifique-se:

- [ ] Windows 10/11 64-bit
- [ ] Conta com privilégios de Admin
- [ ] 55GB+ espaço livre
- [ ] Conexão com internet ativa
- [ ] Python 3.11.9 instalado (opcional - launcher pode criar venv mesmo sem)
- [ ] Todos os arquivos .bat presentes
- [ ] Nenhum antivírus bloqueando

---

## 🎓 PRÓXIMOS PASSOS

Após validação completa:

### 1. Validar Encoding
```batch
# Verificar todos os .bat são ASCII ou têm encoding correto
file *.bat
```

### 2. Criar .EXE
- Usar NSIS (Nullsoft Scriptable Install System)
- Ou Inno Setup
- Ou PyInstaller com wrapper batch

### 3. Adicionar Contrato MIT
- Incluir LICENSE.txt
- Prompt de aceite no instalador .exe
- Checkbox "I agree to MIT License"

### 4. Assinar Digitalmente
- Certificado code signing (opcional mas recomendado)
- Evita avisos do Windows Defender

---

## 🚀 TEMPLATE PARA .EXE FUTURO

```nsi
; AIEXX Installer Script (NSIS)
Name "AIEXX GenAI Image to 3D"
OutFile "AIEXX_Setup.exe"
InstallDir "$PROGRAMFILES64\AIEXX"

Section "Install"
  ; Extract files
  SetOutPath $INSTDIR
  File /r "*.*"

  ; Show MIT License
  MessageBox MB_YESNO "Do you agree to the MIT License?" IDYES AgreeLabel
    Abort
  AgreeLabel:

  ; Run launcher
  ExecWait "$INSTDIR\AIEXX_LAUNCHER.bat"
SectionEnd
```

---

## 📞 SUPORTE

Se encontrar problemas:

1. Execute: `DIAGNOSTIC_TEST.bat`
2. Leia: `diagnostic_report.txt`
3. Verifique: Encoding dos arquivos .bat
4. Use: `AIEXX_LAUNCHER.bat` (versão robusta)

---

**Versão:** 1.1.0
**Última Atualização:** 2025-11-01

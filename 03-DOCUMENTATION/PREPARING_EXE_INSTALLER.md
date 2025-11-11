# AIEXX - Preparação para Instalador .EXE

## 📦 Roadmap para Criação do Instalador

### Fase Atual: Validação dos Scripts Batch

**Status:** Em teste
- ✅ `AIEXX_LAUNCHER.bat` criado (ASCII puro, robusto)
- ✅ `DIAGNOSTIC_TEST.bat` criado para troubleshooting
- ⚠️ `0-INSTALL_ALL_AUTOMATED.bat` com problemas de encoding
- 📋 Próximo: Testar e validar todos os scripts

---

## 🎯 Fases do Projeto

### ✅ Fase 1: Scripts Batch Funcionais (ATUAL)
- [x] Criar launcher principal
- [x] Sistema de checkpoints
- [x] Auto-update do GitHub
- [x] Health checks
- [ ] **TESTAR TUDO** ← Você está aqui
- [ ] Validar encoding
- [ ] Corrigir problemas

### 📋 Fase 2: Preparação para .EXE (PRÓXIMA)
- [ ] Escolher ferramenta de criação (NSIS, Inno Setup, ou PyInstaller)
- [ ] Criar script de instalação
- [ ] Adicionar tela de licença MIT
- [ ] Criar ícone (.ico)
- [ ] Testar instalador

### 🚀 Fase 3: Instalador .EXE Profissional (FUTURA)
- [ ] Criar instalador completo
- [ ] Assinatura digital (opcional)
- [ ] Distribuição
- [ ] Auto-updater integrado

---

## 🛠️ Ferramentas Disponíveis para Criar .EXE

### Opção 1: NSIS (Nullsoft Scriptable Install System)

**Prós:**
- ✅ Grátis e open source
- ✅ Muito usado (WinAmp, VLC, etc.)
- ✅ Suporta scripts complexos
- ✅ Interface customizável

**Contras:**
- ❌ Linguagem própria (aprendizado)
- ❌ Interface antiga

**Download:** https://nsis.sourceforge.io/

**Exemplo de Script:**
```nsi
; AIEXX Installer
!include "MUI2.nsh"

Name "AIEXX GenAI Image to 3D v1.1.0"
OutFile "AIEXX_Setup_v1.1.0.exe"
InstallDir "$PROGRAMFILES64\AIEXX"

!define MUI_ICON "aiexx_icon.ico"
!define MUI_LICENSEPAGE_TEXT_TOP "AIEXX uses MIT License"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "You must agree to continue"

!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath $INSTDIR

  ; Copy all files
  File /r "*.bat"
  File /r "*.py"
  File /r "*.md"
  File /r "workflows"

  ; Create shortcuts
  CreateDirectory "$SMPROGRAMS\AIEXX"
  CreateShortCut "$SMPROGRAMS\AIEXX\AIEXX Launcher.lnk" \
    "$INSTDIR\AIEXX_LAUNCHER.bat" \
    "" "$INSTDIR\aiexx_icon.ico"

  CreateShortCut "$DESKTOP\AIEXX.lnk" \
    "$INSTDIR\AIEXX_LAUNCHER.bat" \
    "" "$INSTDIR\aiexx_icon.ico"

  ; Run launcher
  ExecWait "$INSTDIR\AIEXX_LAUNCHER.bat"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\*.*"
  RMDir /r "$INSTDIR"
  Delete "$SMPROGRAMS\AIEXX\*.*"
  RMDir "$SMPROGRAMS\AIEXX"
  Delete "$DESKTOP\AIEXX.lnk"
SectionEnd
```

---

### Opção 2: Inno Setup

**Prós:**
- ✅ Grátis
- ✅ Interface moderna
- ✅ Fácil de usar
- ✅ Boa documentação

**Contras:**
- ❌ Menos flexível que NSIS

**Download:** https://jrsoftware.org/isinfo.php

**Exemplo de Script:**
```ini
[Setup]
AppName=AIEXX GenAI Image to 3D
AppVersion=1.1.0
DefaultDirName={pf}\AIEXX
DefaultGroupName=AIEXX
LicenseFile=LICENSE.txt
OutputBaseFilename=AIEXX_Setup_v1.1.0

[Files]
Source: "*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\AIEXX Launcher"; Filename: "{app}\AIEXX_LAUNCHER.bat"
Name: "{commondesktop}\AIEXX"; Filename: "{app}\AIEXX_LAUNCHER.bat"

[Run]
Filename: "{app}\AIEXX_LAUNCHER.bat"; Description: "Launch AIEXX now"; Flags: postinstall nowait
```

---

### Opção 3: PyInstaller + Wrapper

**Prós:**
- ✅ Cria executável standalone
- ✅ Pode empacotar Python
- ✅ Cross-platform

**Contras:**
- ❌ Arquivo grande
- ❌ Requer Python no build
- ❌ Antivírus podem sinalizar

**Como Usar:**
```python
# launcher_wrapper.py
import subprocess
import os

os.chdir(os.path.dirname(__file__))
subprocess.run(["AIEXX_LAUNCHER.bat"], shell=True)
```

```bash
pip install pyinstaller
pyinstaller --onefile --icon=aiexx_icon.ico launcher_wrapper.py
```

---

## 📝 Licença MIT - Integração

### Criar LICENSE.txt

```text
MIT License

Copyright (c) 2025 AIEXX Project

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### Tela de Aceite no Instalador

**NSIS:**
```nsi
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
```

**Inno Setup:**
```ini
LicenseFile=LICENSE.txt
```

**Batch (atual):**
```batch
echo.
echo ========================================================================
echo   MIT License Agreement
echo ========================================================================
echo.
type LICENSE.txt
echo.
choice /C YN /M "Do you agree to the MIT License terms"
if errorlevel 2 exit /b 1
```

---

## 🎨 Criar Ícone para o Instalador

### Ferramentas para Criar .ICO

1. **Online:** https://converticon.com/
2. **Software:** GIMP, Photoshop, Paint.NET
3. **Converter PNG:** https://icoconvert.com/

### Especificações do Ícone

- Formato: .ICO
- Tamanhos: 16x16, 32x32, 48x48, 256x256
- Cores: 32-bit com alpha

### Logo AIEXX Sugerida

```
  ┌─────────────┐
  │   █████╗   │
  │  ██╔══██╗  │
  │  ███████║  │
  │  ██╔══██║  │
  │  ██║  ██║  │
  │  ╚═╝  ╚═╝  │
  │             │
  │   AIEXX    │
  │    3D      │
  └─────────────┘
```

Cores sugeridas:
- Background: Azul escuro (#0B1F3F)
- Texto: Ciano (#00D9FF)
- Borda: Dourado (#FFD700)

---

## 🔐 Assinatura Digital (Opcional)

### Por que Assinar?

- ✅ Windows não mostra aviso "Unknown Publisher"
- ✅ Usuários confiam mais
- ✅ Antivírus menos agressivos

### Como Obter Certificado

1. **Certificado Comercial:**
   - DigiCert (~$200-400/ano)
   - Sectigo (~$100-200/ano)
   - GoDaddy (~$100/ano)

2. **Certificado Auto-Assinado (não recomendado para distribuição):**
   ```powershell
   New-SelfSignedCertificate -Subject "CN=AIEXX" -Type CodeSigning -CertStoreLocation Cert:\CurrentUser\My
   ```

3. **Assinar o EXE:**
   ```cmd
   signtool sign /f certificate.pfx /p password AIEXX_Setup.exe
   ```

---

## 📋 Checklist Pré-Criação do .EXE

### Arquivos Necessários

- [ ] `AIEXX_LAUNCHER.bat` (validado e testado)
- [ ] Todos os scripts de instalação (1-6)
- [ ] `LICENSE.txt` (MIT License)
- [ ] `README.md` atualizado
- [ ] `aiexx_icon.ico` criado
- [ ] Workflows em `workflows/3d/`
- [ ] Scripts Python (`download_models.py`, etc.)

### Funcionalidades a Testar

- [ ] Instalação do zero funciona
- [ ] Checkpoint/resume funciona
- [ ] Launcher mode funciona
- [ ] Update do GitHub funciona
- [ ] Health check funciona
- [ ] Browser abre automaticamente
- [ ] Todos os encoding corretos (ASCII ou UTF-8 sem BOM)

### Documentação

- [ ] `TESTING_GUIDE.md` atualizado
- [ ] `INSTALACAO_AUTOMATIZADA.md` atualizado
- [ ] `QUICK_LAUNCH_GUIDE.md` atualizado
- [ ] Screenshots para README

---

## 🚀 Plano de Ação Recomendado

### Agora (Fase 1 - Validação)

```batch
# 1. Testar diagnóstico
DIAGNOSTIC_TEST.bat

# 2. Testar launcher
AIEXX_LAUNCHER.bat

# 3. Verificar encoding
file *.bat

# 4. Corrigir problemas encontrados

# 5. Testar instalação completa do zero
```

### Depois (Fase 2 - Preparação)

1. Criar `LICENSE.txt`
2. Criar ícone `aiexx_icon.ico`
3. Escolher ferramenta (recomendo Inno Setup)
4. Criar script de instalação
5. Testar .exe localmente

### Futuro (Fase 3 - Distribuição)

1. Assinar digitalmente (opcional)
2. Criar página de download
3. Adicionar auto-updater
4. Publicar releases no GitHub

---

## 💡 Recomendação Final

**Para agora:**
- Use `AIEXX_LAUNCHER.bat` como arquivo principal
- Teste exaustivamente
- Corrija qualquer problema de encoding
- Valide que tudo funciona perfeitamente

**Para o .exe:**
- Recomendo **Inno Setup** (mais fácil, moderno)
- Inclua LICENSE.txt e tela de aceite
- Crie ícone profissional
- Teste em máquina limpa (VM)

**Prioridades:**
1. ✅ Validar scripts batch (AGORA)
2. 📋 Criar LICENSE.txt e ícone
3. 🛠️ Criar instalador .exe
4. 🔐 Assinar (se orçamento permitir)
5. 🚀 Distribuir

---

## 📞 Próximos Passos Imediatos

1. **Execute o diagnóstico:**
   ```batch
   DIAGNOSTIC_TEST.bat
   ```

2. **Teste o novo launcher:**
   ```batch
   AIEXX_LAUNCHER.bat
   ```

3. **Reporte os resultados:**
   - O que funcionou?
   - O que falhou?
   - Mensagens de erro?

4. **Iteração:**
   - Corrigir problemas
   - Re-testar
   - Repetir até 100% funcional

Só depois de tudo validado, passamos para criar o .exe!

---

**Versão:** 1.1.0
**Última Atualização:** 2025-11-01

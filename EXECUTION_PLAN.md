# AIEXX - Plano de Execução Completo

## 🎯 OBJETIVO
Executar planejamento detalhado, organização, testes e demonstração final do projeto AIEXX.

---

## 📋 FASE 1: ORGANIZAÇÃO DE ARQUIVOS

### Etapa 1.1: Backup de Segurança
```batch
# Criar backup antes de reorganizar
mkdir BACKUP_%DATE%
xcopy *.bat BACKUP_%DATE%\ /Y
xcopy *.md BACKUP_%DATE%\ /Y
xcopy *.py BACKUP_%DATE%\ /Y
```

### Etapa 1.2: Criar Estrutura de Diretórios
```batch
mkdir 00-LAUNCHER
mkdir 01-SETUP-SCRIPTS
mkdir 02-PYTHON-SCRIPTS
mkdir 03-DOCUMENTATION
mkdir 04-WORKFLOWS
mkdir 05-RELEASE
mkdir LEGACY
mkdir TESTS
```

### Etapa 1.3: Organizar Arquivos
- Executar: `REORGANIZE_PROJECT.bat`
- Validar: Verificar se todos os arquivos foram movidos corretamente
- Status: ⏳ Pendente

---

## 📋 FASE 2: TESTES UNITÁRIOS

### Etapa 2.1: Teste de Encoding
```batch
# Verificar encoding de todos os .bat
file *.bat > encoding_test.txt
```

**Critério de Sucesso:**
- ✅ Arquivos principais em ASCII
- ⚠️ Nenhum arquivo com BOM

### Etapa 2.2: Teste de Sintaxe Batch
```batch
# Testar sintaxe sem executar
@echo off
for %%f in (*.bat) do (
    echo Testing: %%f
    cmd /c echo Testing syntax of %%f
)
```

**Critério de Sucesso:**
- ✅ Nenhum erro de sintaxe
- ✅ Todos os scripts podem ser parseados

### Etapa 2.3: Teste do Diagnostic Tool
```batch
DIAGNOSTIC_TEST.bat
```

**Critério de Sucesso:**
- ✅ Janela permanece aberta
- ✅ Todos os 10 testes executam
- ✅ Gera `diagnostic_report.txt`
- ✅ Sem caracteres ilegíveis

### Etapa 2.4: Teste do Launcher (Modo Instalação)
```batch
# Simular primeira instalação
del .aiexx_installed
AIEXX_LAUNCHER.bat
```

**Critério de Sucesso:**
- ✅ Mostra logo ASCII corretamente
- ✅ Detecta modo instalação
- ✅ Mostra menu de instalação
- ✅ Não fecha sozinho

### Etapa 2.5: Teste do Launcher (Modo Launcher)
```batch
# Simular sistema instalado
echo Installed > .aiexx_installed
mkdir ComfyUI
echo test > ComfyUI\main.py
AIEXX_LAUNCHER.bat
```

**Critério de Sucesso:**
- ✅ Detecta modo launcher
- ✅ Faz health checks
- ✅ Não tenta instalar novamente

---

## 📋 FASE 3: TESTES DE INTEGRAÇÃO

### Etapa 3.1: Teste de Verificação de Pré-requisitos
```batch
# Testar detecção de Python
python --version

# Testar detecção de Git
git --version

# Testar conexão internet
ping -n 1 8.8.8.8
```

### Etapa 3.2: Teste de Criação de Ambiente Virtual
```batch
# Limpar ambiente anterior
rmdir /s /q test_venv

# Criar novo ambiente
python -m venv test_venv

# Validar criação
if exist test_venv\Scripts\python.exe (
    echo SUCCESS
) else (
    echo FAILED
)

# Limpar
rmdir /s /q test_venv
```

### Etapa 3.3: Teste de Download de Modelos (Simulado)
```python
# test_download.py
import os
from pathlib import Path

def test_download_structure():
    # Verificar se estrutura de diretórios pode ser criada
    test_dirs = [
        "ComfyUI/models/triposr",
        "ComfyUI/models/instantmesh",
        "ComfyUI/models/zero123"
    ]

    for dir_path in test_dirs:
        Path(dir_path).mkdir(parents=True, exist_ok=True)
        if Path(dir_path).exists():
            print(f"✓ {dir_path} - OK")
        else:
            print(f"✗ {dir_path} - FAILED")

if __name__ == "__main__":
    test_download_structure()
```

---

## 📋 FASE 4: COMPILAÇÃO DO INSTALADOR

### Etapa 4.1: Instalar Inno Setup
```batch
innosetup_installer.exe
```

**Critério de Sucesso:**
- ✅ Inno Setup instalado em `C:\Program Files (x86)\Inno Setup 6`
- ✅ Compilador disponível

### Etapa 4.2: Criar Ícone (Opcional)
- Usar: https://converticon.com/
- Salvar como: `aiexx_icon.ico`
- Ou: Comentar linha do ícone no script

### Etapa 4.3: Compilar Instalador
```batch
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" AIEXX_Installer.iss
```

**Critério de Sucesso:**
- ✅ Compilação sem erros
- ✅ Arquivo criado: `installer_output\AIEXX_Setup_v1.1.0.exe`
- ✅ Tamanho: ~600KB - 1MB

---

## 📋 FASE 5: TESTES DO INSTALADOR

### Etapa 5.1: Teste de Instalação
```batch
# Executar instalador
installer_output\AIEXX_Setup_v1.1.0.exe
```

**Critério de Sucesso:**
- ✅ Tela de licença MIT aparece
- ✅ Instalação sem erros
- ✅ Atalhos criados (Desktop + Menu Iniciar)
- ✅ Arquivos instalados em `C:\Program Files\AIEXX\`

### Etapa 5.2: Teste Pós-Instalação
```batch
# Verificar arquivos instalados
dir "C:\Program Files\AIEXX\"

# Executar launcher instalado
"C:\Program Files\AIEXX\AIEXX_LAUNCHER.bat"
```

### Etapa 5.3: Teste de Desinstalação
```batch
# Desinstalar via Painel de Controle
# Ou executar unins000.exe
```

**Critério de Sucesso:**
- ✅ Desinstalação completa
- ✅ Atalhos removidos
- ✅ Pasta removida

---

## 📋 FASE 6: EXECUÇÃO FINAL DEMONSTRAÇÃO

### Etapa 6.1: Instalação Completa
```batch
1. Executar: AIEXX_LAUNCHER.bat
2. Seguir instalação guiada
3. Aguardar instalação de dependências
4. Aguardar download de modelos
```

### Etapa 6.2: Primeira Execução
```batch
1. Sistema inicia automaticamente
2. ComfyUI abre em http://localhost:8188
3. Navegador abre automaticamente
```

### Etapa 6.3: Teste de Workflow
```batch
1. Carregar workflow: workflows/3d/03_triposr_single_image_to_mesh.json
2. Upload de imagem de teste
3. Queue Prompt
4. Aguardar geração (~30 seg)
5. Download do modelo 3D (.glb)
```

### Etapa 6.4: Validação Final
```batch
1. Modelo 3D gerado com sucesso
2. Arquivo .glb pode ser aberto
3. Sistema funcionando perfeitamente
```

---

## 📊 MATRIZ DE TESTES

| # | Teste | Status | Critério | Resultado |
|---|-------|--------|----------|-----------|
| 1 | Encoding dos arquivos | ⏳ | ASCII puro | - |
| 2 | Sintaxe batch | ⏳ | Sem erros | - |
| 3 | DIAGNOSTIC_TEST.bat | ⏳ | Executa completo | - |
| 4 | AIEXX_LAUNCHER.bat (install) | ⏳ | Modo instalação OK | - |
| 5 | AIEXX_LAUNCHER.bat (launcher) | ⏳ | Modo launcher OK | - |
| 6 | Detecção Python | ⏳ | Python encontrado | - |
| 7 | Criação venv | ⏳ | venv criado | - |
| 8 | Compilação .exe | ⏳ | .exe gerado | - |
| 9 | Instalação .exe | ⏳ | Instala OK | - |
| 10 | Execução final | ⏳ | Sistema funciona | - |

---

## 📝 CHECKLIST DE EXECUÇÃO

### Pré-Execução
- [ ] Backup criado
- [ ] Python 3.11.9 instalado
- [ ] Privilégios de Admin
- [ ] 55GB espaço livre
- [ ] Internet ativa

### Fase 1: Organização
- [ ] Estrutura criada
- [ ] Arquivos movidos
- [ ] LEGACY populado
- [ ] README criados

### Fase 2: Testes Unitários
- [ ] Encoding verificado
- [ ] Sintaxe validada
- [ ] Diagnostic executado
- [ ] Launcher testado (ambos modos)

### Fase 3: Testes de Integração
- [ ] Python detectado
- [ ] Venv testado
- [ ] Estrutura validada

### Fase 4: Compilação
- [ ] Inno Setup instalado
- [ ] (Opcional) Ícone criado
- [ ] .exe compilado

### Fase 5: Testes Instalador
- [ ] Instalação testada
- [ ] Pós-instalação validada
- [ ] Desinstalação testada

### Fase 6: Demonstração
- [ ] Instalação completa executada
- [ ] Sistema iniciado
- [ ] Workflow testado
- [ ] 3D gerado com sucesso

---

## 🚀 ORDEM DE EXECUÇÃO

### Sequência Recomendada:

```
1. BACKUP
   ↓
2. REORGANIZAÇÃO
   ↓
3. TESTES UNITÁRIOS
   ↓
4. TESTES INTEGRAÇÃO
   ↓
5. COMPILAR .EXE
   ↓
6. TESTAR .EXE
   ↓
7. DEMONSTRAÇÃO FINAL
```

### Tempo Estimado:
- Fase 1: 5 minutos
- Fase 2: 10 minutos
- Fase 3: 10 minutos
- Fase 4: 5 minutos
- Fase 5: 10 minutos
- Fase 6: 30-60 minutos (download de modelos)

**Total: ~1h30min**

---

## 📋 RELATÓRIO DE EXECUÇÃO

### Executado em: _____________
### Executor: _____________
### Resultado: [ ] SUCESSO [ ] FALHA

### Notas:
```
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
```

---

## 🎯 CRITÉRIOS DE SUCESSO GERAL

### Mínimo Aceitável:
- ✅ AIEXX_LAUNCHER.bat executa sem erros
- ✅ Todos os testes unitários passam
- ✅ Instalador .exe compila

### Ideal:
- ✅ Todos os critérios mínimos
- ✅ Instalador .exe testado e funcional
- ✅ Sistema completo executando
- ✅ Modelo 3D gerado com sucesso

---

**Status:** ⏳ AGUARDANDO EXECUÇÃO
**Próximo Passo:** Executar FASE 1 - Organização de Arquivos

# AIEXX - Guia de Compilação do Instalador .EXE

## 🎯 TUDO PRONTO PARA CRIAR O .EXE!

Todos os arquivos necessários já foram criados. Agora basta seguir os passos abaixo.

---

## 📦 ARQUIVOS CRIADOS

### ✅ Arquivos do Instalador

| Arquivo | Descrição | Status |
|---------|-----------|--------|
| `LICENSE.txt` | Licença MIT | ✅ Criado |
| `AIEXX_Installer.iss` | Script Inno Setup | ✅ Criado |
| `innosetup_installer.exe` | Instalador do Inno Setup | ✅ Baixado |
| `PROJECT_ORGANIZATION.md` | Organização completa | ✅ Criado |
| `REORGANIZE_PROJECT.bat` | Script de reorganização | ✅ Criado |

### ⚠️ Arquivo Faltando (Opcional)

| Arquivo | Descrição | Status |
|---------|-----------|--------|
| `aiexx_icon.ico` | Ícone do instalador | ❌ Precisa criar |

---

## 🚀 PASSO A PASSO PARA CRIAR O .EXE

### PASSO 1: Instalar Inno Setup

```batch
# Execute o instalador baixado:
innosetup_installer.exe
```

**Opções de instalação:**
- ✅ Aceite os termos de licença
- ✅ Instalação completa (Full Installation)
- ✅ Deixe as opções padrão

**Tempo:** ~2 minutos

---

### PASSO 2: Criar Ícone (Opcional mas Recomendado)

#### Opção A: Usar Ferramenta Online
1. Acesse: https://converticon.com/
2. Faça upload de uma imagem do logo AIEXX
3. Selecione tamanhos: 16x16, 32x32, 48x48, 256x256
4. Baixe como `aiexx_icon.ico`
5. Salve em: `C:\AIEXX_GENAI_IMAGE_TO_3D\`

#### Opção B: Usar o Logo ASCII (Temporário)
Se não tiver ícone agora, remova esta linha do script:
```iss
SetupIconFile=aiexx_icon.ico
```

---

### PASSO 3: Compilar o Instalador

#### Método A: Interface Gráfica (Mais Fácil)

1. **Abrir Inno Setup Compiler**
   - Menu Iniciar → Inno Setup → Inno Setup Compiler

2. **Abrir o Script**
   - File → Open
   - Navegue até: `C:\AIEXX_GENAI_IMAGE_TO_3D\AIEXX_Installer.iss`

3. **Compilar**
   - Build → Compile (ou pressione F9)
   - Aguarde a compilação (~30 segundos)

4. **Localizar o .EXE**
   - O instalador estará em: `C:\AIEXX_GENAI_IMAGE_TO_3D\installer_output\AIEXX_Setup_v1.1.0.exe`

#### Método B: Linha de Comando

```batch
# Navegue até a pasta do Inno Setup
cd "C:\Program Files (x86)\Inno Setup 6"

# Compile o script
iscc.exe "C:\AIEXX_GENAI_IMAGE_TO_3D\AIEXX_Installer.iss"
```

---

### PASSO 4: Testar o Instalador

1. **Copiar para VM ou outro PC** (recomendado)
   - VM Windows limpa
   - Ou outro computador de teste

2. **Executar o instalador**
   ```batch
   AIEXX_Setup_v1.1.0.exe
   ```

3. **Verificar:**
   - ✅ Tela de licença MIT aparece
   - ✅ Instalação completa sem erros
   - ✅ Atalhos criados (Desktop e Menu Iniciar)
   - ✅ AIEXX_LAUNCHER.bat funciona

---

## 📋 CHECKLIST PRÉ-COMPILAÇÃO

Antes de compilar, verifique:

### Arquivos Essenciais
- [ ] `AIEXX_LAUNCHER.bat` existe
- [ ] `DIAGNOSTIC_TEST.bat` existe
- [ ] Scripts 1-5 existem
- [ ] `LICENSE.txt` existe
- [ ] `README.md` existe
- [ ] `START_HERE.md` existe

### Opcional mas Recomendado
- [ ] `aiexx_icon.ico` criado
- [ ] Pasta `workflows` existe com arquivos .json
- [ ] Testou `AIEXX_LAUNCHER.bat` e funciona

### Documentação
- [ ] `COMO_USAR.md` existe
- [ ] `TESTING_GUIDE.md` existe
- [ ] `PROJECT_ORGANIZATION.md` existe

---

## 🔧 PERSONALIZAÇÃO DO INSTALADOR

### Alterar Versão

No arquivo `AIEXX_Installer.iss`:

```iss
AppVersion=1.1.0  ← Altere aqui
```

### Adicionar Mais Arquivos

```iss
[Files]
Source: "novo_arquivo.txt"; DestDir: "{app}"; Flags: ignoreversion
```

### Criar Atalho Adicional

```iss
[Icons]
Name: "{group}\Meu Atalho"; Filename: "{app}\meu_arquivo.bat"
```

---

## 📊 TAMANHO DO INSTALADOR

**Estimativa:**
- Scripts batch: ~100KB
- Documentação: ~500KB
- **Total compactado:** ~600KB - 1MB

**Nota:** O instalador NÃO inclui:
- Python (usuário deve ter instalado)
- ComfyUI (baixado durante instalação)
- Modelos 3D (baixados durante instalação)

---

## 🎨 SOBRE O ÍCONE

### Especificações Recomendadas

- **Formato:** .ICO
- **Tamanhos:** 16x16, 32x32, 48x48, 256x256
- **Cores:** 32-bit com transparência
- **Estilo:** Logo AIEXX com fundo transparente

### Design Sugerido

```
┌─────────────┐
│   ████ ███  │  ← Letras AIEXX estilizadas
│  ██  ██  ██ │     em azul ciano (#00D9FF)
│ ████████████│     sobre fundo azul escuro
│██          █│     (#0B1F3F) com gradiente
│█    3D     █│  ← "3D" destacado em dourado
└─────────────┘
```

---

## ⚙️ CONFIGURAÇÕES AVANÇADAS

### Adicionar Assinatura Digital (Opcional)

**Requer:** Certificado de assinatura de código (~$100-400/ano)

```batch
# Após compilar, assinar com:
signtool sign /f certificado.pfx /p senha AIEXX_Setup_v1.1.0.exe
```

### Auto-Update (Futuro)

No script Inno Setup, já está configurado:
```iss
AppUpdatesURL=https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/releases
```

---

## 🐛 SOLUÇÃO DE PROBLEMAS DE COMPILAÇÃO

### Erro: "Cannot find file"

**Causa:** Arquivo referenciado no .iss não existe

**Solução:**
1. Verifique se todos os arquivos existem
2. Ou remova/comente linhas de arquivos faltantes

### Erro: "Invalid icon file"

**Causa:** Arquivo .ico inválido ou não existe

**Solução:**
1. Crie um ícone válido
2. Ou remova a linha `SetupIconFile=`

### Compilação Bem-Sucedida mas .EXE Não Aparece

**Causa:** Pasta de saída não foi criada

**Solução:**
```batch
mkdir installer_output
```

---

## 📦 DISTRIBUIÇÃO DO INSTALADOR

### Após criar o .EXE:

1. **Testar em VM Limpa**
   - Windows 10/11 recém-instalado
   - Sem Python, sem dependências
   - Verificar instalação completa

2. **Criar Release no GitHub**
   ```
   - Tag: v1.1.0
   - Nome: AIEXX v1.1.0 - Image to 3D Generator
   - Anexar: AIEXX_Setup_v1.1.0.exe
   ```

3. **Documentar Requisitos**
   - Windows 10/11 64-bit
   - 16GB RAM (32GB recomendado)
   - GPU NVIDIA com 8GB+ VRAM
   - 55GB espaço livre

---

## 🎯 PRÓXIMOS PASSOS APÓS CRIAR .EXE

1. ✅ Instalar Inno Setup
2. ✅ Criar ícone (opcional)
3. ✅ Compilar instalador
4. ✅ Testar em VM
5. 🔄 Distribuir (GitHub Releases)

---

## 📝 RESUMO RÁPIDO

```batch
# 1. Instalar Inno Setup
innosetup_installer.exe

# 2. (Opcional) Criar ícone
# Usar: https://converticon.com/

# 3. Compilar
# Abrir: AIEXX_Installer.iss no Inno Setup
# Pressionar: F9

# 4. Testar
installer_output\AIEXX_Setup_v1.1.0.exe

# 5. Distribuir!
```

---

## 🎓 RESULTADO FINAL

Ao final, você terá:

```
📦 AIEXX_Setup_v1.1.0.exe
   ├─ Instalador profissional
   ├─ Tela de licença MIT
   ├─ Ícone personalizado
   ├─ Atalhos automáticos
   ├─ Desinstalador integrado
   └─ Pronto para distribuição!
```

**Tamanho:** ~600KB - 1MB
**Compatibilidade:** Windows 10/11 64-bit
**Licença:** MIT

---

**Versão:** 1.1.0
**Data:** 2025-11-01
**Status:** Pronto para compilação!

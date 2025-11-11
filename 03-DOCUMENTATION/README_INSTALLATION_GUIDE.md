# AIEXX GenAI Image to 3D - Guia de Instalação Profissional

![AIEXX Logo](../aiexx_logo_ascii.txt)

**Versão:** 1.2.0
**Data:** Janeiro 2025
**Licença:** MIT

---

## 📋 Índice

1. [Requisitos do Sistema](#requisitos-do-sistema)
2. [Instalação Rápida](#instalação-rápida)
3. [Instalação Detalhada](#instalação-detalhada)
4. [Estrutura do Projeto](#estrutura-do-projeto)
5. [Solução de Problemas](#solução-de-problemas)
6. [Logs e Diagnóstico](#logs-e-diagnóstico)
7. [Suporte](#suporte)

---

## 🖥️ Requisitos do Sistema

### Requisitos Mínimos

| Componente | Especificação |
|-----------|---------------|
| **SO** | Windows 10/11 (64-bit) |
| **CPU** | Intel i5 ou AMD Ryzen 5 (4+ cores) |
| **RAM** | 16 GB |
| **GPU** | NVIDIA GTX 1660 ou superior (6GB VRAM) |
| **Armazenamento** | 55 GB livres (SSD recomendado) |
| **Internet** | Conexão banda larga (20-30 GB download) |

### Requisitos Recomendados

| Componente | Especificação |
|-----------|---------------|
| **CPU** | Intel i7/i9 ou AMD Ryzen 7/9 (8+ cores) |
| **RAM** | 32 GB ou mais |
| **GPU** | NVIDIA RTX 3060 ou superior (12GB VRAM) |
| **Armazenamento** | 100 GB livres em SSD NVMe |

### Software Necessário

- **Python 3.11.9** (instalado automaticamente se necessário)
- **Visual Studio Build Tools 2022** (instalado automaticamente)
- **CUDA Toolkit 12.8** (instalado automaticamente)
- **Git** (opcional, para atualizações)

---

## ⚡ Instalação Rápida

### Opção 1: Instalação Automática (Recomendado)

1. **Baixe o projeto:**
   ```bash
   git clone https://github.com/seu-usuario/AIEXX_GENAI_IMAGE_TO_3D.git
   cd AIEXX_GENAI_IMAGE_TO_3D
   ```

2. **Execute o launcher:**
   ```batch
   00-LAUNCHER\AIEXX_LAUNCHER.bat
   ```

3. **Siga as instruções na tela:**
   - O sistema detectará automaticamente se é primeira instalação
   - Instalará todos os componentes necessários
   - Pedirá reinicialização após instalar Build Tools
   - Continuará automaticamente após reiniciar

4. **Pronto!** O sistema abrirá automaticamente em `http://localhost:8188`

### Tempo Estimado de Instalação

- **Download:** 15-30 minutos (dependendo da conexão)
- **Instalação:** 30-45 minutos
- **Total:** 45-75 minutos

---

## 📚 Instalação Detalhada

### Passo 1: Preparação

1. **Libere espaço em disco:**
   - Mínimo: 55 GB
   - Recomendado: 100 GB

2. **Verifique drivers NVIDIA:**
   ```batch
   nvidia-smi
   ```
   - Se não funcionar, atualize os drivers: [NVIDIA Driver Downloads](https://www.nvidia.com/Download/index.aspx)

3. **Desabilite antivírus temporariamente** (opcional, mas recomendado durante instalação)

### Passo 2: Visual Studio Build Tools

O launcher executará automaticamente, mas você pode instalar manualmente:

```batch
01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS.bat
```

**Importante:** Após esta etapa, REINICIE o computador!

### Passo 3: Python Virtual Environment

Após reiniciar, execute novamente o launcher ou manualmente:

```batch
01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
```

Este script:
- Cria ambiente virtual `.venv311`
- Instala PyTorch 2.7.0 com CUDA 12.8
- Compila e instala `torch_scatter`

**Tempo estimado:** 10-20 minutos

### Passo 4: ComfyUI e 3D-Pack

```batch
01-SETUP-SCRIPTS\3-RUN_INSTALL_3DPACK.bat
```

Este script:
- Instala ComfyUI
- Instala ComfyUI-3D-Pack
- Compila dependências C++/CUDA

**Tempo estimado:** 15-30 minutos

### Passo 5: Download de Modelos

```batch
01-SETUP-SCRIPTS\4-DOWNLOAD_3D_MODELS.bat
```

Este script baixa:
- TripoSR (modelo principal)
- Stable Diffusion models
- Outros modelos 3D

**Tempo estimado:** 20-40 minutos (20-30 GB download)

### Passo 6: Verificação

Execute o diagnóstico completo:

```batch
00-LAUNCHER\DIAGNOSTIC_COMPLETE.bat
```

Verifique se todos os checks passaram (verde).

---

## 📁 Estrutura do Projeto

```
AIEXX_GENAI_IMAGE_TO_3D/
│
├── 00-LAUNCHER/              # Scripts de lançamento
│   ├── AIEXX_LAUNCHER.bat    # Launcher principal (EXECUTE ESTE!)
│   ├── DIAGNOSTIC_COMPLETE.bat
│   └── TEST_LAUNCHER.bat
│
├── 01-SETUP-SCRIPTS/         # Scripts de instalação
│   ├── 1-INSTALL_VS_BUILDTOOLS.bat
│   ├── 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
│   ├── 3-RUN_INSTALL_3DPACK.bat
│   └── 4-DOWNLOAD_3D_MODELS.bat
│
├── 02-PYTHON-SCRIPTS/        # Scripts Python auxiliares
│   └── download_models.py
│
├── 03-DOCUMENTATION/         # Documentação
│   ├── README_INSTALLATION_GUIDE.md (este arquivo)
│   └── TROUBLESHOOTING.md
│
├── 04-WORKFLOWS/             # Workflows do ComfyUI
│   └── 3d/
│
├── 05-RELEASE/               # Arquivos de release
│
├── ComfyUI/                  # ComfyUI instalado
├── .venv311/                 # Ambiente virtual Python
├── logs/                     # Logs do sistema
│
├── .aiexx_installed          # Marker de instalação completa
├── .aiexx_checkpoint         # Checkpoint de instalação
└── aiexx_logo_ascii.txt      # Logo ASCII
```

---

## 🔧 Solução de Problemas

### Problema: "Ambiente virtual não encontrado"

**Causa:** A pasta `.venv311` não foi criada corretamente.

**Solução:**
```batch
01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
```

### Problema: "Visual Studio Build Tools não encontrado"

**Causa:** Build Tools não instalados ou PATH não configurado.

**Solução:**
1. Execute manualmente:
   ```batch
   01-SETUP-SCRIPTS\1-INSTALL_VS_BUILDTOOLS.bat
   ```
2. **REINICIE** o computador
3. Tente novamente

### Problema: "CUDA Toolkit não encontrado"

**Causa:** CUDA não instalado ou não está no PATH.

**Solução:**
1. Verifique instalação:
   ```batch
   where nvcc
   ```
2. Se não encontrado, instale: [CUDA Toolkit 12.8](https://developer.nvidia.com/cuda-downloads)
3. Reinicie o computador

### Problema: "torch_scatter falha ao instalar"

**Causa:** Compilação C++ falhou.

**Solução:**
1. Verifique se Visual Studio Build Tools está instalado
2. Reinicie o computador
3. Execute novamente:
   ```batch
   01-SETUP-SCRIPTS\2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat
   ```

### Problema: "ComfyUI não inicia"

**Causa:** Porta 8188 ocupada ou GPU não disponível.

**Solução:**
1. Verifique porta:
   ```batch
   netstat -ano | findstr :8188
   ```
2. Mate processo se necessário:
   ```batch
   taskkill /PID [PID_NUMBER] /F
   ```
3. Verifique GPU:
   ```batch
   nvidia-smi
   ```

### Problema: "Janela abre e fecha rapidamente"

**Causa:** Erro não capturado ou PATH incorreto.

**Solução:**
1. Abra CMD manualmente:
   ```batch
   cd C:\AIEXX_GENAI_IMAGE_TO_3D\00-LAUNCHER
   AIEXX_LAUNCHER.bat
   ```
2. Leia mensagens de erro
3. Verifique logs em: `logs\launcher_[DATA].log`

---

## 📊 Logs e Diagnóstico

### Localização dos Logs

Todos os logs são salvos em:
```
C:\AIEXX_GENAI_IMAGE_TO_3D\logs\
```

Tipos de logs:
- `launcher_YYYYMMDD_HHMMSS.log` - Log do launcher
- `aiexx_diagnostic_YYYYMMDD_HHMMSS.log` - Log de diagnóstico

### Executar Diagnóstico Completo

```batch
00-LAUNCHER\DIAGNOSTIC_COMPLETE.bat
```

O diagnóstico verifica:
1. ✅ Informações do sistema
2. ✅ Git (opcional)
3. ✅ Python
4. ✅ Ambiente virtual
5. ✅ Visual Studio Build Tools
6. ✅ CUDA Toolkit
7. ✅ PyTorch
8. ✅ ComfyUI
9. ✅ Modelos 3D
10. ✅ Espaço em disco

### Interpretando Resultados

- **[OK]** - Verde: Tudo funcionando
- **[WARNING]** - Amarelo: Funcional mas não ideal
- **[ERRO]** - Vermelho: Problema crítico

---

## 🆘 Suporte

### Antes de Pedir Ajuda

1. Execute o diagnóstico:
   ```batch
   00-LAUNCHER\DIAGNOSTIC_COMPLETE.bat
   ```

2. Verifique os logs:
   ```batch
   notepad logs\launcher_[ultima_data].log
   ```

3. Leia a seção de troubleshooting acima

### Como Reportar Problemas

Ao abrir uma issue, inclua:

1. **Resumo do diagnóstico** (copie do terminal)
2. **Logs relevantes** (anexe arquivos da pasta `logs/`)
3. **Passos para reproduzir**
4. **Screenshots** (se aplicável)
5. **Especificações do sistema:**
   - SO e versão
   - CPU e RAM
   - GPU e VRAM
   - Espaço em disco

### Links Úteis

- 📖 [Documentação ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- 🎨 [ComfyUI-3D-Pack](https://github.com/MrForExample/ComfyUI-3D-Pack)
- 🔧 [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)
- 🐍 [Python Downloads](https://www.python.org/downloads/)

---

## 📝 Notas de Versão

### v1.2.0 (Atual)

✨ **Novidades:**
- ✅ Sistema de logging profissional
- ✅ Diagnóstico completo automatizado
- ✅ Tratamento robusto de erros
- ✅ Checkpoints de instalação
- ✅ Melhor navegação de diretórios
- ✅ Mensagens de erro detalhadas
- ✅ Pausas estratégicas para debug

🐛 **Correções:**
- ✅ Caminhos relativos corrigidos
- ✅ Codificação UTF-8 padronizada
- ✅ Validação de ambiente virtual
- ✅ Detecção de scripts missing

---

## 📄 Licença

Este projeto está licenciado sob a Licença MIT.

```
MIT License

Copyright (c) 2025 AIEXX Team

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

---

**Feito com ❤️ pela equipe AIEXX**

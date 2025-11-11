# Instruções para Instalar CUDA Toolkit 12.8

## Por que é necessário?

O CUDA Toolkit é necessário para compilar dependências do ComfyUI-3D-Pack, incluindo o módulo `nvdiffrast` que é usado pelos nós do TripoSR.

Atualmente seu sistema tem:
- ✅ PyTorch 2.6.0+cu124 (CUDA runtime integrado)
- ❌ CUDA Toolkit (compilador e ferramentas de desenvolvimento)

## Passos para Instalação

### 1. Download do CUDA Toolkit 12.8

**Opção A: Link Direto (Recomendado)**
```
https://developer.nvidia.com/cuda-12-8-0-download-archive
```

**Opção B: Seleção Manual**
1. Acesse: https://developer.nvidia.com/cuda-downloads
2. Selecione:
   - Operating System: **Windows**
   - Architecture: **x86_64**
   - Version: **11** (ou 10 se for Windows 10)
   - Installer Type: **exe (network)** (~3MB) ou **exe (local)** (~3GB)

### 2. Informações do Download

- **Tamanho**:
  - Network installer: ~3MB (baixa componentes durante instalação)
  - Local installer: ~3GB (instalação offline completa)
- **Tempo estimado**:
  - Download: 5-15 minutos (depende da internet)
  - Instalação: 15-30 minutos

### 3. Instalação

1. Execute o instalador como **Administrador**
2. Escolha **Instalação Expressa** (recomendado)
   - Instala todos os componentes necessários automaticamente
3. Ou escolha **Instalação Personalizada** e selecione:
   - ✅ CUDA Development Tools
   - ✅ CUDA Runtime
   - ✅ CUDA Documentation (opcional)
   - ✅ Visual Studio Integration (se tem VS instalado)

### 4. Verificar Instalação

Após instalação, abra um novo terminal (importante ser novo!) e execute:

```batch
nvcc --version
```

Deve aparecer algo como:
```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2024 NVIDIA Corporation
Built on ...
Cuda compilation tools, release 12.8, ...
```

### 5. Reiniciar Sistema

**IMPORTANTE**: Após instalação, reinicie o computador para que as variáveis de ambiente sejam configuradas corretamente.

## Próximos Passos

Após reiniciar o sistema, volte ao projeto e me avise. Continuarei com:

1. Executar `install.py` do ComfyUI-3D-Pack
2. Compilar nvdiffrast e outras dependências
3. Reiniciar servidor ComfyUI
4. Testar workflows com TripoSR

## Problemas Comuns

### "Visual Studio Build Tools required"
Se aparecer esse erro durante instalação, você pode precisar instalar:
- Visual Studio 2022 Build Tools: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
- Ou Visual Studio Community 2022 (versão completa)
- Selecione apenas "Desktop development with C++"

### "nvcc not found" após instalação
- Reinicie o computador
- Verifique se `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8\bin` está no PATH
- Abra um **novo** terminal (importante!)

### Problemas de espaço em disco
- CUDA Toolkit precisa de ~6GB de espaço livre
- Certifique-se de ter espaço suficiente em C:\

## Links Úteis

- CUDA Toolkit Documentation: https://docs.nvidia.com/cuda/
- CUDA Installation Guide Windows: https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/

---

**Status**: Aguardando instalação do CUDA Toolkit pelo usuário

**Próximo passo**: Após reiniciar, execute este comando para verificar:
```batch
cd C:\AIEXX_GENAI_IMAGE_TO_3D
.venv311\Scripts\python.exe -c "import subprocess; print(subprocess.run(['nvcc', '--version'], capture_output=True, text=True).stdout)"
```

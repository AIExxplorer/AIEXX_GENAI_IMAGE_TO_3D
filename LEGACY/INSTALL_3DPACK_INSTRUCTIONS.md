# Instruções para Instalar ComfyUI-3D-Pack

## Situação Atual

✅ CUDA Toolkit 12.8 instalado em: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8`
✅ Script de instalação criado: `install_comfyui_3d_pack.bat`
⚠️ Precisa executar o script manualmente para instalar as dependências

## Opção 1: Executar Batch Script (RECOMENDADO - Mais Fácil)

### Passo a Passo:

1. **Abra o Windows Explorer**
   - Navegue para: `C:\AIEXX_GENAI_IMAGE_TO_3D`

2. **Execute o Script**
   - Dê um **duplo-clique** em: `install_comfyui_3d_pack.bat`
   - Uma janela de terminal irá abrir

3. **Aguarde a Instalação**
   - O script irá:
     - Verificar se o CUDA está disponível
     - Baixar wheels pré-compilados
     - Instalar nvdiffrast e outras dependências
     - Compilar pacotes necessários
   - **Tempo estimado: 10-30 minutos**
   - Verá mensagens como:
     ```
     Installing packages...
     Building wheels...
     Successfully installed...
     ```

4. **Verificar Sucesso**
   - No final deve aparecer:
     ```
     Successfully installed Comfy3D! Let's Accelerate!
     ```
   - Pressione qualquer tecla para fechar

## Opção 2: Adicionar CUDA ao PATH Manualmente (Alternativa)

Se o script não funcionar, adicione o CUDA ao PATH do sistema:

### Windows 11/10:

1. **Abrir Configurações de Ambiente**
   - Pressione `Win + R`
   - Digite: `sysdm.cpl` e pressione Enter
   - Vá para aba **"Avançado"**
   - Clique em **"Variáveis de Ambiente"**

2. **Editar PATH do Sistema**
   - Na seção **"Variáveis do sistema"**
   - Selecione **"Path"**
   - Clique em **"Editar"**
   - Clique em **"Novo"**
   - Adicione: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8\bin`
   - Clique em **"OK"** em todas as janelas

3. **Criar Variável CUDA_PATH**
   - Ainda em "Variáveis do sistema"
   - Clique em **"Novo"**
   - Nome: `CUDA_PATH`
   - Valor: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8`
   - Clique em **"OK"**

4. **Reiniciar Terminal**
   - Feche todos os terminais abertos
   - Abra um **novo** terminal
   - Execute: `nvcc --version`
   - Deve mostrar CUDA 12.8

5. **Executar Instalação**
   - Abra terminal como **Administrador**
   - Execute:
     ```batch
     cd C:\AIEXX_GENAI_IMAGE_TO_3D
     .venv311\Scripts\python.exe ComfyUI\custom_nodes\ComfyUI-3D-Pack\install.py
     ```

## O Que a Instalação Faz

1. **Detecta seu ambiente**:
   - Windows
   - Python 3.11
   - CUDA 12.8
   - PyTorch 2.6.0+cu124

2. **Baixa wheels pré-compilados** do repositório Comfy3D_Pre_Builds

3. **Instala pacotes**:
   - nvdiffrast (renderização diferenciável)
   - diff-gaussian-rasterization (3D Gaussian Splatting)
   - simple-knn (k-nearest neighbors)
   - pytorch3d (geometria 3D)
   - trimesh, open3d, pymeshlab (manipulação de meshes)

4. **Compila extensões C++/CUDA** se necessário

## Problemas Comuns

### "nvcc not found" no script
- **Solução**: O CUDA Toolkit não está no PATH
- **Ação**: Use Opção 2 para adicionar ao PATH manualmente

### "Visual Studio Build Tools required"
- **Solução**: Instale VS Build Tools
- **Link**: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
- Selecione: "Desktop development with C++"

### Compilação falha com erros CUDA
- **Possível causa**: RTX 5060 (sm_120) não suportado
- **Solução**: Aguardar wheels pré-compilados serem baixados (não precisa compilar)

### Downloads muito lentos
- **Causa**: Baixando do GitHub
- **Solução**: Aguardar ou usar VPN se tiver problemas de região

## Após Instalação Bem-Sucedida

Quando a instalação terminar com sucesso:

1. Me avise aqui no chat
2. Vou reiniciar o servidor ComfyUI
3. Verificarei se os nós do TripoSR carregam corretamente
4. Testaremos o workflow completo

## Verificar Instalação

Após executar, você pode verificar se funcionou:

```batch
cd C:\AIEXX_GENAI_IMAGE_TO_3D
.venv311\Scripts\python.exe -c "import nvdiffrast; print('nvdiffrast OK')"
```

Se aparecer "nvdiffrast OK", está tudo certo!

---

**Próximo Passo**: Execute `install_comfyui_3d_pack.bat` e me avise quando terminar!

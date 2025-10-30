# 🚀 ComfyUI GPU Launchers - Guia de Uso

**GPU Detectada:** NVIDIA GeForce RTX 5060 Laptop GPU

---

## 📋 Scripts Disponíveis

### 🎯 Menu Principal (Recomendado)

```bash
START_COMFYUI.bat
```

**Menu interativo com opções:**
- Modo Balanceado (recomendado)
- Modo Performance
- Modo Economia de VRAM
- Verificar GPU
- Monitor de Status

---

## 🔧 Modos de Execução

### 1. 🚀 Modo Balanceado (Recomendado)

**Arquivo:** `start_comfyui_gpu.bat`

```bash
start_comfyui_gpu.bat
```

**Características:**
- ✅ Desempenho otimizado para RTX 5060
- ✅ VRAM: Uso médio (~4-6 GB)
- ✅ Velocidade: Rápida
- ✅ Estabilidade: Alta

**Ideal para:**
- Uso geral e diário
- Workflows padrão (TripoSR, InstantMesh)
- Multitarefa moderada

**Parâmetros:**
- `--highvram` - Uso otimizado de VRAM
- `--bf16-unet` - Precisão BF16 (mais rápido)
- `--use-pytorch-cross-attention` - Atenção otimizada

---

### 2. ⚡ Modo Performance

**Arquivo:** `start_comfyui_gpu_performance.bat`

```bash
start_comfyui_gpu_performance.bat
```

**Características:**
- ✅ Máximo desempenho possível
- ⚠️ VRAM: Uso alto (~6-8 GB)
- ✅ Velocidade: Muito rápida
- ⚠️ Pode causar lentidão em outras aplicações

**Ideal para:**
- Processamento em lote
- Workflows pesados (Zero123++)
- Quando velocidade é prioridade

**Parâmetros:**
- `--highvram` - Máximo uso de VRAM
- `--bf16-unet` - Precisão BF16
- `--fp16-vae` - VAE em FP16 (mais rápido)
- `--reserve-vram 1.0` - Reserva 1GB de VRAM

---

### 3. 💾 Modo Economia de VRAM

**Arquivo:** `start_comfyui_gpu_lowvram.bat`

```bash
start_comfyui_gpu_lowvram.bat
```

**Características:**
- ✅ VRAM: Uso baixo (~2-4 GB)
- ⚠️ Velocidade: Moderada (mais lento)
- ✅ Permite multitarefa pesada
- ✅ Estabilidade: Muito alta

**Ideal para:**
- Modelos muito grandes
- Uso simultâneo de outras aplicações GPU
- Sistemas com pouca VRAM disponível
- Debugging e desenvolvimento

**Parâmetros:**
- `--lowvram` - Modo economia de VRAM
- `--use-split-cross-attention` - Atenção dividida
- `--bf16-unet` - Precisão BF16

---

## 🔍 Verificação de GPU

### Script de Verificação

```bash
# Verificação básica
.\check_gpu.ps1

# Verificar CUDA e PyTorch
.\check_gpu.ps1 -CUDA

# Informações detalhadas
.\check_gpu.ps1 -Detailed
```

**Informações fornecidas:**
- Nome e modelo da GPU
- VRAM disponível
- Versão do driver
- Status CUDA (se disponível)
- Versão PyTorch e compatibilidade
- Recomendação de modo

---

## 📊 Comparação de Modos

| Modo | VRAM | Velocidade | CPU | Ideal Para |
|------|------|------------|-----|------------|
| **Balanceado** | 4-6 GB | Rápida | Baixo | Uso diário, workflows padrão |
| **Performance** | 6-8 GB | Muito Rápida | Médio | Lotes, workflows pesados |
| **Economia** | 2-4 GB | Moderada | Alto | Modelos grandes, multitarefa |

---

## 🎯 Recomendações para RTX 5060

### ✅ Configuração Ideal

Para sua **RTX 5060 Laptop GPU**:

1. **Uso geral:** `start_comfyui_gpu.bat` (Balanceado)
2. **Processamento em lote:** `start_comfyui_gpu_performance.bat`
3. **Trabalhando em outras apps:** `start_comfyui_gpu_lowvram.bat`

### 🔥 Dicas de Otimização

1. **Feche outras aplicações GPU**
   - Navegadores (hardware acceleration)
   - Jogos
   - Outros programas de IA

2. **Atualize drivers NVIDIA**
   - Versão mais recente: https://www.nvidia.com/Download/index.aspx

3. **Monitore temperatura**
   - Use MSI Afterburner ou NVIDIA Control Panel
   - Temperatura ideal: < 80°C

4. **Configure Windows para Performance**
   - Plano de energia: Alto desempenho
   - Desative modo de economia de energia

---

## 🐛 Troubleshooting

### Erro: "Out of Memory" (CUDA)

**Solução:**
1. Use modo Economia de VRAM:
   ```bash
   start_comfyui_gpu_lowvram.bat
   ```

2. Feche outras aplicações GPU

3. Reduza resolução de texturas nos workflows

### Erro: "CUDA not available"

**Solução:**
1. Verifique instalação CUDA:
   ```bash
   .\check_gpu.ps1 -CUDA
   ```

2. Instale/atualize PyTorch com CUDA:
   ```bash
   pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
   ```

3. Atualize driver NVIDIA

### ComfyUI muito lento

**Solução:**
1. Tente modo Performance:
   ```bash
   start_comfyui_gpu_performance.bat
   ```

2. Verifique se GPU está sendo usada:
   ```bash
   nvidia-smi
   ```

3. Feche outras aplicações

### Menu não abre corretamente

**Solução:**
1. Execute como Administrador (botão direito → "Executar como administrador")

2. Verifique codificação:
   - Menu usa UTF-8
   - Se caracteres aparecerem errados, use scripts individuais

---

## 📈 Monitoramento

### Durante a Execução

**NVIDIA GPU:**
```bash
# Abrir em outro terminal
nvidia-smi -l 1
```

**Task Manager:**
- Pressione `Ctrl + Shift + Esc`
- Aba "Desempenho" → GPU
- Monitore uso de VRAM e GPU

**Monitor de Status do Projeto:**
```bash
.\monitor_status.ps1 -Live
```

---

## 🔗 Links Úteis

- **ComfyUI:** http://localhost:8188
- **Documentação:** [README.md](README.md)
- **Guia Rápido:** [QUICKSTART.md](QUICKSTART.md)
- **NVIDIA Drivers:** https://www.nvidia.com/Download/index.aspx

---

## 📝 Notas Importantes

1. **Primeira execução:** Pode demorar mais (compilação de kernels CUDA)

2. **VRAM insuficiente:** Se workflows falharem, use modo Economia de VRAM

3. **Laptop:** 
   - Mantenha conectado na tomada
   - Configure modo de desempenho (não economia de bateria)
   - Garanta boa ventilação

4. **Atualização de drivers:** 
   - Drivers mais recentes = melhor desempenho
   - Teste após atualizar

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**

Otimizado para NVIDIA GeForce RTX 5060

</div>


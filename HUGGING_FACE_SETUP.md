# 🤗 Configuração Hugging Face

Este guia explica como configurar a integração entre o repositório GitHub e o Hugging Face Hub.

---

## 📋 Pré-requisitos

1. **Conta no Hugging Face**: https://huggingface.co/join
2. **Token de Acesso HF**: https://huggingface.co/settings/tokens
   - Criar token com permissão de **write**
3. **Repositório GitHub**: `AIEXX_GENAI_IMAGE_TO_3D` (já criado)

---

## 🚀 Passos para Configuração

### 1. Criar Space no Hugging Face

1. Acesse: https://huggingface.co/new-space
2. Preencha:
   - **Owner**: `AIEXX` (ou seu username)
   - **Space name**: `genai-image-to-3d`
   - **License**: MIT
   - **SDK**: Gradio (ou Streamlit)
   - **Visibility**: Private (inicialmente)

3. Clique em **Create Space**

### 2. Configurar Secret no GitHub

1. Acesse: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/settings/secrets/actions
2. Clique em **New repository secret**
3. Preencha:
   - **Name**: `HF_TOKEN`
   - **Secret**: Cole seu token do Hugging Face
4. Clique em **Add secret**

### 3. Ajustar URL no Workflow

Edite `.github/workflows/sync-to-huggingface.yml` e ajuste a linha:

```yaml
git remote add hf https://AIExxplorer:$HF_TOKEN@huggingface.co/spaces/AIEXX/genai-image-to-3d || true
```

Substitua:
- `AIExxplorer` → seu username do HF
- `AIEXX` → owner do space
- `genai-image-to-3d` → nome do space

### 4. Testar Sincronização

Faça um commit e push para `main`:

```bash
git add .
git commit -m "feat: adiciona integração com Hugging Face"
git push origin main
```

Verifique a execução em:
https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D/actions

---

## 📦 Sincronização Manual (Opcional)

Se preferir sincronizar manualmente:

```bash
# Clonar repositório HF
git clone https://huggingface.co/spaces/AIEXX/genai-image-to-3d hf-space
cd hf-space

# Adicionar remote do GitHub
git remote add github https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D.git

# Fazer pull do GitHub
git pull github main

# Push para HF
git push origin main
```

---

## 🔗 Links Importantes

- **Repositório GitHub**: https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
- **Hugging Face Space**: https://huggingface.co/spaces/AIEXX/genai-image-to-3d (ajustar)
- **Documentação HF Spaces**: https://huggingface.co/docs/hub/spaces
- **Tokens HF**: https://huggingface.co/settings/tokens

---

## 📝 Próximos Passos

1. [ ] Criar Space no Hugging Face
2. [ ] Adicionar `HF_TOKEN` aos secrets do GitHub
3. [ ] Ajustar URL no workflow
4. [ ] Testar sincronização automática
5. [ ] Criar `app.py` para interface Gradio/Streamlit (opcional)
6. [ ] Adicionar card de modelo com exemplos
7. [ ] Configurar espaço com GPU (se necessário)

---

## 🎨 Interface Gradio (Exemplo)

Criar arquivo `app.py` para interface web:

```python
import gradio as gr

def image_to_3d(image, workflow_type):
    """
    Converte imagem 2D em malha 3D usando workflows do ComfyUI
    """
    # TODO: Implementar lógica de conversão
    return "Malha 3D gerada!"

# Interface Gradio
demo = gr.Interface(
    fn=image_to_3d,
    inputs=[
        gr.Image(type="pil", label="Upload Imagem"),
        gr.Dropdown(
            choices=["Zero123++", "TripoSR", "InstantMesh", "ControlNet"],
            label="Workflow"
        )
    ],
    outputs=gr.Model3D(label="Resultado 3D"),
    title="🎨 AIEXX GenAI Image to 3D",
    description="Pipeline completo para conversão de imagens 2D em malhas 3D"
)

if __name__ == "__main__":
    demo.launch()
```

---

<div align="center">

**Desenvolvido com ❤️ por AIEXX**

</div>


"""
AIEXX - Script de Download de Modelos 3D
Baixa automaticamente modelos necessários do Hugging Face
"""

import os
import sys
from pathlib import Path

def print_header(text):
    """Imprime cabeçalho formatado"""
    print("\n" + "="*70)
    print(f"  {text}")
    print("="*70 + "\n")

def print_step(step_num, total, text):
    """Imprime passo da instalação"""
    print(f"[{step_num}/{total}] {text}...")
    print()

def check_file_exists(filepath, name):
    """Verifica se arquivo existe e retorna tamanho"""
    if os.path.exists(filepath):
        size_mb = os.path.getsize(filepath) / (1024 * 1024)
        print(f"  [OK] {name} já existe ({size_mb:.1f} MB)")
        print(f"       {filepath}")
        return True
    return False

def download_model(repo_id, filename, local_dir, name):
    """Baixa modelo do Hugging Face com retry"""
    print(f"  [INFO] Baixando {name}...")
    print(f"         Repositório: {repo_id}")
    print(f"         Arquivo: {filename}")
    print(f"         Destino: {local_dir}")
    print()

    try:
        from huggingface_hub import hf_hub_download
        from tqdm import tqdm

        # Criar diretório se não existir
        os.makedirs(local_dir, exist_ok=True)

        # Download com progresso
        downloaded_path = hf_hub_download(
            repo_id=repo_id,
            filename=filename,
            local_dir=local_dir,
            local_dir_use_symlinks=False,
            resume_download=True  # Permite continuar download interrompido
        )

        if os.path.exists(downloaded_path):
            size_mb = os.path.getsize(downloaded_path) / (1024 * 1024)
            print(f"\n  [OK] {name} baixado com sucesso! ({size_mb:.1f} MB)")
            return True
        else:
            print(f"\n  [ERRO] Falha ao baixar {name}")
            return False

    except ImportError:
        print("  [ERRO] huggingface-hub não instalado!")
        print("  Execute: pip install huggingface-hub")
        return False
    except Exception as e:
        print(f"\n  [ERRO] Falha ao baixar {name}: {e}")
        return False

def main():
    print_header("AIEXX - Download de Modelos 3D")

    # Diretório base
    base_dir = Path(__file__).parent
    os.chdir(base_dir)

    # Estrutura de diretórios
    models_structure = {
        "ComfyUI/models/checkpoints": "Stable Diffusion checkpoints",
        "ComfyUI/models/triposr": "TripoSR models",
        "ComfyUI/models/zero123": "Zero123 models",
        "ComfyUI/models/vae": "VAE models",
        "ComfyUI/models/clip": "CLIP models",
    }

    print_step(1, 4, "Criando estrutura de diretórios")

    for dir_path, description in models_structure.items():
        full_path = base_dir / dir_path
        full_path.mkdir(parents=True, exist_ok=True)
        print(f"  [OK] {dir_path}")

    print()

    # Modelos a baixar
    models_to_download = [
        {
            "name": "TripoSR",
            "repo_id": "stabilityai/TripoSR",
            "filename": "model.ckpt",
            "local_dir": "ComfyUI/models/triposr",
            "size_estimate": "~1.5 GB"
        },
    ]

    print_step(2, 4, "Verificando modelos existentes")

    # Verificar TripoSR
    triposr_path = base_dir / "ComfyUI/models/triposr/model.ckpt"
    triposr_exists = check_file_exists(triposr_path, "TripoSR")

    # Verificar SD 1.5
    sd15_path = base_dir / "ComfyUI/models/checkpoints/v1-5-pruned-emaonly.safetensors"
    sd15_exists = check_file_exists(sd15_path, "Stable Diffusion 1.5")

    print()

    # Baixar modelos faltantes
    print_step(3, 4, "Baixando modelos faltantes")

    if not triposr_exists:
        print(f"  Modelo TripoSR (~1.5 GB)")
        print(f"  Este download pode levar 5-15 minutos...\n")

        success = download_model(
            repo_id="stabilityai/TripoSR",
            filename="model.ckpt",
            local_dir=str(base_dir / "ComfyUI/models/triposr"),
            name="TripoSR"
        )

        if not success:
            print("\n  [AVISO] Download manual necessário:")
            print("  1. Acesse: https://huggingface.co/stabilityai/TripoSR")
            print("  2. Baixe: model.ckpt")
            print(f"  3. Salve em: {triposr_path}")

        print()

    if not sd15_exists:
        print("  [AVISO] Stable Diffusion 1.5 não encontrado!")
        print("  Execute: SETUP_SD_MODELS.bat")
        print()

    # Resumo final
    print_step(4, 4, "Resumo dos modelos")

    print("  MODELOS PRINCIPAIS:")
    print()

    # Verificar novamente
    if os.path.exists(triposr_path):
        size_mb = os.path.getsize(triposr_path) / (1024 * 1024)
        print(f"  [OK] TripoSR              {size_mb:.1f} MB")
    else:
        print(f"  [X]  TripoSR              NAO ENCONTRADO")

    if os.path.exists(sd15_path):
        size_mb = os.path.getsize(sd15_path) / (1024 * 1024)
        print(f"  [OK] SD 1.5               {size_mb:.1f} MB")
    else:
        print(f"  [X]  SD 1.5               NAO ENCONTRADO")

    print()

    # Verificar se está tudo pronto
    all_ready = os.path.exists(triposr_path) and os.path.exists(sd15_path)

    if all_ready:
        print_header("TODOS OS MODELOS INSTALADOS!")
        print("  Sistema pronto para uso!\n")
        print("  Proximos passos:")
        print("    1. Execute: START_AIEXX.bat")
        print("    2. Acesse: http://localhost:8188")
        print("    3. Carregue workflow: workflows/3d/basic/AIEXX_prompt_to_3d_triposr.json")
        print()
    else:
        print("\n  [AVISO] Alguns modelos ainda estao faltando.")
        print("  Consulte as mensagens acima para mais informacoes.\n")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n[INFO] Download interrompido pelo usuário.")
        sys.exit(0)
    except Exception as e:
        print(f"\n[ERRO] Erro inesperado: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

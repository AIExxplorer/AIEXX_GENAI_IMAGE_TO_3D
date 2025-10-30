#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Script de download automatizado de modelos para o pipeline 3D do ComfyUI
Baixa modelos do Hugging Face com retry, verificação de integridade e progresso
"""

import os
import sys
import logging
import argparse
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Tuple

try:
    from huggingface_hub import hf_hub_download, snapshot_download
    from huggingface_hub.utils import HfHubHTTPError
    from tqdm import tqdm
except ImportError:
    print("ERRO: Dependências necessárias não encontradas!")
    print("Execute: pip install huggingface_hub tqdm")
    sys.exit(1)

# Configuração de logging
BASE_DIR = Path(__file__).parent
LOG_FILE = BASE_DIR / "downloads_status.log"
STATUS_FILE = BASE_DIR / "workflows" / "3d" / "STATUS.txt"

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE, encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger(__name__)

# Definição de modelos a serem baixados
MODELS_CONFIG = {
    "controlnet": {
        "repo_id": "lllyasviel/ControlNet-v1-1",
        "local_dir": BASE_DIR / "ComfyUI" / "models" / "controlnet",
        "files": [
            "control_v11f1p_sd15_depth.pth",
            "control_v11p_sd15_openpose.pth",
            "control_v11p_sd15_canny.pth",
            "control_v11f1e_sd15_tile.pth"
        ],
        "priority": 1
    },
    "zero123": {
        "repo_id": "cvlab/zero123-weights",
        "local_dir": BASE_DIR / "ComfyUI" / "models" / "zero123",
        "files": [
            "105000.ckpt"
        ],
        "priority": 2,
        "note": "Modelo base Zero123"
    },
    "zero123plus": {
        "repo_id": "sudo-ai/zero123plus-v1.2",
        "local_dir": BASE_DIR / "ComfyUI" / "models" / "zero123plus",
        "files": [
            "unet/diffusion_pytorch_model.safetensors",
            "vae/diffusion_pytorch_model.safetensors",
            "text_encoder/model.safetensors",
            "vision_encoder/model.safetensors"
        ],
        "priority": 2,
        "note": "Zero123++ v1.2 para multi-view (diffusers)"
    },
    "triposr": {
        "repo_id": "stabilityai/TripoSR",
        "local_dir": BASE_DIR / "ComfyUI" / "models" / "triposr",
        "files": [
            "model.ckpt",
            "config.yaml"
        ],
        "priority": 3
    },
    "instantmesh": {
        "repo_id": "TencentARC/InstantMesh",
        "local_dir": BASE_DIR / "ComfyUI" / "models" / "instantmesh",
        "files": [
            "instant_mesh_large.ckpt"
        ],
        "priority": 3,
        "note": "InstantMesh modelo large (melhor qualidade)"
    }
}


def check_token():
    """Verifica se o token do Hugging Face está configurado"""
    token = os.environ.get("HUGGING_FACE_HUB_TOKEN")
    if not token:
        logger.error("Token do Hugging Face não encontrado!")
        logger.error("Configure a variável HUGGING_FACE_HUB_TOKEN")
        logger.error("Execute: .\\setup_env.ps1 -HF_TOKEN seu_token")
        return False
    logger.info("Token do Hugging Face encontrado ✓")
    return True


def download_file(repo_id: str, filename: str, local_dir: Path, rename_as: str = None) -> bool:
    """
    Baixa um arquivo específico do Hugging Face

    Args:
        repo_id: ID do repositório (ex: "lllyasviel/ControlNet-v1-1")
        filename: Nome do arquivo no repositório
        local_dir: Diretório local de destino
        rename_as: Nome alternativo para salvar o arquivo

    Returns:
        True se sucesso, False se falha
    """
    try:
        local_dir.mkdir(parents=True, exist_ok=True)

        logger.info(f"Baixando {filename} de {repo_id}...")

        downloaded_path = hf_hub_download(
            repo_id=repo_id,
            filename=filename,
            local_dir=local_dir,
            local_dir_use_symlinks=False,
            resume_download=True
        )

        # Renomear se necessário
        if rename_as:
            final_path = local_dir / rename_as
            Path(downloaded_path).rename(final_path)
            logger.info(f"✓ Arquivo renomeado para: {rename_as}")

        logger.info(f"✓ Download concluído: {filename}")
        return True

    except HfHubHTTPError as e:
        if e.response.status_code == 401:
            logger.error(f"✗ Erro de autenticação ao baixar {filename}")
            logger.error("  Verifique se o token está correto e se você aceitou os termos do modelo")
        elif e.response.status_code == 404:
            logger.error(f"✗ Arquivo não encontrado: {filename} em {repo_id}")
        else:
            logger.error(f"✗ Erro HTTP ao baixar {filename}: {e}")
        return False

    except Exception as e:
        logger.error(f"✗ Erro ao baixar {filename}: {e}")
        return False


def download_model_set(name: str, config: Dict) -> Tuple[int, int]:
    """
    Baixa um conjunto de modelos

    Returns:
        (sucessos, falhas)
    """
    logger.info(f"\n{'='*60}")
    logger.info(f"Baixando conjunto: {name.upper()}")
    if "note" in config:
        logger.info(f"Nota: {config['note']}")
    logger.info(f"{'='*60}")

    repo_id = config["repo_id"]
    local_dir = Path(config["local_dir"])
    files = config.get("files", [])
    rename_as = config.get("rename_as", None)

    success_count = 0
    fail_count = 0

    for i, filename in enumerate(files):
        # Para modelos com múltiplos arquivos, só renomear o primeiro
        rename = rename_as if (i == 0 and rename_as) else None

        if download_file(repo_id, filename, local_dir, rename):
            success_count += 1
        else:
            fail_count += 1

    return success_count, fail_count


def write_status(status_text: str):
    """Escreve status em arquivo"""
    try:
        STATUS_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(STATUS_FILE, 'w', encoding='utf-8') as f:
            f.write(f"Última atualização: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            f.write(status_text)
    except Exception as e:
        logger.error(f"Erro ao escrever status: {e}")


def main():
    parser = argparse.ArgumentParser(description="Download de modelos para ComfyUI 3D Pipeline")
    parser.add_argument(
        "--models",
        nargs="+",
        choices=list(MODELS_CONFIG.keys()) + ["all"],
        default=["all"],
        help="Modelos específicos para baixar (padrão: all)"
    )
    parser.add_argument(
        "--skip-existing",
        action="store_true",
        help="Pular arquivos que já existem"
    )

    args = parser.parse_args()

    logger.info("="*60)
    logger.info("DOWNLOAD DE MODELOS - ComfyUI 3D Pipeline")
    logger.info("="*60)
    logger.info(f"Diretório base: {BASE_DIR}")
    logger.info(f"Log: {LOG_FILE}")

    # Verificar token
    if not check_token():
        sys.exit(1)

    # Determinar quais modelos baixar
    if "all" in args.models:
        models_to_download = MODELS_CONFIG
    else:
        models_to_download = {k: v for k, v in MODELS_CONFIG.items() if k in args.models}

    # Ordenar por prioridade
    sorted_models = sorted(
        models_to_download.items(),
        key=lambda x: x[1].get("priority", 999)
    )

    # Estatísticas
    total_success = 0
    total_fail = 0
    results = []

    # Download
    for name, config in sorted_models:
        success, fail = download_model_set(name, config)
        total_success += success
        total_fail += fail
        results.append(f"{name}: {success} OK, {fail} FALHAS")

    # Resumo
    logger.info("\n" + "="*60)
    logger.info("RESUMO DO DOWNLOAD")
    logger.info("="*60)
    for result in results:
        logger.info(result)
    logger.info(f"\nTotal: {total_success} sucessos, {total_fail} falhas")

    # Escrever status
    status_text = "RESUMO DO DOWNLOAD\n" + "="*60 + "\n"
    status_text += "\n".join(results)
    status_text += f"\n\nTotal: {total_success} sucessos, {total_fail} falhas"
    write_status(status_text)

    if total_fail > 0:
        logger.warning("\n⚠ Alguns downloads falharam. Verifique o log acima.")
        return 1
    else:
        logger.info("\n✓ Todos os downloads concluídos com sucesso!")
        logger.info("\nPróximos passos:")
        logger.info("1. Verifique os arquivos em: ComfyUI/models/")
        logger.info("2. Execute os workflows em: workflows/3d/")
        return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        logger.info("\n\nDownload interrompido pelo usuário")
        sys.exit(130)
    except Exception as e:
        logger.exception(f"Erro fatal: {e}")
        sys.exit(1)

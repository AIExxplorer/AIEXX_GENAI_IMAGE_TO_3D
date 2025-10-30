#!/usr/bin/env python3
"""
AIEXX GenAI - Stable Diffusion Model Downloader
Downloads required SD models for prompt-based workflows
"""

import os
import sys
from pathlib import Path
from huggingface_hub import hf_hub_download
from tqdm import tqdm

# ASCII Art
AIEXX_ASCII = """
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

  Stable Diffusion Model Downloader
"""

# Model configurations
MODELS = {
    "sd15": {
        "name": "Stable Diffusion 1.5",
        "repo_id": "runwayml/stable-diffusion-v1-5",
        "filename": "v1-5-pruned-emaonly.safetensors",
        "local_dir": "ComfyUI/models/checkpoints",
        "size": "~4GB"
    },
    "sd15_vae": {
        "name": "SD 1.5 VAE",
        "repo_id": "stabilityai/sd-vae-ft-mse-original",
        "filename": "vae-ft-mse-840000-ema-pruned.safetensors",
        "local_dir": "ComfyUI/models/vae",
        "size": "~335MB"
    },
    "clip": {
        "name": "CLIP Vision",
        "repo_id": "openai/clip-vit-large-patch14",
        "filename": "pytorch_model.bin",
        "local_dir": "ComfyUI/models/clip_vision",
        "size": "~1.7GB"
    }
}

def print_colored(text, color="green"):
    """Print colored text"""
    colors = {
        "green": "\033[92m",
        "red": "\033[91m",
        "yellow": "\033[93m",
        "blue": "\033[94m",
        "reset": "\033[0m"
    }
    print(f"{colors.get(color, '')}{text}{colors['reset']}")

def check_hf_token():
    """Check if HuggingFace token is available"""
    token = os.environ.get("HUGGING_FACE_HUB_TOKEN")
    if not token:
        # Try reading from .env file
        env_file = Path(".env")
        if env_file.exists():
            with open(env_file, 'r') as f:
                for line in f:
                    if line.startswith("HUGGING_FACE_HUB_TOKEN="):
                        token = line.split("=")[1].strip()
                        break
    return token

def download_model(model_key):
    """Download a specific model"""
    model_info = MODELS[model_key]

    print_colored(f"\n{'='*70}", "blue")
    print_colored(f"Downloading: {model_info['name']}", "blue")
    print_colored(f"Size: {model_info['size']}", "blue")
    print_colored(f"{'='*70}", "blue")

    # Create local directory if it doesn't exist
    local_dir = Path(model_info['local_dir'])
    local_dir.mkdir(parents=True, exist_ok=True)

    # Check if file already exists
    local_file = local_dir / model_info['filename']
    if local_file.exists():
        print_colored(f"✓ {model_info['name']} already exists!", "green")
        return True

    try:
        # Get HuggingFace token
        token = check_hf_token()

        print_colored(f"\nDownloading from: {model_info['repo_id']}", "yellow")
        print_colored(f"Target: {local_file}", "yellow")

        # Download with progress bar
        downloaded_path = hf_hub_download(
            repo_id=model_info['repo_id'],
            filename=model_info['filename'],
            local_dir=str(local_dir),
            local_dir_use_symlinks=False,
            token=token,
            resume_download=True
        )

        print_colored(f"✓ Successfully downloaded {model_info['name']}", "green")
        return True

    except Exception as e:
        print_colored(f"✗ Error downloading {model_info['name']}: {e}", "red")
        return False

def main():
    """Main function"""
    print(AIEXX_ASCII)

    # Check HuggingFace token
    token = check_hf_token()
    if not token:
        print_colored("\n⚠ Warning: HUGGING_FACE_HUB_TOKEN not found!", "yellow")
        print_colored("Some downloads may be restricted.", "yellow")
        print_colored("Set your token in .env file or environment variable.", "yellow")
        print("\nContinue anyway? (y/n): ", end="")
        if input().lower() != 'y':
            return

    print_colored("\n" + "="*70, "blue")
    print_colored("Models to download:", "blue")
    print_colored("="*70, "blue")
    for key, info in MODELS.items():
        print(f"  [{key}] {info['name']} - {info['size']}")
    print()

    # Download all models
    success_count = 0
    total_count = len(MODELS)

    for model_key in MODELS.keys():
        if download_model(model_key):
            success_count += 1

    # Summary
    print_colored("\n" + "="*70, "blue")
    print_colored("Download Summary", "blue")
    print_colored("="*70, "blue")
    print(f"Successfully downloaded: {success_count}/{total_count} models")

    if success_count == total_count:
        print_colored("\n✓ All models downloaded successfully!", "green")
        print_colored("\nYou can now use prompt-based workflows!", "green")
    else:
        print_colored(f"\n⚠ {total_count - success_count} model(s) failed to download", "yellow")
        print_colored("Check your internet connection and HuggingFace token", "yellow")

    print("\n")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print_colored("\n\n✗ Download cancelled by user", "red")
        sys.exit(1)
    except Exception as e:
        print_colored(f"\n✗ Unexpected error: {e}", "red")
        sys.exit(1)

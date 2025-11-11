#!/usr/bin/env python3
"""Simple SD model downloader without Unicode issues"""

import os
import sys
from pathlib import Path
from huggingface_hub import hf_hub_download

# Read token from .env
token = None
env_file = Path(".env")
if env_file.exists():
    with open(env_file, 'r') as f:
        for line in f:
            if line.startswith("HUGGING_FACE_HUB_TOKEN="):
                token = line.split("=")[1].strip()
                break

print("\n=== AIEXX - Downloading Stable Diffusion Models ===\n")

# Model 1: SD 1.5
print("[1/3] Downloading Stable Diffusion 1.5...")
local_dir = Path("ComfyUI/models/checkpoints")
local_dir.mkdir(parents=True, exist_ok=True)
local_file = local_dir / "v1-5-pruned-emaonly.safetensors"

if local_file.exists():
    print("  -> Already exists!")
else:
    try:
        hf_hub_download(
            repo_id="runwayml/stable-diffusion-v1-5",
            filename="v1-5-pruned-emaonly.safetensors",
            local_dir=str(local_dir),
            local_dir_use_symlinks=False,
            token=token,
            resume_download=True
        )
        print("  -> Downloaded successfully!")
    except Exception as e:
        print(f"  -> Error: {e}")

# Model 2: VAE
print("\n[2/3] Downloading SD 1.5 VAE...")
local_dir = Path("ComfyUI/models/vae")
local_dir.mkdir(parents=True, exist_ok=True)
local_file = local_dir / "vae-ft-mse-840000-ema-pruned.safetensors"

if local_file.exists():
    print("  -> Already exists!")
else:
    try:
        hf_hub_download(
            repo_id="stabilityai/sd-vae-ft-mse-original",
            filename="vae-ft-mse-840000-ema-pruned.safetensors",
            local_dir=str(local_dir),
            local_dir_use_symlinks=False,
            token=token,
            resume_download=True
        )
        print("  -> Downloaded successfully!")
    except Exception as e:
        print(f"  -> Error: {e}")

# Model 3: CLIP Vision
print("\n[3/3] Downloading CLIP Vision...")
local_dir = Path("ComfyUI/models/clip_vision")
local_dir.mkdir(parents=True, exist_ok=True)
local_file = local_dir / "pytorch_model.bin"

if local_file.exists():
    print("  -> Already exists!")
else:
    try:
        hf_hub_download(
            repo_id="openai/clip-vit-large-patch14",
            filename="pytorch_model.bin",
            local_dir=str(local_dir),
            local_dir_use_symlinks=False,
            token=token,
            resume_download=True
        )
        print("  -> Downloaded successfully!")
    except Exception as e:
        print(f"  -> Error: {e}")

print("\n=== Download Complete! ===\n")

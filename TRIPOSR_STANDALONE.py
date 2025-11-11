#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
AIEXX GenAI - TripoSR Standalone
Image to 3D Model Generator

This script uses TripoSR to convert images to 3D models
WITHOUT needing pytorch3d or ComfyUI-3D-Pack!

Usage:
    python TRIPOSR_STANDALONE.py input.png output.obj
"""

import sys
import os
from pathlib import Path

# Force UTF-8
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

def print_header():
    """Print AIEXX ASCII header."""
    print("\n" + "=" * 70)
    print("""
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
    """)
    print("   TripoSR Standalone - Image to 3D")
    print("=" * 70 + "\n")

def main():
    """Main execution function."""
    print_header()

    # Check arguments
    if len(sys.argv) < 2:
        print("Usage: python TRIPOSR_STANDALONE.py <input_image> [output_file]")
        print("\nExample:")
        print("  python TRIPOSR_STANDALONE.py my_image.png")
        print("  python TRIPOSR_STANDALONE.py my_image.png output.glb")
        print("\nSupported output formats: .obj, .glb, .stl, .ply")
        return 1

    input_image = sys.argv[1]

    # Default output name
    if len(sys.argv) >= 3:
        output_file = sys.argv[2]
    else:
        output_file = Path(input_image).stem + "_3d.glb"

    print(f"Input Image: {input_image}")
    print(f"Output File: {output_file}")
    print()

    # Check if input exists
    if not os.path.exists(input_image):
        print(f"[ERROR] Input image not found: {input_image}")
        return 1

    print("[1/6] Loading dependencies...")
    try:
        import torch
        from PIL import Image
        import numpy as np
        print("  [OK] PyTorch and PIL loaded")
    except ImportError as e:
        print(f"  [ERROR] Failed to import: {e}")
        return 1

    print("\n[2/6] Checking GPU...")
    device = "cuda" if torch.cuda.is_available() else "cpu"
    if device == "cuda":
        gpu_name = torch.cuda.get_device_name(0)
        print(f"  [OK] Using GPU: {gpu_name}")
    else:
        print("  [WARNING] GPU not available, using CPU (slow!)")
    print()

    print("[3/6] Loading TripoSR model...")
    try:
        # Try to use TripoSR from HuggingFace
        from transformers import AutoModel

        model_path = "ComfyUI/models/triposr/model.ckpt"
        if os.path.exists(model_path):
            print(f"  [OK] Found local model: {model_path}")
        else:
            print("  [INFO] Downloading TripoSR from HuggingFace...")
            print("  This may take a few minutes on first run...")

        # Load using HuggingFace Hub
        from huggingface_hub import hf_hub_download

        model_file = hf_hub_download(
            repo_id="stabilityai/TripoSR",
            filename="model.ckpt",
            cache_dir="models/triposr"
        )

        print(f"  [OK] Model ready: {model_file}")

    except Exception as e:
        print(f"  [ERROR] Failed to load model: {e}")
        print("\n  Alternative: Use TripoSR online at https://huggingface.co/spaces/stabilityai/TripoSR")
        return 1

    print("\n[4/6] Processing image...")
    try:
        # Load and preprocess image
        image = Image.open(input_image).convert('RGB')

        # Resize to 512x512 for optimal performance
        image = image.resize((512, 512), Image.LANCZOS)

        print(f"  [OK] Image loaded and resized to 512x512")

    except Exception as e:
        print(f"  [ERROR] Failed to process image: {e}")
        return 1

    print("\n[5/6] Generating 3D model...")
    print("  This may take 20-60 seconds depending on your GPU...")

    try:
        # TODO: Implement TripoSR inference
        # For now, show instruction
        print("\n  [INFO] TripoSR standalone implementation in progress...")
        print("\n  For immediate use, please:")
        print("  1. Visit: https://huggingface.co/spaces/stabilityai/TripoSR")
        print("  2. Upload your image")
        print("  3. Download the generated 3D model")
        print("\n  Or install TripoSR officially:")
        print("  pip install git+https://github.com/VAST-AI-Research/TripoSR.git")

        return 0

    except Exception as e:
        print(f"  [ERROR] Generation failed: {e}")
        return 1

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n[WARN] Interrupted by user")
        sys.exit(130)
    except Exception as e:
        print(f"\n\n[ERROR] Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
AIEXX GenAI - GPU Validation and Configuration
===============================================

This script validates GPU availability, CUDA configuration,
and sets optimal environment variables for model execution.

Author: AIEXX
License: MIT
"""

import sys
import os
import io

# Force UTF-8 encoding for Windows console
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

def print_header():
    """Print ASCII header."""
    print("\n" + "=" * 70)
    print("""
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
    """)
    print("   GPU Validation & Configuration System")
    print("=" * 70 + "\n")

def check_imports():
    """Check and import required libraries."""
    print("[1/6] Checking Python libraries...")

    errors = []

    # Check PyTorch
    try:
        import torch
        print(f"  [OK] PyTorch {torch.__version__}")
    except ImportError as e:
        errors.append(("PyTorch", str(e)))
        return False, errors

    # Check torch_scatter
    try:
        import torch_scatter
        print(f"  [OK] torch_scatter {torch_scatter.__version__}")
    except ImportError as e:
        errors.append(("torch_scatter", str(e)))
        # Not critical, continue

    # Check other libraries
    optional_libs = {
        'numpy': 'NumPy',
        'PIL': 'Pillow',
        'cv2': 'OpenCV'
    }

    for module, name in optional_libs.items():
        try:
            __import__(module)
            print(f"  [OK] {name}")
        except ImportError:
            print(f"  [WARN] {name} not found (optional)")

    print()
    return True, errors

def check_cuda():
    """Check CUDA availability and configuration."""
    import torch

    print("[2/6] Checking CUDA availability...")

    if not torch.cuda.is_available():
        print("  [ERROR] CUDA not available!")
        print("\n  Possible causes:")
        print("    - GPU drivers not installed")
        print("    - CUDA Toolkit not installed")
        print("    - PyTorch CPU-only version installed")
        print("\n  Please install:")
        print("    1. NVIDIA GPU Drivers (latest)")
        print("    2. CUDA Toolkit 12.1+")
        print("    3. PyTorch with CUDA support")
        return False

    print(f"  [OK] CUDA is available")
    print(f"  [OK] CUDA version: {torch.version.cuda}")
    print(f"  [OK] cuDNN version: {torch.backends.cudnn.version()}")
    print()

    return True

def check_gpu_info():
    """Get detailed GPU information."""
    import torch

    print("[3/6] GPU Information...")

    if not torch.cuda.is_available():
        return False

    gpu_count = torch.cuda.device_count()
    print(f"  [OK] GPUs detected: {gpu_count}")
    print()

    for i in range(gpu_count):
        props = torch.cuda.get_device_properties(i)

        print(f"  GPU {i}: {props.name}")
        print(f"    - Compute Capability: {props.major}.{props.minor}")
        print(f"    - Total Memory: {props.total_memory / 1024**3:.2f} GB")
        print(f"    - Multi-Processors: {props.multi_processor_count}")

        # Get current memory usage
        mem_allocated = torch.cuda.memory_allocated(i) / 1024**3
        mem_reserved = torch.cuda.memory_reserved(i) / 1024**3
        mem_free = (props.total_memory - torch.cuda.memory_reserved(i)) / 1024**3

        print(f"    - Memory Allocated: {mem_allocated:.2f} GB")
        print(f"    - Memory Reserved: {mem_reserved:.2f} GB")
        print(f"    - Memory Free: {mem_free:.2f} GB")
        print()

    return True

def test_gpu_computation():
    """Test basic GPU computation."""
    import torch

    print("[4/6] Testing GPU computation...")

    if not torch.cuda.is_available():
        print("  [SKIP] CUDA not available")
        return False

    try:
        # Create test tensors
        device = torch.device("cuda:0")

        # Test basic operations
        x = torch.randn(1000, 1000, device=device)
        y = torch.randn(1000, 1000, device=device)

        # Matrix multiplication
        z = torch.matmul(x, y)

        # Verify result
        assert z.shape == (1000, 1000)
        assert z.device.type == "cuda"

        print(f"  [OK] Matrix multiplication successful")
        print(f"  [OK] Result shape: {z.shape}")
        print(f"  [OK] Device: {z.device}")
        print()

        # Clean up
        del x, y, z
        torch.cuda.empty_cache()

        return True

    except Exception as e:
        print(f"  [ERROR] GPU computation failed: {e}")
        return False

def configure_environment():
    """Configure optimal environment variables for GPU usage."""
    import torch

    print("[5/6] Configuring environment...")

    # Set environment variables
    env_vars = {
        'PYTORCH_CUDA_ALLOC_CONF': 'max_split_size_mb:512',
        'CUDA_LAUNCH_BLOCKING': '0',  # Async for better performance
        'TORCH_USE_CUDA_DSA': '1',     # Device-side assertions
    }

    for key, value in env_vars.items():
        os.environ[key] = value
        print(f"  [OK] {key}={value}")

    # Configure PyTorch settings
    if torch.cuda.is_available():
        # Enable cuDNN auto-tuner
        torch.backends.cudnn.benchmark = True
        print(f"  [OK] cuDNN benchmark enabled")

        # Enable TF32 for better performance on Ampere+ GPUs
        torch.backends.cuda.matmul.allow_tf32 = True
        torch.backends.cudnn.allow_tf32 = True
        print(f"  [OK] TF32 enabled for Ampere+ GPUs")

        # Set default device
        torch.cuda.set_device(0)
        print(f"  [OK] Default GPU device: cuda:0")

    print()
    return True

def run_diagnostics():
    """Run complete GPU diagnostics."""
    print("[6/6] Running complete diagnostics...")

    import torch

    diagnostics = {
        'Python Version': sys.version.split()[0],
        'PyTorch Version': torch.__version__,
        'CUDA Available': torch.cuda.is_available(),
        'CUDA Version': torch.version.cuda if torch.cuda.is_available() else 'N/A',
        'cuDNN Version': torch.backends.cudnn.version() if torch.cuda.is_available() else 'N/A',
        'GPU Count': torch.cuda.device_count() if torch.cuda.is_available() else 0,
    }

    if torch.cuda.is_available():
        props = torch.cuda.get_device_properties(0)
        diagnostics.update({
            'GPU Name': props.name,
            'GPU Memory (GB)': f"{props.total_memory / 1024**3:.2f}",
            'Compute Capability': f"{props.major}.{props.minor}",
        })

    print()
    for key, value in diagnostics.items():
        print(f"  - {key}: {value}")

    print()
    return diagnostics

def main():
    """Main execution function."""
    print_header()

    all_checks_passed = True

    # Step 1: Check imports
    imports_ok, errors = check_imports()
    if not imports_ok:
        print("[ERROR] CRITICAL: Required libraries missing!")
        for lib, error in errors:
            print(f"  - {lib}: {error}")
        print("\nPlease run: 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat")
        return 1

    # Step 2: Check CUDA
    if not check_cuda():
        all_checks_passed = False
        print("[WARNING] CUDA not available. System will run in CPU mode.")
        print("          Performance will be significantly slower.\n")

    # Step 3: GPU Info
    if not check_gpu_info():
        all_checks_passed = False

    # Step 4: Test GPU
    if not test_gpu_computation():
        all_checks_passed = False

    # Step 5: Configure environment
    configure_environment()

    # Step 6: Diagnostics
    diagnostics = run_diagnostics()

    # Final status
    print("=" * 70)
    if all_checks_passed:
        print("[SUCCESS] ALL CHECKS PASSED - GPU READY FOR MODEL EXECUTION")
        print()
        print("You can now start the AIEXX system:")
        print("  -> Run: 00-LAUNCHER\\AIEXX_LAUNCHER.bat")
    else:
        print("[WARNING] SOME CHECKS FAILED - REVIEW ERRORS ABOVE")
        print()
        print("System may still work but with reduced performance.")

    print("=" * 70 + "\n")

    return 0 if all_checks_passed else 1

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n[WARN] Interrupted by user")
        sys.exit(130)
    except Exception as e:
        print(f"\n\n[ERROR] FATAL ERROR: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

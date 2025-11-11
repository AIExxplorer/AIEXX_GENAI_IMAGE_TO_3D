#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
================================================================================
  █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
 ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
 ███████║██║█████╗   ╚███╔╝  ╚███╔╝
 ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
 ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
 ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

  AIEXX GenAI - Image to 3D Model Generator
  TripoSR Local Implementation

================================================================================

Este script converte imagens em modelos 3D usando TripoSR localmente.

Uso:
    python AIEXX_IMAGE_TO_3D.py <imagem_entrada> [arquivo_saida]

Exemplos:
    python AIEXX_IMAGE_TO_3D.py minha_foto.png
    python AIEXX_IMAGE_TO_3D.py minha_foto.jpg modelo3d.obj
    python AIEXX_IMAGE_TO_3D.py input.png output.glb

Formatos suportados:
    - Entrada: PNG, JPG, JPEG, WEBP
    - Saída: OBJ, GLB, STL, PLY

================================================================================
"""

import sys
import os
from pathlib import Path
import time

# Force UTF-8 para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')


def print_header():
    """Exibe o cabeçalho AIEXX."""
    print("\n" + "=" * 80)
    print("""
   █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
  ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
  ███████║██║█████╗   ╚███╔╝  ╚███╔╝
  ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
  ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
  ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
    """)
    print("  AIEXX GenAI - Image to 3D Converter")
    print("  Powered by TripoSR - Stability AI")
    print("=" * 80 + "\n")


def print_usage():
    """Exibe instruções de uso."""
    print(__doc__)


def main():
    """Função principal."""
    print_header()

    # Verificar argumentos
    if len(sys.argv) < 2:
        print("[ERRO] Nenhuma imagem fornecida!\n")
        print_usage()
        return 1

    input_image = sys.argv[1]

    # Nome de saída padrão
    if len(sys.argv) >= 3:
        output_file = sys.argv[2]
    else:
        output_file = Path(input_image).stem + "_3D.obj"

    print(f"[INFO] Imagem de entrada: {input_image}")
    print(f"[INFO] Arquivo de saída: {output_file}")
    print()

    # Verificar se a imagem existe
    if not os.path.exists(input_image):
        print(f"[ERRO] Arquivo não encontrado: {input_image}")
        return 1

    # Criar pasta de saída se necessário
    output_dir = Path(output_file).parent
    if output_dir != Path('.'):
        os.makedirs(output_dir, exist_ok=True)

    print("[1/7] Carregando bibliotecas...")
    try:
        import torch
        from PIL import Image
        import numpy as np
        print("  [OK] PyTorch e PIL carregados")
    except ImportError as e:
        print(f"  [ERRO] Falha ao importar biblioteca: {e}")
        return 1

    print("\n[2/7] Verificando GPU...")
    device = "cuda" if torch.cuda.is_available() else "cpu"
    if device == "cuda":
        gpu_name = torch.cuda.get_device_name(0)
        gpu_memory = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"  [OK] GPU Detectada: {gpu_name}")
        print(f"  [OK] VRAM: {gpu_memory:.2f} GB")
    else:
        print("  [AVISO] GPU não disponível, usando CPU (muito mais lento!)")
    print()

    print("[3/7] Carregando modelo TripoSR...")
    print("  Este processo pode demorar na primeira vez...")

    start_time = time.time()

    try:
        # Tentar carregar o modelo do HuggingFace
        sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/..")

        from tsr.system import TSR

        # Verificar modelo local primeiro
        local_model_path = "ComfyUI/models/triposr"

        if os.path.exists(os.path.join(local_model_path, "model.ckpt")):
            print(f"  [OK] Usando modelo local: {local_model_path}")
            model = TSR.from_pretrained(
                local_model_path,
                config_name="config.yaml",
                weight_name="model.ckpt"
            )
        else:
            print("  [INFO] Baixando modelo do HuggingFace...")
            print("  Isso pode levar alguns minutos na primeira vez...")
            model = TSR.from_pretrained(
                "stabilityai/TripoSR",
                config_name="config.yaml",
                weight_name="model.ckpt"
            )

        model.to(device)

        load_time = time.time() - start_time
        print(f"  [OK] Modelo carregado em {load_time:.2f} segundos")

    except Exception as e:
        print(f"  [ERRO] Falha ao carregar modelo: {e}")
        print("\n  SOLUÇÃO:")
        print("  Execute: .venv311\\Scripts\\pip.exe install git+https://github.com/VAST-AI-Research/TripoSR.git")
        print("  OU use o TripoSR online: https://huggingface.co/spaces/stabilityai/TripoSR")
        return 1

    print("\n[4/7] Processando imagem...")
    try:
        # Carregar imagem
        image = Image.open(input_image).convert('RGB')
        original_size = image.size
        print(f"  [OK] Imagem carregada: {original_size[0]}x{original_size[1]}")

        # Remover fundo (opcional)
        try:
            import rembg
            print("  [INFO] Removendo fundo da imagem...")
            image_array = np.array(image)
            result = rembg.remove(image_array)
            result_img = Image.fromarray(result)

            # Converter RGBA para RGB com fundo cinza
            if result_img.mode == 'RGBA':
                # Criar fundo cinza
                background = Image.new('RGB', result_img.size, (128, 128, 128))
                # Compor com canal alpha
                background.paste(result_img, mask=result_img.split()[3])
                image = background
            else:
                image = result_img.convert('RGB')

            print("  [OK] Fundo removido")
        except Exception as e:
            print(f"  [INFO] Usando imagem original: {e}")
            image = image.convert('RGB')

        # Redimensionar para 512x512 para performance ideal
        image = image.resize((512, 512), Image.LANCZOS)
        print("  [OK] Imagem redimensionada para 512x512")

    except Exception as e:
        print(f"  [ERRO] Falha ao processar imagem: {e}")
        return 1

    print("\n[5/7] Gerando modelo 3D...")
    print("  Este processo pode levar 20-60 segundos dependendo da sua GPU...")

    gen_start = time.time()

    try:
        with torch.no_grad():
            scene_codes = model([image], device=device)

        gen_time = time.time() - gen_start
        print(f"  [OK] Modelo 3D gerado em {gen_time:.2f} segundos")

    except Exception as e:
        print(f"  [ERRO] Falha na geração: {e}")
        return 1

    print("\n[6/7] Extraindo malha 3D...")
    try:
        mesh_start = time.time()

        # Limpar cache da GPU
        if device == "cuda":
            torch.cuda.empty_cache()

        # Extrair malha com marching cubes
        # Usar resolução 128 ao invés de 256 para economizar VRAM
        # has_vertex_color=True significa que vamos gerar cores nos vértices
        meshes = model.extract_mesh(scene_codes, has_vertex_color=True, resolution=128)
        mesh = meshes[0]

        mesh_time = time.time() - mesh_start
        print(f"  [OK] Malha extraída em {mesh_time:.2f} segundos")
        print(f"  [INFO] Vértices: {len(mesh.vertices)}")
        print(f"  [INFO] Faces: {len(mesh.faces)}")

    except Exception as e:
        print(f"  [ERRO] Falha ao extrair malha: {e}")
        return 1

    print("\n[7/7] Salvando modelo 3D...")
    try:
        mesh.export(output_file)

        file_size = os.path.getsize(output_file) / 1024  # KB
        print(f"  [OK] Modelo salvo: {output_file}")
        print(f"  [INFO] Tamanho: {file_size:.2f} KB")

    except Exception as e:
        print(f"  [ERRO] Falha ao salvar modelo: {e}")
        return 1

    total_time = time.time() - start_time

    print("\n" + "=" * 80)
    print("  SUCESSO!")
    print("=" * 80)
    print(f"\n  Modelo 3D criado com sucesso!")
    print(f"  Arquivo: {output_file}")
    print(f"  Tempo total: {total_time:.2f} segundos")
    print(f"\n  Você pode visualizar este modelo em:")
    print(f"  - https://3dviewer.net")
    print(f"  - Blender")
    print(f"  - MeshLab")
    print(f"  - Qualquer software 3D")
    print("\n" + "=" * 80)
    print()

    return 0


if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n[AVISO] Interrompido pelo usuário")
        sys.exit(130)
    except Exception as e:
        print(f"\n\n[ERRO] Erro fatal: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

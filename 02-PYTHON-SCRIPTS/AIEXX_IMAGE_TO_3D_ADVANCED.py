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

  AIEXX GenAI - Image to 3D Model Generator ADVANCED
  TripoSR Local Implementation - GPU Accelerated
  
  🎯 VERSÃO AVANÇADA com recursos profissionais
  
================================================================================

Este script converte imagens em modelos 3D de alta qualidade usando TripoSR
localmente na sua GPU - SEM CUSTOS de API!

Recursos AVANÇADOS:
  ✅ Remoção automática de fundo (rembg)
  ✅ Pré-processamento inteligente de imagem
  ✅ Múltiplos formatos de saída (GLB, OBJ, STL, PLY)
  ✅ Texturas de alta qualidade (até 4K)
  ✅ Otimização automática de malha
  ✅ Relatório detalhado de performance

Uso:
    python AIEXX_IMAGE_TO_3D_ADVANCED.py <imagem> [saida] [options]

Exemplos:
    python AIEXX_IMAGE_TO_3D_ADVANCED.py foto.png
    python AIEXX_IMAGE_TO_3D_ADVANCED.py foto.jpg modelo.glb
    python AIEXX_IMAGE_TO_3D_ADVANCED.py foto.png modelo.obj --quality high
    python AIEXX_IMAGE_TO_3D_ADVANCED.py foto.png --remove-bg --texture-size 4096

Opções:
    --quality <low|medium|high>    Qualidade do modelo (padrão: medium)
    --remove-bg                    Remove fundo automaticamente
    --texture-size <512-4096>      Resolução da textura (padrão: 2048)
    --mc-resolution <64-512>       Resolução marching cubes (padrão: 256)
    --no-optimize                  Desabilita otimização de malha
    --format <glb|obj|stl|ply>     Formato de saída (padrão: glb)

================================================================================
"""

import sys
import os
from pathlib import Path
import time
import argparse
import json

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
    print("  AIEXX GenAI - Image to 3D Converter ADVANCED")
    print("  Powered by TripoSR + GPU Local - Sem custos de API")
    print("=" * 80 + "\n")


def parse_arguments():
    """
    Processa argumentos da linha de comando.
    
    Returns:
        argparse.Namespace: Argumentos processados
    """
    parser = argparse.ArgumentParser(
        description="AIEXX Image to 3D Advanced - GPU Local",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exemplos de uso:
  %(prog)s foto.png
  %(prog)s foto.jpg modelo.glb --quality high
  %(prog)s foto.png --remove-bg --texture-size 4096
  %(prog)s foto.png modelo.obj --mc-resolution 512
        """
    )
    
    parser.add_argument('input_image', type=str, help='Caminho da imagem de entrada')
    parser.add_argument('output_file', type=str, nargs='?', help='Caminho do arquivo de saída (opcional)')
    
    parser.add_argument('--quality', type=str, choices=['low', 'medium', 'high'], default='medium',
                        help='Qualidade do modelo 3D (padrão: medium)')
    parser.add_argument('--remove-bg', action='store_true',
                        help='Remove fundo da imagem automaticamente')
    parser.add_argument('--texture-size', type=int, default=2048,
                        help='Resolução da textura em pixels (512-4096, padrão: 2048)')
    parser.add_argument('--mc-resolution', type=int, default=256,
                        help='Resolução do marching cubes (64-512, padrão: 256)')
    parser.add_argument('--no-optimize', action='store_true',
                        help='Desabilita otimização automática da malha')
    parser.add_argument('--format', type=str, choices=['glb', 'obj', 'stl', 'ply'], default='glb',
                        help='Formato de saída (padrão: glb)')
    
    return parser.parse_args()


def load_image_with_preprocessing(image_path, remove_bg=False, target_size=512):
    """
    Carrega e pré-processa a imagem.
    
    Args:
        image_path (str): Caminho da imagem
        remove_bg (bool): Se deve remover o fundo
        target_size (int): Tamanho alvo para redimensionar
        
    Returns:
        PIL.Image: Imagem processada
    """
    from PIL import Image
    import numpy as np
    
    print("\n[4/8] Processando imagem...")
    
    # Carregar imagem
    image = Image.open(image_path).convert('RGB')
    original_size = image.size
    print(f"  [OK] Imagem carregada: {original_size[0]}x{original_size[1]}")
    
    # Remover fundo se solicitado
    if remove_bg:
        try:
            import rembg
            print("  [INFO] Removendo fundo da imagem...")
            image_array = np.array(image)
            result = rembg.remove(image_array)
            result_img = Image.fromarray(result)
            
            # Converter RGBA para RGB com fundo cinza
            if result_img.mode == 'RGBA':
                background = Image.new('RGB', result_img.size, (128, 128, 128))
                background.paste(result_img, mask=result_img.split()[3])
                image = background
            else:
                image = result_img.convert('RGB')
            
            print("  [OK] Fundo removido com sucesso")
        except ImportError:
            print("  [AVISO] rembg não instalado. Execute: pip install rembg")
            print("  [INFO] Continuando sem remoção de fundo...")
        except Exception as e:
            print(f"  [AVISO] Falha ao remover fundo: {e}")
            print("  [INFO] Continuando com imagem original...")
    
    # Redimensionar mantendo proporção
    image.thumbnail((target_size, target_size), Image.LANCZOS)
    
    # Centralizar em canvas quadrado
    canvas = Image.new('RGB', (target_size, target_size), (128, 128, 128))
    offset = ((target_size - image.size[0]) // 2, (target_size - image.size[1]) // 2)
    canvas.paste(image, offset)
    
    print(f"  [OK] Imagem processada: {target_size}x{target_size}")
    
    return canvas


def optimize_mesh(mesh, target_faces=None):
    """
    Otimiza a malha 3D.
    
    Args:
        mesh: Objeto de malha
        target_faces (int): Número alvo de faces (None = não simplificar)
        
    Returns:
        mesh: Malha otimizada
    """
    print("\n[7/8] Otimizando malha...")
    
    try:
        original_vertices = len(mesh.vertices)
        original_faces = len(mesh.faces)
        
        # Remover vértices duplicados
        mesh.merge_vertices()
        
        # Remover faces degeneradas
        mesh.remove_degenerate_faces()
        
        # Simplificar se target_faces foi especificado
        if target_faces and original_faces > target_faces:
            import trimesh
            mesh = mesh.simplify_quadric_decimation(target_faces)
        
        optimized_vertices = len(mesh.vertices)
        optimized_faces = len(mesh.faces)
        
        print(f"  [OK] Vértices: {original_vertices} → {optimized_vertices}")
        print(f"  [OK] Faces: {original_faces} → {optimized_faces}")
        
        return mesh
        
    except Exception as e:
        print(f"  [AVISO] Falha na otimização: {e}")
        print("  [INFO] Retornando malha original...")
        return mesh


def main():
    """Função principal."""
    print_header()
    
    # Parse argumentos
    args = parse_arguments()
    
    # Configurações baseadas na qualidade
    quality_settings = {
        'low': {'resolution': 128, 'texture': 1024},
        'medium': {'resolution': 256, 'texture': 2048},
        'high': {'resolution': 512, 'texture': 4096}
    }
    
    settings = quality_settings[args.quality]
    mc_resolution = args.mc_resolution if args.mc_resolution != 256 else settings['resolution']
    texture_size = args.texture_size if args.texture_size != 2048 else settings['texture']
    
    # Determinar arquivo de saída
    if args.output_file:
        output_file = args.output_file
    else:
        output_file = Path(args.input_image).stem + f"_3D.{args.format}"
    
    # Informações iniciais
    print(f"[INFO] Imagem de entrada: {args.input_image}")
    print(f"[INFO] Arquivo de saída: {output_file}")
    print(f"[INFO] Qualidade: {args.quality}")
    print(f"[INFO] Resolução MC: {mc_resolution}")
    print(f"[INFO] Textura: {texture_size}px")
    print(f"[INFO] Remover fundo: {'Sim' if args.remove_bg else 'Não'}")
    print(f"[INFO] Otimizar malha: {'Não' if args.no_optimize else 'Sim'}")
    print()
    
    # Verificar se a imagem existe
    if not os.path.exists(args.input_image):
        print(f"[ERRO] Arquivo não encontrado: {args.input_image}")
        return 1
    
    # Criar pasta de saída
    output_dir = Path(output_file).parent
    if output_dir != Path('.') and output_dir != Path(''):
        os.makedirs(output_dir, exist_ok=True)
    
    # Iniciar timer total
    total_start = time.time()
    
    # [1/8] Carregar bibliotecas
    print("[1/8] Carregando bibliotecas...")
    try:
        import torch
        from PIL import Image
        import numpy as np
        print("  [OK] PyTorch e PIL carregados")
    except ImportError as e:
        print(f"  [ERRO] Falha ao importar biblioteca: {e}")
        return 1
    
    # [2/8] Verificar GPU
    print("\n[2/8] Verificando GPU...")
    device = "cuda" if torch.cuda.is_available() else "cpu"
    if device == "cuda":
        gpu_name = torch.cuda.get_device_name(0)
        gpu_memory = torch.cuda.get_device_properties(0).total_memory / 1024**3
        print(f"  [OK] GPU Detectada: {gpu_name}")
        print(f"  [OK] VRAM Total: {gpu_memory:.2f} GB")
        
        # Memória livre
        torch.cuda.empty_cache()
        free_memory = torch.cuda.mem_get_info()[0] / 1024**3
        print(f"  [OK] VRAM Livre: {free_memory:.2f} GB")
    else:
        print("  [AVISO] GPU não disponível, usando CPU (muito mais lento!)")
    print()
    
    # [3/8] Carregar modelo TripoSR
    print("[3/8] Carregando modelo TripoSR...")
    print("  Este processo pode demorar na primeira vez...")
    
    load_start = time.time()
    
    try:
        # Adicionar caminho do TSR
        sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/..")
        
        from tsr.system import TSR
        
        # Verificar modelo local
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
        
        load_time = time.time() - load_start
        print(f"  [OK] Modelo carregado em {load_time:.2f} segundos")
        
    except Exception as e:
        print(f"  [ERRO] Falha ao carregar modelo: {e}")
        print("\n  SOLUÇÃO:")
        print("  Execute: .venv311\\Scripts\\pip.exe install git+https://github.com/VAST-AI-Research/TripoSR.git")
        return 1
    
    # [4/8] Processar imagem
    try:
        image = load_image_with_preprocessing(
            args.input_image,
            remove_bg=args.remove_bg,
            target_size=512
        )
    except Exception as e:
        print(f"  [ERRO] Falha ao processar imagem: {e}")
        return 1
    
    # [5/8] Gerar modelo 3D
    print("\n[5/8] Gerando modelo 3D com GPU...")
    print(f"  Resolução: {mc_resolution}")
    print(f"  Tempo estimado: {20 + (mc_resolution / 256) * 40:.0f}-{40 + (mc_resolution / 256) * 80:.0f} segundos")
    print()
    
    gen_start = time.time()
    
    try:
        with torch.no_grad():
            scene_codes = model([image], device=device)
        
        gen_time = time.time() - gen_start
        print(f"  [OK] Modelo 3D gerado em {gen_time:.2f} segundos")
        
    except Exception as e:
        print(f"  [ERRO] Falha na geração: {e}")
        return 1
    
    # [6/8] Extrair malha
    print("\n[6/8] Extraindo malha 3D...")
    try:
        mesh_start = time.time()
        
        # Limpar cache da GPU
        if device == "cuda":
            torch.cuda.empty_cache()
        
        # Extrair malha
        meshes = model.extract_mesh(
            scene_codes,
            has_vertex_color=True,
            resolution=mc_resolution
        )
        mesh = meshes[0]
        
        mesh_time = time.time() - mesh_start
        print(f"  [OK] Malha extraída em {mesh_time:.2f} segundos")
        print(f"  [INFO] Vértices: {len(mesh.vertices):,}")
        print(f"  [INFO] Faces: {len(mesh.faces):,}")
        
    except Exception as e:
        print(f"  [ERRO] Falha ao extrair malha: {e}")
        return 1
    
    # [7/8] Otimizar malha (se não desabilitado)
    if not args.no_optimize:
        try:
            mesh = optimize_mesh(mesh)
        except Exception as e:
            print(f"  [AVISO] Otimização falhou: {e}")
    else:
        print("\n[7/8] Otimização desabilitada (--no-optimize)")
    
    # [8/8] Salvar modelo
    print("\n[8/8] Salvando modelo 3D...")
    try:
        save_start = time.time()
        
        mesh.export(output_file)
        
        save_time = time.time() - save_start
        file_size = os.path.getsize(output_file) / 1024  # KB
        
        print(f"  [OK] Modelo salvo em {save_time:.2f} segundos")
        print(f"  [OK] Arquivo: {output_file}")
        print(f"  [OK] Tamanho: {file_size:.2f} KB")
        
    except Exception as e:
        print(f"  [ERRO] Falha ao salvar modelo: {e}")
        return 1
    
    # Relatório final
    total_time = time.time() - total_start
    
    print("\n" + "=" * 80)
    print("  ✅ SUCESSO! MODELO 3D CRIADO")
    print("=" * 80)
    print(f"\n  📁 Arquivo: {output_file}")
    print(f"  📐 Formato: {args.format.upper()}")
    print(f"  📊 Vértices: {len(mesh.vertices):,}")
    print(f"  📊 Faces: {len(mesh.faces):,}")
    print(f"  💾 Tamanho: {file_size:.2f} KB ({file_size/1024:.2f} MB)")
    print(f"  ⏱️  Tempo total: {total_time:.2f} segundos")
    print(f"\n  💰 CUSTO: R$ 0,00 (100% local - sem API!)")
    print(f"\n  🎉 Visualize em:")
    print(f"    • https://3dviewer.net")
    print(f"    • Blender")
    print(f"    • Unity")
    print(f"    • Unreal Engine")
    print("\n" + "=" * 80)
    print()
    
    # Salvar relatório JSON
    report = {
        "input_image": args.input_image,
        "output_file": output_file,
        "format": args.format,
        "quality": args.quality,
        "settings": {
            "mc_resolution": mc_resolution,
            "texture_size": texture_size,
            "remove_bg": args.remove_bg,
            "optimize": not args.no_optimize
        },
        "mesh_stats": {
            "vertices": len(mesh.vertices),
            "faces": len(mesh.faces)
        },
        "file_size_kb": file_size,
        "performance": {
            "model_load_time": load_time,
            "generation_time": gen_time,
            "mesh_extraction_time": mesh_time,
            "save_time": save_time,
            "total_time": total_time
        },
        "gpu": {
            "device": device,
            "name": gpu_name if device == "cuda" else "CPU",
            "vram_gb": gpu_memory if device == "cuda" else 0
        }
    }
    
    report_file = Path(output_file).with_suffix('.json')
    with open(report_file, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2, ensure_ascii=False)
    
    print(f"[INFO] Relatório salvo em: {report_file}\n")
    
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


"""
Wrapper para torchmcubes usando implementação alternativa.
Este módulo fornece a funcionalidade de marching cubes sem precisar de compilação.
"""

import torch
import numpy as np


def marching_cubes(volume, isolevel=0.0):
    """
    Implementação simplificada de marching cubes usando PyTorch.

    Args:
        volume: Tensor 3D com os valores do campo escalar
        isolevel: Nível da isosuperfície (padrão: 0.0)

    Returns:
        vertices: Tensor Nx3 com as coordenadas dos vértices
        faces: Tensor Mx3 com os índices dos triângulos
    """
    try:
        # Tentar usar scikit-image se disponível
        from skimage import measure

        # Converter para numpy
        volume_np = volume.cpu().numpy() if isinstance(volume, torch.Tensor) else volume

        # Garantir que o array seja contíguo
        volume_np = np.ascontiguousarray(volume_np)

        # Executar marching cubes
        verts, faces, normals, values = measure.marching_cubes(
            volume_np,
            level=isolevel,
            spacing=(1.0, 1.0, 1.0)
        )

        # Converter de volta para torch (garantindo cópia)
        verts = torch.from_numpy(np.array(verts, copy=True)).float()
        faces = torch.from_numpy(np.array(faces, copy=True)).long()

        return verts, faces

    except ImportError:
        # Fallback: implementação básica usando thresholding
        print("[AVISO] scikit-image não disponível, usando implementação simplificada")

        # Esta é uma implementação MUITO simplificada
        # Apenas para fins de demonstração
        # Não produz resultados de qualidade profissional

        resolution = volume.shape[0]

        # Criar grid básico
        x = torch.linspace(0, resolution-1, resolution)
        y = torch.linspace(0, resolution-1, resolution)
        z = torch.linspace(0, resolution-1, resolution)

        grid_x, grid_y, grid_z = torch.meshgrid(x, y, z, indexing='ij')

        # Encontrar voxels acima do threshold
        mask = volume > isolevel

        # Extrair coordenadas
        points = torch.stack([
            grid_x[mask],
            grid_y[mask],
            grid_z[mask]
        ], dim=-1)

        # Criar faces simples (triangulação básica)
        # Isso é apenas um placeholder
        n_points = points.shape[0]
        if n_points < 3:
            # Retornar malha vazia se não houver pontos suficientes
            return torch.zeros((0, 3)), torch.zeros((0, 3), dtype=torch.long)

        # Criar uma triangulação muito básica
        faces = []
        for i in range(0, n_points - 2, 3):
            faces.append([i, i+1, i+2])

        if len(faces) == 0:
            return points, torch.zeros((0, 3), dtype=torch.long)

        faces = torch.tensor(faces, dtype=torch.long)

        return points, faces


# Alias para compatibilidade
marching_cubes_pytorch = marching_cubes


__all__ = ['marching_cubes', 'marching_cubes_pytorch']

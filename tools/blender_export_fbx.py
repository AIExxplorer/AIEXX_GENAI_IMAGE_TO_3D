import sys
import os

# Blender will provide args before and after '--'. We only parse after '--'.
def parse_cli_args() -> tuple[str, str]:
    if "--" not in sys.argv:
        raise ValueError("Missing '--' separator. Usage: blender -b -P blender_export_fbx.py -- <infile> <outfile>")
    idx = sys.argv.index("--")
    args = sys.argv[idx + 1 :]
    if len(args) != 2:
        raise ValueError("Expected exactly two arguments: <infile> <outfile>")
    return args[0], args[1]


def ensure_clean_scene() -> None:
    import bpy

    bpy.ops.wm.read_factory_settings(use_empty=True)


def set_scene_units() -> None:
    import bpy

    scene = bpy.context.scene
    scene.unit_settings.system = 'METRIC'
    scene.unit_settings.scale_length = 0.01  # centimeters by default for export consistency


def import_geometry(input_path: str) -> None:
    import bpy

    lower = input_path.lower()
    if lower.endswith(".obj"):
        bpy.ops.import_scene.obj(filepath=input_path, use_split_objects=False)
    elif lower.endswith(".stl"):
        bpy.ops.import_mesh.stl(filepath=input_path)
    elif lower.endswith(".glb") or lower.endswith(".gltf"):
        bpy.ops.import_scene.gltf(filepath=input_path)
    else:
        raise ValueError(f"Unsupported input format: {os.path.splitext(input_path)[1]}")


def apply_mesh_cleanup() -> None:
    import bpy

    for obj in list(bpy.data.objects):
        if obj.type == 'MESH':
            bpy.context.view_layer.objects.active = obj
            obj.select_set(True)
            # Recalculate normals and remove doubles
            bpy.ops.mesh.customdata_custom_splitnormals_clear()
            bpy.ops.object.mode_set(mode='EDIT')
            bpy.ops.mesh.select_all(action='SELECT')
            bpy.ops.mesh.normals_make_consistent(inside=False)
            bpy.ops.mesh.remove_doubles(threshold=0.0001)
            bpy.ops.object.mode_set(mode='OBJECT')
            obj.select_set(False)


def export_fbx(output_path: str) -> None:
    import bpy

    # FBX 2018/2019 compatible settings, no embedded textures, smoothing/tangents ON
    bpy.ops.export_scene.fbx(
        filepath=output_path,
        use_selection=False,
        apply_unit_scale=True,
        bake_space_transform=False,
        object_types={'MESH'},
        use_mesh_modifiers=True,
        mesh_smooth_type='FACE',
        use_custom_props=False,
        add_leaf_bones=False,
        primary_bone_axis='Y',
        secondary_bone_axis='X',
        use_tspace=True,
        path_mode='AUTO',
        embed_textures=False,
        axis_forward='-Z',
        axis_up='Y'
    )


def main() -> None:
    in_path, out_path = parse_cli_args()

    # Lazy import of bpy only after parsing
    ensure_clean_scene()
    set_scene_units()
    import_geometry(in_path)
    apply_mesh_cleanup()
    export_fbx(out_path)


if __name__ == "__main__":
    main()



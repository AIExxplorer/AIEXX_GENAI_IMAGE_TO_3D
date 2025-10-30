import os, shutil
from huggingface_hub import hf_hub_download

token = os.environ.get('HUGGING_FACE_HUB_TOKEN')
base = r'C:\\ComfyUI\\ComfyUI\\models\\controlnet'
models = [
    ('lllyasviel/ControlNet-v1-1', 'control_v11p_sd15_canny.safetensors'),
    ('lllyasviel/ControlNet-v1-1', 'control_v11f1p_sd15_depth.safetensors'),
    ('lllyasviel/ControlNet-v1-1', 'control_v11p_sd15_openpose.safetensors'),
    ('lllyasviel/ControlNet-v1-1', 'control_v11f1e_sd15_tile.safetensors'),
]
os.makedirs(base, exist_ok=True)
for repo, fname in models:
    try:
        path = hf_hub_download(repo_id=repo, filename=fname, token=token)
        dst = os.path.join(base, fname)
        if not os.path.exists(dst):
            shutil.copy2(path, dst)
        print('OK', repo, fname)
    except Exception as e:
        print('FAIL', repo, fname, e)

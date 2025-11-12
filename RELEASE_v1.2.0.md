# Release v1.2.0 - Apache 2.0 License and Hugging Face Integration

## 🎉 What's New

### 🔓 Open Source License Update
- **Changed license from MIT to Apache License 2.0**
- Enhanced legal protection for contributors
- Industry-standard permissive license
- Patent grant protection included

### 🤗 Hugging Face Model Repository
- **Model now available on Hugging Face!**
- Direct download via `huggingface_hub`
- 1.6GB TripoSR model weights (via Git LFS)
- Complete configuration files
- Example outputs and workflows
- **Repository:** https://huggingface.co/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D

### 📁 Project Reorganization
- New modular directory structure:
  - `00-LAUNCHER/` - Unified launcher system
  - `01-SETUP-SCRIPTS/` - Installation scripts
  - `02-PYTHON-SCRIPTS/` - Python utilities
  - `03-DOCUMENTATION/` - Comprehensive docs
  - `04-WORKFLOWS/` - ComfyUI workflows
  - `05-RELEASE/` - Release management
  - `LEGACY/` - Archived files

### 🚀 Standalone Image-to-3D System
- **NEW:** `AIEXX_IMAGE_TO_3D.bat` - Drag-and-drop launcher
- **NEW:** `TRIPOSR_STANDALONE.py` - No pytorch3d required
- **NEW:** `tsr/` module - Custom rendering & isosurface
- GPU-accelerated (RTX 5060 optimized)
- Multiple export formats: OBJ, GLB, STL, PLY
- 30-70 seconds processing time

### 🛠️ Enhanced Tools & Scripts
- Unified launcher with diagnostics
- Automated testing suite (`RUN_ALL_TESTS.bat`)
- Checkpoint system for installation
- Inno Setup installer script
- PowerShell automation scripts

### 📚 Documentation Improvements
- **NEW:** `COMO_USAR_IMAGE_TO_3D.md` - Complete usage guide
- **NEW:** `BUILD_INSTALLER_GUIDE.md` - Installer instructions
- **NEW:** `QUICK_START_LOCAL_GPU.md` - GPU setup guide
- **NEW:** `PROJECT_ORGANIZATION.md` - Project structure
- Updated README with Hugging Face badge and links

## 📦 Download Model from Hugging Face

### Python
```python
from huggingface_hub import hf_hub_download

# Download model weights
model_path = hf_hub_download(
    repo_id="AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D",
    filename="model/model.ckpt"
)
```

### Git Clone
```bash
git clone https://huggingface.co/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
cd AIEXX_GENAI_IMAGE_TO_3D
git lfs pull
```

## 🔧 Technical Changes

### Dependencies
- PyTorch 2.7.0+cu128
- CUDA 12.8
- Python 3.11.9
- Git LFS for large files

### Architecture
- Modular component design
- Separated concerns (launcher, scripts, docs)
- Improved maintainability
- Better testing structure

### Security
- Apache 2.0 license protection
- Token-based Hugging Face auth
- Secure `.gitignore` configuration
- No credentials in repository

## 🐛 Bug Fixes
- Fixed file encoding issues (UTF-8 with BOM)
- Normalized line endings (LF → CRLF)
- Resolved Git LFS configuration
- Fixed launcher PATH issues

## 📊 Statistics
- **100+ files** reorganized
- **83,261 insertions** in refactor
- **4.1 GB** uploaded to Hugging Face
- **30 workflows** and examples included

## 🔗 Important Links

- **GitHub:** https://github.com/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
- **Hugging Face:** https://huggingface.co/AIExxplorer/AIEXX_GENAI_IMAGE_TO_3D
- **License:** https://opensource.org/licenses/Apache-2.0
- **Documentation:** See `03-DOCUMENTATION/` directory

## 💬 Breaking Changes

### License Change
- Projects using this code should update to Apache 2.0
- Review license compatibility with your project

### Directory Structure
- Scripts moved to organized directories
- Update any hardcoded paths in your scripts
- Check `PROJECT_ORGANIZATION.md` for new structure

## 🙏 Acknowledgments

Special thanks to:
- Stability AI (Stable Diffusion)
- VAST AI Research (TripoSR)
- Hugging Face (model hosting)
- ComfyUI community
- NVIDIA (CUDA toolkit)

## 📝 Full Changelog

See [CHANGELOG.md](05-RELEASE/CHANGELOG.md) for complete details.

---

**Built with ❤️ by AIEXX | Optimized for NVIDIA RTX 5060**

🤖 Generated with [Claude Code](https://claude.com/claude-code)

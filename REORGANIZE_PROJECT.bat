@echo off
REM ============================================
REM AIEXX - Project Reorganization Script
REM Organizes files into proper structure
REM ============================================

title AIEXX Project Reorganization
color 0E

cd /d "%~dp0"

echo.
echo ========================================================================
echo   AIEXX - Project Reorganization Script
echo ========================================================================
echo.
echo   This script will organize all project files into a clean structure:
echo.
echo   - Move active files to organized folders
echo   - Move deprecated files to LEGACY folder
echo   - Create proper directory structure
echo.
echo   WARNING: This will move files! Make sure you have a backup.
echo.
echo ========================================================================
echo.

choice /C YN /M "Do you want to proceed with reorganization"
if errorlevel 2 exit /b 0

echo.
echo [INFO] Starting reorganization...
echo.

REM ============================================
REM CREATE DIRECTORY STRUCTURE
REM ============================================

echo [1/9] Creating directory structure...

if not exist "00-LAUNCHER" mkdir "00-LAUNCHER"
if not exist "01-SETUP-SCRIPTS" mkdir "01-SETUP-SCRIPTS"
if not exist "02-PYTHON-SCRIPTS" mkdir "02-PYTHON-SCRIPTS"
if not exist "03-DOCUMENTATION" mkdir "03-DOCUMENTATION"
if not exist "04-WORKFLOWS" mkdir "04-WORKFLOWS"
if not exist "05-RELEASE" mkdir "05-RELEASE"
if not exist "LEGACY" mkdir "LEGACY"

echo [OK] Directories created
echo.

REM ============================================
REM MOVE LAUNCHER FILES
REM ============================================

echo [2/9] Moving launcher files...

if exist "AIEXX_LAUNCHER.bat" move "AIEXX_LAUNCHER.bat" "00-LAUNCHER\" >nul
if exist "DIAGNOSTIC_TEST.bat" move "DIAGNOSTIC_TEST.bat" "00-LAUNCHER\" >nul
if exist "START_HERE.md" move "START_HERE.md" "00-LAUNCHER\" >nul

echo [OK] Launcher files moved
echo.

REM ============================================
REM MOVE SETUP SCRIPTS
REM ============================================

echo [3/9] Moving setup scripts...

if exist "1-INSTALL_VS_BUILDTOOLS_WINGET.bat" move "1-INSTALL_VS_BUILDTOOLS_WINGET.bat" "01-SETUP-SCRIPTS\" >nul
if exist "1-INSTALL_VS_BUILDTOOLS.bat" move "1-INSTALL_VS_BUILDTOOLS.bat" "01-SETUP-SCRIPTS\" >nul
if exist "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat" move "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat" "01-SETUP-SCRIPTS\" >nul
if exist "3-RUN_INSTALL_3DPACK.bat" move "3-RUN_INSTALL_3DPACK.bat" "01-SETUP-SCRIPTS\" >nul
if exist "4-DOWNLOAD_3D_MODELS.bat" move "4-DOWNLOAD_3D_MODELS.bat" "01-SETUP-SCRIPTS\" >nul
if exist "5-SETUP_SD_MODELS.bat" move "5-SETUP_SD_MODELS.bat" "01-SETUP-SCRIPTS\" >nul

echo [OK] Setup scripts moved
echo.

REM ============================================
REM MOVE PYTHON SCRIPTS
REM ============================================

echo [4/9] Moving Python scripts...

if exist "download_models.py" move "download_models.py" "02-PYTHON-SCRIPTS\" >nul
if exist "download_sd_models.py" move "download_sd_models.py" "02-PYTHON-SCRIPTS\" >nul
if exist "download_sd_simple.py" move "download_sd_simple.py" "02-PYTHON-SCRIPTS\" >nul

echo [OK] Python scripts moved
echo.

REM ============================================
REM MOVE DOCUMENTATION
REM ============================================

echo [5/9] Moving documentation...

if exist "COMO_USAR.md" move "COMO_USAR.md" "03-DOCUMENTATION\" >nul
if exist "TESTING_GUIDE.md" move "TESTING_GUIDE.md" "03-DOCUMENTATION\" >nul
if exist "TROUBLESHOOTING_BATCH_FILES.md" move "TROUBLESHOOTING_BATCH_FILES.md" "03-DOCUMENTATION\" >nul
if exist "ORDEM_DE_INSTALACAO.md" move "ORDEM_DE_INSTALACAO.md" "03-DOCUMENTATION\" >nul
if exist "PREPARING_EXE_INSTALLER.md" move "PREPARING_EXE_INSTALLER.md" "03-DOCUMENTATION\" >nul
if exist "PROJECT_ORGANIZATION.md" move "PROJECT_ORGANIZATION.md" "03-DOCUMENTATION\" >nul

echo [OK] Documentation moved
echo.

REM ============================================
REM MOVE WORKFLOW DOCUMENTATION
REM ============================================

echo [6/9] Moving workflow documentation...

if exist "WORKFLOWS_DISPONIVEIS.md" move "WORKFLOWS_DISPONIVEIS.md" "04-WORKFLOWS\" >nul
if exist "WORKFLOW_COMPLETO_GUIA.md" move "WORKFLOW_COMPLETO_GUIA.md" "04-WORKFLOWS\" >nul
if exist "COMO_TRANSFORMAR_FOTO_EM_3D.md" move "COMO_TRANSFORMAR_FOTO_EM_3D.md" "04-WORKFLOWS\" >nul

echo [OK] Workflow documentation moved
echo.

REM ============================================
REM MOVE RELEASE INFORMATION
REM ============================================

echo [7/9] Moving release information...

if exist "CHANGELOG.md" move "CHANGELOG.md" "05-RELEASE\" >nul
if exist "RELEASE_GUIDE.md" move "RELEASE_GUIDE.md" "05-RELEASE\" >nul

echo [OK] Release information moved
echo.

REM ============================================
REM MOVE DEPRECATED FILES TO LEGACY
REM ============================================

echo [8/9] Moving deprecated files to LEGACY...

if exist "0-INSTALL_ALL_AUTOMATED.bat" move "0-INSTALL_ALL_AUTOMATED.bat" "LEGACY\" >nul
if exist "6-START_AIEXX.bat" move "6-START_AIEXX.bat" "LEGACY\" >nul
if exist "INSTALACAO_AUTOMATIZADA.md" move "INSTALACAO_AUTOMATIZADA.md" "LEGACY\" >nul
if exist "QUICK_LAUNCH_GUIDE.md" move "QUICK_LAUNCH_GUIDE.md" "LEGACY\" >nul
if exist "QUICK_START_GUIDE.md" move "QUICK_START_GUIDE.md" "LEGACY\" >nul
if exist "README_NEXT_STEPS.md" move "README_NEXT_STEPS.md" "LEGACY\" >nul
if exist "CHECKLIST.md" move "CHECKLIST.md" "LEGACY\" >nul
if exist "CLEANUP_ANALYSIS.md" move "CLEANUP_ANALYSIS.md" "LEGACY\" >nul
if exist "CLEANUP_REPORT.md" move "CLEANUP_REPORT.md" "LEGACY\" >nul
if exist "INSTALL_3DPACK_INSTRUCTIONS.md" move "INSTALL_3DPACK_INSTRUCTIONS.md" "LEGACY\" >nul
if exist "INSTALL_CUDA_TOOLKIT.md" move "INSTALL_CUDA_TOOLKIT.md" "LEGACY\" >nul
if exist "SETUP_COMPLETE_3D_SYSTEM.md" move "SETUP_COMPLETE_3D_SYSTEM.md" "LEGACY\" >nul
if exist "RESUMO_REORGANIZACAO.md" move "RESUMO_REORGANIZACAO.md" "LEGACY\" >nul
if exist "RELEASE_v1.0.0.md" move "RELEASE_v1.0.0.md" "LEGACY\" >nul
if exist "LEIA_PRIMEIRO.txt" move "LEIA_PRIMEIRO.txt" "LEGACY\" >nul
if exist "TROUBLESHOOTING.md" move "TROUBLESHOOTING.md" "LEGACY\" >nul

echo [OK] Deprecated files moved to LEGACY
echo.

REM ============================================
REM CREATE README FILES IN FOLDERS
REM ============================================

echo [9/9] Creating README files in folders...

echo # AIEXX Launcher Files > "00-LAUNCHER\README.txt"
echo. >> "00-LAUNCHER\README.txt"
echo AIEXX_LAUNCHER.bat - Main launcher (use this!) >> "00-LAUNCHER\README.txt"
echo DIAGNOSTIC_TEST.bat - System diagnostic tool >> "00-LAUNCHER\README.txt"
echo START_HERE.md - Read this first! >> "00-LAUNCHER\README.txt"

echo # AIEXX Setup Scripts > "01-SETUP-SCRIPTS\README.txt"
echo. >> "01-SETUP-SCRIPTS\README.txt"
echo Run these scripts in numerical order: >> "01-SETUP-SCRIPTS\README.txt"
echo 1. Install VS Build Tools (RESTART after this!) >> "01-SETUP-SCRIPTS\README.txt"
echo 2. Create Python virtual environment >> "01-SETUP-SCRIPTS\README.txt"
echo 3. Install ComfyUI 3D-Pack >> "01-SETUP-SCRIPTS\README.txt"
echo 4. Download 3D models >> "01-SETUP-SCRIPTS\README.txt"
echo 5. Download SD models (optional) >> "01-SETUP-SCRIPTS\README.txt"

echo # AIEXX Python Scripts > "02-PYTHON-SCRIPTS\README.txt"
echo. >> "02-PYTHON-SCRIPTS\README.txt"
echo download_models.py - Download 3D models >> "02-PYTHON-SCRIPTS\README.txt"
echo download_sd_models.py - Download SD models (full) >> "02-PYTHON-SCRIPTS\README.txt"
echo download_sd_simple.py - Download SD models (simple) >> "02-PYTHON-SCRIPTS\README.txt"

echo # AIEXX Documentation > "03-DOCUMENTATION\README.txt"
echo. >> "03-DOCUMENTATION\README.txt"
echo Active documentation files >> "03-DOCUMENTATION\README.txt"

echo # AIEXX Workflow Guides > "04-WORKFLOWS\README.txt"
echo. >> "04-WORKFLOWS\README.txt"
echo Workflow documentation and tutorials >> "04-WORKFLOWS\README.txt"

echo # AIEXX Release Information > "05-RELEASE\README.txt"
echo. >> "05-RELEASE\README.txt"
echo Changelog and release guides >> "05-RELEASE\README.txt"

echo # LEGACY Files > "LEGACY\README.txt"
echo. >> "LEGACY\README.txt"
echo Deprecated and old files kept for reference. >> "LEGACY\README.txt"
echo Do not use these files - use files in 00-LAUNCHER instead! >> "LEGACY\README.txt"

echo [OK] README files created
echo.

REM ============================================
REM SUMMARY
REM ============================================

echo ========================================================================
echo   Reorganization Complete!
echo ========================================================================
echo.
echo   New Structure:
echo.
echo   00-LAUNCHER/          - Main launcher files (START HERE!)
echo   01-SETUP-SCRIPTS/     - Installation scripts
echo   02-PYTHON-SCRIPTS/    - Python download scripts
echo   03-DOCUMENTATION/     - Active documentation
echo   04-WORKFLOWS/         - Workflow guides
echo   05-RELEASE/           - Release information
echo   LEGACY/               - Deprecated files (do not use)
echo.
echo   Next Steps:
echo   1. Go to 00-LAUNCHER folder
echo   2. Read START_HERE.md
echo   3. Run AIEXX_LAUNCHER.bat
echo.
echo ========================================================================
echo.

pause

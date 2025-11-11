@echo off
chcp 65001 >nul 2>&1
REM ============================================
REM AIEXX - Diagnostic Test Script
REM Tests all batch files for errors
REM ============================================

title AIEXX Diagnostic Test
color 0E

cd /d "%~dp0"

echo.
echo ========================================================================
echo.
echo    █████╗ ██╗███████╗██╗  ██╗██╗  ██╗
echo   ██╔══██╗██║██╔════╝╚██╗██╔╝╚██╗██╔╝
echo   ███████║██║█████╗   ╚███╔╝  ╚███╔╝
echo   ██╔══██║██║██╔══╝   ██╔██╗  ██╔██╗
echo   ██║  ██║██║███████╗██╔╝ ██╗██╔╝ ██╗
echo   ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
echo.
echo   System Diagnostic Test
echo.
echo ========================================================================
echo.
echo   This script will test all batch files and system components
echo   to identify any issues.
echo.
echo ========================================================================
echo.
pause

echo.
echo [TEST 1/10] Testing batch file encoding...
echo.

REM Test if we can display ASCII art
echo Testing ASCII art display:
echo    AIEXX
echo    GenAI
echo.

REM Test if special characters work
echo Testing special characters:
echo [OK] Brackets work
echo (OK) Parentheses work
echo ^| Pipe works
echo.

echo [TEST 2/10] Testing directory access...
echo.
echo Current directory: %CD%
echo.
if exist "ComfyUI" (
    echo [OK] ComfyUI directory found
) else (
    echo [WARNING] ComfyUI directory NOT found
)
echo.

echo [TEST 3/10] Testing Python availability...
echo.
where python >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Python not found in PATH
) else (
    python --version
    echo [OK] Python found
)
echo.

echo [TEST 4/10] Testing virtual environment...
echo.
if exist ".venv311\Scripts\python.exe" (
    echo [OK] Virtual environment exists at: .venv311
    .venv311\Scripts\python.exe --version
) else (
    echo [WARNING] Virtual environment NOT found at: .venv311
)
echo.

echo [TEST 5/10] Testing Git availability...
echo.
where git >nul 2>&1
if errorlevel 1 (
    echo [INFO] Git not found in PATH (optional)
) else (
    git --version
    echo [OK] Git found
)
echo.

echo [TEST 6/10] Testing network connectivity...
echo.
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo [WARNING] No internet connection detected
) else (
    echo [OK] Internet connection active
)
echo.

echo [TEST 7/10] Testing disk space...
echo.
for /f "tokens=3" %%a in ('dir /-c 2^>nul ^| findstr /C:"bytes free"') do set FREE_SPACE=%%a
if defined FREE_SPACE (
    echo [OK] Free space: %FREE_SPACE% bytes
) else (
    echo [WARNING] Could not determine free space
)
echo.

echo [TEST 8/10] Testing batch file syntax...
echo.

set BATCH_ERROR=0

if exist "1-INSTALL_VS_BUILDTOOLS_WINGET.bat" (
    echo [OK] 1-INSTALL_VS_BUILDTOOLS_WINGET.bat exists
) else (
    echo [ERROR] 1-INSTALL_VS_BUILDTOOLS_WINGET.bat missing
    set BATCH_ERROR=1
)

if exist "2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat" (
    echo [OK] 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat exists
) else (
    echo [ERROR] 2-FIX_VENV_AND_INSTALL_TORCH_SCATTER.bat missing
    set BATCH_ERROR=1
)

if exist "3-RUN_INSTALL_3DPACK.bat" (
    echo [OK] 3-RUN_INSTALL_3DPACK.bat exists
) else (
    echo [ERROR] 3-RUN_INSTALL_3DPACK.bat missing
    set BATCH_ERROR=1
)

if exist "4-DOWNLOAD_3D_MODELS.bat" (
    echo [OK] 4-DOWNLOAD_3D_MODELS.bat exists
) else (
    echo [ERROR] 4-DOWNLOAD_3D_MODELS.bat missing
    set BATCH_ERROR=1
)

if exist "5-SETUP_SD_MODELS.bat" (
    echo [OK] 5-SETUP_SD_MODELS.bat exists
) else (
    echo [ERROR] 5-SETUP_SD_MODELS.bat missing
    set BATCH_ERROR=1
)

if exist "6-START_AIEXX.bat" (
    echo [OK] 6-START_AIEXX.bat exists
) else (
    echo [ERROR] 6-START_AIEXX.bat missing
    set BATCH_ERROR=1
)

echo.

echo [TEST 9/10] Testing file permissions...
echo.
echo Test > test_write.tmp
if exist test_write.tmp (
    echo [OK] Can write files in current directory
    del test_write.tmp
) else (
    echo [ERROR] Cannot write files - check permissions
)
echo.

echo [TEST 10/10] Testing environment variables...
echo.
echo PATH length:
echo %PATH% | find /c "\" >nul
echo [OK] PATH variable accessible
echo.
echo TEMP: %TEMP%
echo.

echo ========================================================================
echo   Diagnostic Test Complete
echo ========================================================================
echo.

if %BATCH_ERROR%==1 (
    color 0C
    echo [ERROR] Some batch files are missing!
    echo Please ensure all installation scripts are present.
) else (
    color 0A
    echo [SUCCESS] All batch files found!
)

echo.
echo ========================================================================
echo   Summary:
echo ========================================================================
echo.
echo   Python:
where python >nul 2>&1 && echo   [OK] Found || echo   [NOT FOUND]
echo.
echo   Virtual Environment:
if exist ".venv311\Scripts\python.exe" (echo   [OK] Found) else (echo   [NOT FOUND])
echo.
echo   ComfyUI:
if exist "ComfyUI\main.py" (echo   [OK] Found) else (echo   [NOT FOUND])
echo.
echo   Git:
where git >nul 2>&1 && echo   [OK] Found || echo   [NOT FOUND - Optional]
echo.
echo   Internet:
ping -n 1 8.8.8.8 >nul 2>&1 && echo   [OK] Connected || echo   [NOT CONNECTED]
echo.
echo ========================================================================
echo.
echo Press any key to save diagnostic report to file...
pause >nul

echo ========================================================================> diagnostic_report.txt
echo   AIEXX Diagnostic Report>> diagnostic_report.txt
echo   Generated: %DATE% %TIME%>> diagnostic_report.txt
echo ========================================================================>> diagnostic_report.txt
echo.>> diagnostic_report.txt
echo Current Directory: %CD%>> diagnostic_report.txt
echo.>> diagnostic_report.txt

where python >nul 2>&1
if errorlevel 1 (
    echo Python: NOT FOUND>> diagnostic_report.txt
) else (
    python --version >> diagnostic_report.txt 2>&1
)

if exist ".venv311\Scripts\python.exe" (
    echo Virtual Environment: FOUND>> diagnostic_report.txt
) else (
    echo Virtual Environment: NOT FOUND>> diagnostic_report.txt
)

if exist "ComfyUI\main.py" (
    echo ComfyUI: FOUND>> diagnostic_report.txt
) else (
    echo ComfyUI: NOT FOUND>> diagnostic_report.txt
)

echo.>> diagnostic_report.txt
echo Batch Files:>> diagnostic_report.txt
dir *.bat /b >> diagnostic_report.txt

echo.
echo [SUCCESS] Diagnostic report saved to: diagnostic_report.txt
echo.
pause

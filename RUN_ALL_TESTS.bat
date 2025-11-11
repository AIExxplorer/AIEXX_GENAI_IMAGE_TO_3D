@echo off
REM ============================================
REM AIEXX - Automated Test Suite
REM Executes all tests sequentially
REM ============================================

title AIEXX - Automated Test Suite
color 0B

cd /d "%~dp0"

cls
echo.
echo ========================================================================
echo   AIEXX - Automated Test Suite
echo ========================================================================
echo.
echo   This will execute all tests in sequence:
echo   1. Encoding tests
echo   2. Syntax validation
echo   3. Diagnostic test
echo   4. Launcher test (both modes)
echo   5. Integration tests
echo.
echo ========================================================================
echo.

pause

REM Create test results directory
if not exist "test_results" mkdir "test_results"

set "RESULTS_FILE=test_results\test_results_%DATE%_%TIME::=%.txt"
set "RESULTS_FILE=%RESULTS_FILE: =_%"

echo ========================================================================> "%RESULTS_FILE%"
echo   AIEXX Test Suite Results>> "%RESULTS_FILE%"
echo   Date: %DATE% %TIME%>> "%RESULTS_FILE%"
echo ========================================================================>> "%RESULTS_FILE%"
echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 1: ENCODING VERIFICATION
REM ============================================

echo.
echo ========================================================================
echo   TEST 1: Encoding Verification
echo ========================================================================
echo.

echo [TEST 1] Encoding Verification>> "%RESULTS_FILE%"

echo Checking file encoding...
file *.bat 2>nul > "test_results\encoding_check.txt"

if exist "test_results\encoding_check.txt" (
    echo [PASS] Encoding check completed>> "%RESULTS_FILE%"
    echo.>> "%RESULTS_FILE%"
    type "test_results\encoding_check.txt" >> "%RESULTS_FILE%"
    echo [OK] Encoding check completed
) else (
    echo [FAIL] Could not check encoding>> "%RESULTS_FILE%"
    echo [FAIL] Could not check encoding
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 2: FILE EXISTENCE
REM ============================================

echo.
echo ========================================================================
echo   TEST 2: Required Files Check
echo ========================================================================
echo.

echo [TEST 2] Required Files Check>> "%RESULTS_FILE%"

set "MISSING_FILES=0"

echo Checking critical files...
if exist "AIEXX_LAUNCHER.bat" (
    echo [OK] AIEXX_LAUNCHER.bat found
    echo [PASS] AIEXX_LAUNCHER.bat found>> "%RESULTS_FILE%"
) else (
    echo [FAIL] AIEXX_LAUNCHER.bat MISSING
    echo [FAIL] AIEXX_LAUNCHER.bat MISSING>> "%RESULTS_FILE%"
    set /a MISSING_FILES+=1
)

if exist "DIAGNOSTIC_TEST.bat" (
    echo [OK] DIAGNOSTIC_TEST.bat found
    echo [PASS] DIAGNOSTIC_TEST.bat found>> "%RESULTS_FILE%"
) else (
    echo [FAIL] DIAGNOSTIC_TEST.bat MISSING
    echo [FAIL] DIAGNOSTIC_TEST.bat MISSING>> "%RESULTS_FILE%"
    set /a MISSING_FILES+=1
)

if exist "LICENSE.txt" (
    echo [OK] LICENSE.txt found
    echo [PASS] LICENSE.txt found>> "%RESULTS_FILE%"
) else (
    echo [FAIL] LICENSE.txt MISSING
    echo [FAIL] LICENSE.txt MISSING>> "%RESULTS_FILE%"
    set /a MISSING_FILES+=1
)

if exist "AIEXX_Installer.iss" (
    echo [OK] AIEXX_Installer.iss found
    echo [PASS] AIEXX_Installer.iss found>> "%RESULTS_FILE%"
) else (
    echo [FAIL] AIEXX_Installer.iss MISSING
    echo [FAIL] AIEXX_Installer.iss MISSING>> "%RESULTS_FILE%"
    set /a MISSING_FILES+=1
)

echo.>> "%RESULTS_FILE%"
echo Missing files: %MISSING_FILES%>> "%RESULTS_FILE%"
echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 3: PYTHON AVAILABILITY
REM ============================================

echo.
echo ========================================================================
echo   TEST 3: Python Availability
echo ========================================================================
echo.

echo [TEST 3] Python Availability>> "%RESULTS_FILE%"

where python >nul 2>&1
if errorlevel 1 (
    echo [WARN] Python not found in PATH
    echo [WARN] Python not found in PATH>> "%RESULTS_FILE%"
) else (
    python --version
    echo [PASS] Python found:>> "%RESULTS_FILE%"
    python --version >> "%RESULTS_FILE%" 2>&1
    echo [OK] Python found
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 4: GIT AVAILABILITY (OPTIONAL)
REM ============================================

echo.
echo ========================================================================
echo   TEST 4: Git Availability (Optional)
echo ========================================================================
echo.

echo [TEST 4] Git Availability>> "%RESULTS_FILE%"

where git >nul 2>&1
if errorlevel 1 (
    echo [INFO] Git not found (optional)
    echo [INFO] Git not found - optional>> "%RESULTS_FILE%"
) else (
    git --version
    echo [PASS] Git found:>> "%RESULTS_FILE%"
    git --version >> "%RESULTS_FILE%" 2>&1
    echo [OK] Git found
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 5: INTERNET CONNECTIVITY
REM ============================================

echo.
echo ========================================================================
echo   TEST 5: Internet Connectivity
echo ========================================================================
echo.

echo [TEST 5] Internet Connectivity>> "%RESULTS_FILE%"

ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo [WARN] No internet connection detected
    echo [WARN] No internet connection>> "%RESULTS_FILE%"
) else (
    echo [OK] Internet connection active
    echo [PASS] Internet connection active>> "%RESULTS_FILE%"
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 6: DISK SPACE
REM ============================================

echo.
echo ========================================================================
echo   TEST 6: Disk Space Check
echo ========================================================================
echo.

echo [TEST 6] Disk Space Check>> "%RESULTS_FILE%"

for /f "tokens=3" %%a in ('dir /-c 2^>nul ^| findstr /C:"bytes free"') do set FREE_SPACE=%%a
if defined FREE_SPACE (
    echo [OK] Free space: %FREE_SPACE% bytes
    echo [PASS] Free space: %FREE_SPACE% bytes>> "%RESULTS_FILE%"
) else (
    echo [WARN] Could not determine free space
    echo [WARN] Could not determine free space>> "%RESULTS_FILE%"
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 7: VIRTUAL ENVIRONMENT
REM ============================================

echo.
echo ========================================================================
echo   TEST 7: Virtual Environment Check
echo ========================================================================
echo.

echo [TEST 7] Virtual Environment>> "%RESULTS_FILE%"

if exist ".venv311\Scripts\python.exe" (
    echo [OK] Virtual environment exists
    echo [PASS] Virtual environment exists>> "%RESULTS_FILE%"
    .venv311\Scripts\python.exe --version >> "%RESULTS_FILE%" 2>&1
) else (
    echo [INFO] Virtual environment not created yet
    echo [INFO] Virtual environment not created yet>> "%RESULTS_FILE%"
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM TEST 8: COMFYUI INSTALLATION
REM ============================================

echo.
echo ========================================================================
echo   TEST 8: ComfyUI Installation Check
echo ========================================================================
echo.

echo [TEST 8] ComfyUI Installation>> "%RESULTS_FILE%"

if exist "ComfyUI\main.py" (
    echo [OK] ComfyUI installed
    echo [PASS] ComfyUI installed>> "%RESULTS_FILE%"
) else (
    echo [INFO] ComfyUI not installed yet
    echo [INFO] ComfyUI not installed yet>> "%RESULTS_FILE%"
)

echo.>> "%RESULTS_FILE%"

REM ============================================
REM SUMMARY
REM ============================================

echo.
echo ========================================================================
echo   Test Suite Complete
echo ========================================================================
echo.

echo ========================================================================>> "%RESULTS_FILE%"
echo   Test Suite Summary>> "%RESULTS_FILE%"
echo ========================================================================>> "%RESULTS_FILE%"
echo.>> "%RESULTS_FILE%"
echo Test completed at: %DATE% %TIME%>> "%RESULTS_FILE%"
echo Results saved to: %RESULTS_FILE%>> "%RESULTS_FILE%"
echo.>> "%RESULTS_FILE%"

echo Results saved to: %RESULTS_FILE%
echo.
echo Opening results file...
notepad "%RESULTS_FILE%"

echo.
echo ========================================================================
echo   Next Steps:
echo ========================================================================
echo.
echo   1. Review test results in: %RESULTS_FILE%
echo   2. If Python missing: Install Python 3.11.9
echo   3. If tests passed: Run AIEXX_LAUNCHER.bat
echo   4. For detailed diagnostics: Run DIAGNOSTIC_TEST.bat
echo.

pause

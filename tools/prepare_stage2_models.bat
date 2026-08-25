@echo off
setlocal
set "ROOT=%~dp0.."
set "DL=%ROOT%\electronics\spice\models\ti\downloads"
set "EX=%ROOT%\electronics\spice\models\ti\extracted"

echo Project Phoenix Stage 2 model preparation
echo ==========================================
echo.

if not exist "%DL%" mkdir "%DL%"
if not exist "%EX%" mkdir "%EX%"

echo Expected official TI downloads:
echo   %DL%\SLVMC40.ZIP   ^(LM317 unencrypted PSpice transient model^)
echo   %DL%\SNVMAP4.ZIP   ^(LM337-N unencrypted PSpice transient model^)
echo.

set "MISSING=0"
if not exist "%DL%\SLVMC40.ZIP" (
  echo MISSING: SLVMC40.ZIP
  set "MISSING=1"
)
if not exist "%DL%\SNVMAP4.ZIP" (
  echo MISSING: SNVMAP4.ZIP
  set "MISSING=1"
)

if "%MISSING%"=="1" (
  echo.
  echo Download the missing archives from the official TI product pages and rerun.
  exit /b 2
)

echo Extracting archives with PowerShell...
powershell -NoProfile -Command "Expand-Archive -LiteralPath '%DL%\SLVMC40.ZIP' -DestinationPath '%EX%\LM317' -Force"
if errorlevel 1 exit /b 3

powershell -NoProfile -Command "Expand-Archive -LiteralPath '%DL%\SNVMAP4.ZIP' -DestinationPath '%EX%\LM337' -Force"
if errorlevel 1 exit /b 4

echo.
echo Enumerating SPICE subcircuits and SHA-256 hashes...
python "%ROOT%\tools\inspect_spice_subckts.py" "%EX%\LM317" "%EX%\LM337"
if errorlevel 1 exit /b 5

echo.
echo Preparation complete.
echo Do not bind the Stage 2 deck until the reported top-level SUBCKT names and node
echo order have been reviewed.
endlocal

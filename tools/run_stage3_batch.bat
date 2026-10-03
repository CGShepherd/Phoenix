@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0.."
set "SPICE=%ROOT%\electronics\spice"
set "OUT=%ROOT%\test\results\stage3_batch"

if not exist "%OUT%" mkdir "%OUT%"

if defined LTSPICE_EXE (
  set "LT=%LTSPICE_EXE%"
) else (
  set "LT="
  if exist "%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe" set "LT=%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe"
  if not defined LT if exist "%ProgramFiles%\ADI\LTspice\LTspice.exe" set "LT=%ProgramFiles%\ADI\LTspice\LTspice.exe"
  if not defined LT if exist "%ProgramFiles%\LTC\LTspiceXVII\XVIIx64.exe" set "LT=%ProgramFiles%\LTC\LTspiceXVII\XVIIx64.exe"
)

if not defined LT (
  echo ERROR: LTspice executable not found.
  echo Set LTSPICE_EXE to the full path to LTspice.exe and rerun.
  exit /b 2
)

echo LTspice: %LT%
echo Results: %OUT%
echo.

set "MASTER=%OUT%\PHX_STAGE3_BATCH_MASTER.log"
> "%MASTER%" echo Project Phoenix Stage 3 batch
>>"%MASTER%" echo LTspice: %LT%
>>"%MASTER%" echo Started: %DATE% %TIME%
>>"%MASTER%" echo.

set FAIL=0
pushd "%SPICE%"

for %%D in (
  PHX_ARCH_C_stage3_batch_00_normal.cir
  PHX_ARCH_C_stage3_batch_01_trigger_threshold.cir
  PHX_ARCH_C_stage3_batch_02_fuse_i2t.cir
  PHX_ARCH_C_stage3_batch_03p_pass_short.cir
  PHX_ARCH_C_stage3_batch_03n_pass_short.cir
  PHX_ARCH_C_stage3_batch_04_startup_shutdown.cir
  PHX_ARCH_C_stage3_batch_05_one_rail_loss.cir
) do (
  echo ================================================================
  echo Running %%D
  echo ================================================================
  >>"%MASTER%" echo ================================================================
  >>"%MASTER%" echo Running %%D
  >>"%MASTER%" echo ================================================================
  "%LT%" -b "%%D" > "%OUT%\%%~nD.stdout.log" 2>&1
  set RC=!ERRORLEVEL!
  type "%OUT%\%%~nD.stdout.log" >> "%MASTER%"
  >>"%MASTER%" echo ExitCode=!RC!
  >>"%MASTER%" echo.
  if not "!RC!"=="0" (
    echo FAILED: %%D ^(exit !RC!^)
    set FAIL=1
  ) else (
    echo completed.
  )
)

popd

>>"%MASTER%" echo Finished: %DATE% %TIME%
echo.
echo Batch complete.
echo Master log:
echo   %MASTER%

if "%FAIL%"=="1" (
  echo One or more decks returned a non-zero exit code.
  exit /b 1
)
exit /b 0

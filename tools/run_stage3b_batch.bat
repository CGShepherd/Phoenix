@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "ROOT=%~dp0.."
set "SPICE=%ROOT%\electronics\spice"
set "OUT=%ROOT%\test\results\stage3b_batch"
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
  exit /b 2
)

set "MASTER=%OUT%\PHX_STAGE3B_MASTER.log"
> "%MASTER%" echo Project Phoenix Stage 3B batch
>>"%MASTER%" echo LTspice: %LT%
>>"%MASTER%" echo Started: %DATE% %TIME%

pushd "%SPICE%"
set FAIL=0
for %%D in (
  PHX_ARCH_C_stage3b_00_fuse_i2t.cir
  PHX_ARCH_C_stage3b_01p_pass_short.cir
  PHX_ARCH_C_stage3b_01n_pass_short.cir
  PHX_ARCH_C_stage3b_02_trigger_window.cir
  PHX_ARCH_C_stage3b_03_nuisance_margin.cir
  PHX_ARCH_C_stage3b_04_shutdown.cir
  PHX_ARCH_C_stage3b_05_rail_loss.cir
  PHX_ARCH_C_stage3b_06_holding_margin.cir
) do (
  echo Running %%D
  >>"%MASTER%" echo ================================================================
  >>"%MASTER%" echo Running %%D
  "%LT%" -b "%%D" > "%OUT%\%%~nD.stdout.log" 2>&1
  set RC=!ERRORLEVEL!
  >>"%MASTER%" echo ExitCode=!RC!

  if exist "%%~nD.log" (
    copy /Y "%%~nD.log" "%OUT%\%%~nD.ltspice.log" >nul
    >>"%MASTER%" type "%%~nD.log"
  ) else (
    >>"%MASTER%" echo WARNING: LTspice .log not found for %%D
  )

  if not "!RC!"=="0" set FAIL=1
)
popd

>>"%MASTER%" echo Finished: %DATE% %TIME%
echo Batch complete:
echo %MASTER%
exit /b %FAIL%

@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "ROOT=%~dp0.."
set "SPICE=%ROOT%\electronics\spice"
set "OUT=%ROOT%\test\results\stage3c_batch"
if not exist "%OUT%" mkdir "%OUT%"

if defined LTSPICE_EXE (
  set "LT=%LTSPICE_EXE%"
) else (
  set "LT="
  if exist "%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe" set "LT=%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe"
  if not defined LT if exist "%ProgramFiles%\ADI\LTspice\LTspice.exe" set "LT=%ProgramFiles%\ADI\LTspice\LTspice.exe"
)
if not defined LT (
  echo ERROR: LTspice executable not found.
  exit /b 2
)

set "MASTER=%OUT%\PHX_STAGE3C_MASTER.log"
> "%MASTER%" echo Project Phoenix Stage 3C batch
>>"%MASTER%" echo LTspice: %LT%
>>"%MASTER%" echo Started: %DATE% %TIME%

pushd "%SPICE%"
set FAIL=0
for %%D in (
  PHX_ARCH_C_stage3c_00_trigger_window.cir
  PHX_ARCH_C_stage3c_01p_fault_delay.cir
  PHX_ARCH_C_stage3c_01n_fault_delay.cir
  PHX_ARCH_C_stage3c_02_fuse_clearing.cir
  PHX_ARCH_C_stage3c_03_resistor_pulse.cir
  PHX_ARCH_C_stage3c_04_trigger_margin.cir
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
  )
  if not "!RC!"=="0" set FAIL=1
)
popd

>>"%MASTER%" echo Finished: %DATE% %TIME%
echo Batch complete:
echo %MASTER%
exit /b %FAIL%

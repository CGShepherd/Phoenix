@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "ROOT=%~dp0.."
set "SPICE=%ROOT%\electronics\spice"
set "OUT=%ROOT%\test\results\stage3d_batch"
if not exist "%OUT%" mkdir "%OUT%"

if defined LTSPICE_EXE (
  set "LT=%LTSPICE_EXE%"
) else (
  set "LT="
  if exist "%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe" set "LT=%LOCALAPPDATA%\Programs\ADI\LTspice\LTspice.exe"
  if not defined LT if exist "%ProgramFiles%\ADI\LTspice\LTspice.exe" set "LT=%ProgramFiles%\ADI\LTspice\LTspice.exe"
)
if not defined LT exit /b 2

set "MASTER=%OUT%\PHX_STAGE3D_MASTER.log"
> "%MASTER%" echo Project Phoenix Stage 3D batch
>>"%MASTER%" echo Started: %DATE% %TIME%

pushd "%SPICE%"
set FAIL=0
for %%D in (
  PHX_ARCH_C_stage3d_00_normal_tvs.cir
  PHX_ARCH_C_stage3d_01_tvs_clamp.cir
  PHX_ARCH_C_stage3d_02_tvs_scr.cir
  PHX_ARCH_C_stage3d_03_tvs_fuse_i2t.cir
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
echo %MASTER%
exit /b %FAIL%

@echo off
setlocal EnableExtensions
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

if not defined LT (
  echo ERROR: LTspice executable not found.
  exit /b 2
)

pushd "%SPICE%"
"%LT%" -b "PHX_ARCH_C_stage3d_04_fuse_i2t_fixed.cir"
set RC=%ERRORLEVEL%
if exist "PHX_ARCH_C_stage3d_04_fuse_i2t_fixed.log" (
  copy /Y "PHX_ARCH_C_stage3d_04_fuse_i2t_fixed.log" "%OUT%\PHX_ARCH_C_stage3d_04_fuse_i2t_fixed.log" >nul
)
popd

exit /b %RC%

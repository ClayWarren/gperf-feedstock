set "GPERF_TARGET_PLATFORM=%target_platform%"
if "%target_platform%" == "win-arm64" (
  call "%BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat"
  if errorlevel 1 exit /b 1
  exit /b 0
)
set PREFIX=%LIBRARY_PREFIX:\=/%
bash %RECIPE_DIR%/build.sh
if errorlevel 1 exit 1

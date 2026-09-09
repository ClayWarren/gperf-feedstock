@echo on
if "%target_platform%" == "win-arm64" (
  gperf keywords.gperf > lookup.c
  if errorlevel 1 exit /b 1
  cl /nologo check_lookup.c /Fe:check_lookup.exe
  if errorlevel 1 exit /b 1
  dumpbin /headers "%LIBRARY_BIN%\gperf.exe" | findstr /I /C:"AA64 machine (ARM64)"
  if errorlevel 1 exit /b 1
  dumpbin /headers check_lookup.exe | findstr /I /C:"AA64 machine (ARM64)"
  if errorlevel 1 exit /b 1
  check_lookup.exe
  if errorlevel 1 exit /b 1
)

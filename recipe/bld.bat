@echo off
setlocal

:: Ensure CGO is disabled for reproducible builds
set CGO_ENABLED=0

:: Build binary directly with Windows Go toolchain
go build -v -o "%PREFIX%\bin\go-licenses.exe"
if %errorlevel% neq 0 exit /b %errorlevel%

exit /b 0
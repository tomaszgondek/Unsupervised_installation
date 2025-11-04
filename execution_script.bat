@echo off
setlocal
set SCRIPT=%~dp0script.ps1

:: Sprawdź, czy plik istnieje
if not exist "%SCRIPT%" (
    echo Skrypt PowerShell 'skrypt.ps1' nie został znaleziony na pendrive!
    pause
    exit /b 1
)
echo Uruchamianie skryptu PowerShell z uprawnieniami administratora...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT%\"' -Verb RunAs"
echo Skrypt został uruchomiony.
pause

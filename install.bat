@echo off
setlocal

set "TB_PROFILES=%APPDATA%\Thunderbird\Profiles"

if not exist "%TB_PROFILES%" (
  echo Dossier de profils Thunderbird introuvable.
  pause
  exit /b 1
)

echo Profils Thunderbird detectes :
echo.

for /d %%D in ("%TB_PROFILES%\*") do (
  echo Installation dans : %%~nxD

  if not exist "%%D\chrome" mkdir "%%D\chrome"

  xcopy /E /Y /I "%~dp0chrome" "%%D\chrome" >nul

  findstr /C:"toolkit.legacyUserProfileCustomizations.stylesheets" "%%D\user.js" >nul 2>nul
  if errorlevel 1 (
    echo user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);>>"%%D\user.js"
  )

  echo OK.
  echo.
)

echo Installation terminee. Fermez puis relancez Thunderbird.
pause
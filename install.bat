@echo off
setlocal

title Live Skin Thunderbird Installer

echo.
echo ==========================================
echo      Live Skin Thunderbird Installer
echo ==========================================
echo.

set "SOURCE_DIR=%~dp0"
set "SOURCE_CHROME=%SOURCE_DIR%chrome"
set "SOURCE_USERJS=%SOURCE_DIR%user.js"

set "TB_PROFILES=%APPDATA%\Thunderbird\Profiles"

if not exist "%TB_PROFILES%" (
    echo ERROR : Thunderbird profiles folder not found.
    pause
    exit /b 1
)

echo Please close Thunderbird before continuing.
pause

echo.
echo Installing theme...
echo.

for /d %%P in ("%TB_PROFILES%\*") do (

    echo ------------------------------------------
    echo Profile : %%~nxP
    echo ------------------------------------------

    REM ==========================================
    REM Backup existing files
    REM ==========================================

    if exist "%%P\user.js" (
        copy /Y "%%P\user.js" "%%P\user.js.backup" >nul
    )

    if exist "%%P\chrome" (
        rmdir /S /Q "%%P\chrome.backup" 2>nul
        ren "%%P\chrome" "chrome.backup"
    )

    REM ==========================================
    REM Create chrome folder if needed
    REM ==========================================

    if not exist "%%P\chrome" (
        mkdir "%%P\chrome"
    )

    REM ==========================================
    REM Copy theme files if source exists
    REM ==========================================

    if exist "%SOURCE_CHROME%" (
        xcopy "%SOURCE_CHROME%\*" "%%P\chrome\" /E /I /Y >nul
    ) else (
        echo WARNING : source chrome folder not found.
    )

    REM ==========================================
    REM Replace user.js if provided
    REM ==========================================

    if exist "%SOURCE_USERJS%" (
        copy /Y "%SOURCE_USERJS%" "%%P\user.js" >nul
    ) else (
        echo WARNING : source user.js not found.
        echo Creating empty user.js
        type nul > "%%P\user.js"
    )

    echo Installation completed for this profile.
    echo.
)

echo ==========================================
echo Installation completed successfully.
echo Restart Thunderbird.
echo ==========================================
echo.

pause
endlocal

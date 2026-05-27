@echo off
setlocal

title Live Skin Thunderbird Uninstaller

echo.
echo ==========================================
echo      Live Skin Thunderbird Uninstaller
echo ==========================================
echo.

set "TB_PROFILES=%APPDATA%\Thunderbird\Profiles"

if not exist "%TB_PROFILES%" (
    echo ERROR : Thunderbird profiles folder not found.
    pause
    exit /b 1
)

echo Please close Thunderbird before continuing.
pause

echo.
echo Uninstalling theme...
echo.

for /d %%P in ("%TB_PROFILES%\*") do (

    echo ------------------------------------------
    echo Profile : %%~nxP
    echo ------------------------------------------

    REM Remove current chrome folder
    if exist "%%P\chrome" (
        rmdir /S /Q "%%P\chrome"
        echo Removed chrome folder.
    )

    REM Restore previous chrome backup if available
    if exist "%%P\chrome.backup" (
        ren "%%P\chrome.backup" "chrome"
        echo Restored chrome backup.
    )

    REM Remove current user.js
    if exist "%%P\user.js" (
        del /Q "%%P\user.js"
        echo Removed user.js.
    )

    REM Restore previous user.js backup if available
    if exist "%%P\user.js.backup" (
        ren "%%P\user.js.backup" "user.js"
        echo Restored user.js backup.
    )

    echo Uninstall complete for this profile.
    echo.
)

echo ==========================================
echo Uninstall completed.
echo Restart Thunderbird.
echo ==========================================
echo.

pause
endlocal

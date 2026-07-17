@echo off
chcp 65001 >nul
title 更新法爾朴網站

echo.
echo ========================================
echo   正在同步法爾朴 Obsidian Vault
echo ========================================
echo.

robocopy "H:\我的雲端硬碟\Fayrpo" "%~dp0content" *.* /E /PURGE ^
  /XD ".obsidian" ".trash" ".git" ^
  /XF "desktop.ini" "Thumbs.db"

set ROBOCOPY_EXIT=%ERRORLEVEL%

if %ROBOCOPY_EXIT% GEQ 8 (
    echo.
    echo [失敗] 複製檔案時發生錯誤，代碼：%ROBOCOPY_EXIT%
    echo 請確認 Google Drive H: 槽已連接。
    pause
    exit /b %ROBOCOPY_EXIT%
)

echo.
echo ========================================
echo   正在上傳並部署網站
echo ========================================
echo.

cd /d "%~dp0"
call npx.cmd quartz sync --no-pull

if errorlevel 1 (
    echo.
    echo [失敗] Quartz 同步或 GitHub 上傳失敗。
    pause
    exit /b 1
)

echo.
echo ========================================
echo   完成
echo ========================================
echo.
echo 網站通常會在約 1 至 3 分鐘後更新：
echo https://fairylam0328.github.io/Fayrpo-Website/
echo.
pause
@echo off
title Dramatica-Flow Web UI
cd /d %~dp0
echo ========================================
echo   Dramatica-Flow Web UI
echo ========================================
echo.
echo Starting server...
echo Access URL: http://localhost:8766
echo.
start /b python -m uvicorn core.server:app --reload --port 8766

echo Waiting for server to start...
powershell -Command "& { $uri = 'http://localhost:8766/'; for ($i = 0; $i -lt 20; $i++) { try { $r = [System.Net.HttpWebRequest]::Create($uri); $r.Timeout = 1000; $r.GetResponse().Close(); Write-Output 'ready'; exit 0 } catch {}; Start-Sleep -Milliseconds 500 }; Write-Output 'timeout'; exit 1 }" >nul 2>&1

if %errorlevel% equ 0 (
    start http://localhost:8766
    echo Server is ready!
) else (
    echo Warning: Server may not be ready yet. Trying to open anyway...
    start http://localhost:8766
)

echo.
echo Server is running in background. Press any key to exit this window.
echo.
pause >nul
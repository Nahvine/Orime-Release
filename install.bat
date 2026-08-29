@echo off
title Orime Game Optimizer - Web Installer
cd /d "%~dp0"

echo ============================================================
echo         ORIME GAME OPTIMIZER - 1-CLICK INSTALLER
echo ============================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13; irm 'https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1' | iex"

if %errorLevel% neq 0 (
    echo.
    echo [!] Khong the tai tu dong qua PowerShell. Vui long kiem tra ket noi mang.
    pause
)

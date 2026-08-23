@echo off
title Orime Uninstaller
powershell -NoProfile -ExecutionPolicy Bypass -Command irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
pause
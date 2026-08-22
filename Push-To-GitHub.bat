@echo off
title Push Orime Release to GitHub
cd /d "%~dp0"
git push -u origin main --force

@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13; irm 'https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1' | iex"

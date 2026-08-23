# ============================================================================
#  ORIME - 1-CLICK WEB INSTALLER / UPDATER
# ============================================================================
[CmdletBinding()]
param(
    [string] = ",
 [string] = C:\Program Files\Orime,
 [switch] = True
)

Continue = Stop

Clear-Host
Write-Host ============================================================ -ForegroundColor Cyan
Write-Host              ORIME - 1-CLICK SETUP / UPDATER                 -ForegroundColor Cyan
Write-Host ============================================================ -ForegroundColor Cyan
Write-Host 

# Check Admin rights & pick fallback user directory if not elevated
 = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not -and .StartsWith(C:\Program Files)) {
 = C:\Users\ender\AppData\Local\Programs\Orime
}

# 1. Gracefully & Forcefully terminate any existing Orime instances
Write-Host [1/3] Preparing environment... -ForegroundColor Yellow
 = Get-Process -Name Orime* -ErrorAction SilentlyContinue
if () {
 Write-Host   -> Closing running Orime instances... -ForegroundColor DarkGray
 | Stop-Process -Force -ErrorAction SilentlyContinue
 = 10
 while ((Get-Process -Name Orime* -ErrorAction SilentlyContinue) -and ( -gt 0)) {
 Start-Sleep -Milliseconds 300
 --
 }
}

# 2. Download package
Write-Host [2/3] Fetching Orime package... -ForegroundColor Yellow
 = Join-Path C:\Users\ender\AppData\Local\Temp Orime_Release_v1.0.zip
if (Test-Path ) { Remove-Item -Force -ErrorAction SilentlyContinue }

 = @(
 https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip,
 https://github.com/Nahvine/Orime-Release/raw/main/download/Orime_v1.0_Portable_x64.zip,
 https://github.com/Nahvine/Orime-Release/releases/latest/download/Orime_v1.0_Portable_x64.zip,
 https://github.com/Nahvine/Orime-Release/releases/download/v1.0/Orime_v1.0_Portable_x64.zip,
 https://orime.osteup.io.vn/download/Orime_v1.0_Portable_x64.zip
)

if (-not [string]::IsNullOrWhiteSpace()) {
 = @() + 
}

 = False
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

foreach ( in ) {
 try {
 Write-Host   -> Downloading from:  -ForegroundColor DarkGray
 = New-Object System.Net.WebClient
 .Headers.Add(User-Agent, Mozilla/5.0 (Windows NT 10.0; Win64; x64) Orime-Setup)
 = [System.Diagnostics.Stopwatch]::StartNew()
 
 .DownloadFile(, )
 
 if ((Test-Path ) -and ((Get-Item ).Length -gt 50000000)) {
 = True
 = [Math]::Round((Get-Item ).Length / 1MB, 2)
 = [Math]::Max(0.1, [Math]::Round(.Elapsed.TotalSeconds, 1))
 = [Math]::Round( / , 1)
 Write-Host   [OK] Downloaded  MB in s ( MB/s)! -ForegroundColor Green
 break
 }
 } catch {
 # Fallback to next mirror
 }
}

if (-not ) {
 Write-Host [ERROR] Could not download Orime package from available mirrors. -ForegroundColor Red
 Write-Host Please download manually from https://github.com/Nahvine/Orime-Release -ForegroundColor Yellow
 exit 1
}

# 3. Extract & Clean Overwrite
Write-Host [3/3] Installing / Updating Orime to:  -ForegroundColor Yellow

 = Join-Path C:\Users\ender\AppData\Local\Temp Orime_Extract
if (Test-Path ) { Remove-Item -Recurse -Force -ErrorAction SilentlyContinue }

Expand-Archive -Path -DestinationPath -Force

# Locate root directory containing Orime.exe
 = 
 = Join-Path Orime.exe
if (-not (Test-Path )) {
 = Get-ChildItem -Path -Recurse -Filter Orime.exe | Select-Object -First 1
 if () {
 = .DirectoryName
 }
}

if (-not (Test-Path )) {
 New-Item -ItemType Directory -Path -Force | Out-Null
} else {
 Write-Host   -> Existing version detected. Overwriting and updating files... -ForegroundColor DarkGray
 Get-ChildItem -Path -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

Copy-Item -Path \* -Destination -Recurse -Force

Remove-Item -Force -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# 4. Shortcuts Creation / Refresh
 = Join-Path Orime.exe
if (Test-Path ) {
 try {
 = New-Object -ComObject WScript.Shell
 
 = @(
 [Environment]::GetFolderPath(Desktop),
 [Environment]::GetFolderPath(CommonDesktopDirectory),
 C:\Users\ender\Desktop,
 C:\Users\ender\OneDrive\Desktop
 ) | Where-Object { [string]::IsNullOrWhiteSpace() -eq False -and (Test-Path ) } | Select-Object -Unique
 
 foreach ( in ) {
 try {
 = .CreateShortcut((Join-Path Orime.lnk))
 .TargetPath = 
 .WorkingDirectory = 
 .Description = Orime Gaming Mode Optimizer
 .IconLocation = ,0
 .Save()
 } catch { }
 }

 = @(
 [Environment]::GetFolderPath(Programs),
 [Environment]::GetFolderPath(CommonPrograms),
 C:\Users\ender\AppData\Roaming\Microsoft\Windows\Start Menu\Programs,
 C:\ProgramData\Microsoft\Windows\Start Menu\Programs
 ) | Where-Object { [string]::IsNullOrWhiteSpace() -eq False -and (Test-Path ) } | Select-Object -Unique

 foreach ( in ) {
 try {
 = .CreateShortcut((Join-Path Orime.lnk))
 .TargetPath = 
 .WorkingDirectory = 
 .Description = Orime Gaming Mode Optimizer
 .IconLocation = ,0
 .Save()
 } catch { }
 }
 
 Write-Host   [OK] Shortcuts updated on Desktop & Start Menu! -ForegroundColor Green
 } catch {
 Write-Host   [!] Shortcut notice:  -ForegroundColor Yellow
 }
} else {
 Write-Host   [!] Warning: Orime.exe not found at  -ForegroundColor Yellow
}

Write-Host 
Write-Host ============================================================ -ForegroundColor Green
Write-Host        ORIME INSTALLED / UPDATED SUCCESSFULLY!               -ForegroundColor Green
Write-Host ============================================================ -ForegroundColor Green
Write-Host 

if ( -and (Test-Path )) {
 Write-Host Launching Orime... -ForegroundColor Cyan
 Start-Process -FilePath 
}
# ============================================================================
#  ORIME - 1-CLICK WEB INSTALLER
# ============================================================================
[CmdletBinding()]
param(
    [string]$DownloadUrl = "",
    [string]$InstallPath = "$env:ProgramFiles\Orime",
    [switch]$LaunchAfterInstall = $true
)

$ErrorActionPreference = "Stop"

Clear-Host
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "                  ORIME - 1-CLICK SETUP                     " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin -and $InstallPath.StartsWith($env:ProgramFiles)) {
    $InstallPath = "$env:LOCALAPPDATA\Programs\Orime"
}

Get-Process -Name "Orime" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Milliseconds 500

Write-Host "[1/3] Fetching Orime package..." -ForegroundColor Yellow
$tempZip = Join-Path $env:TEMP "Orime_Release_v1.0.zip"
if (Test-Path $tempZip) { Remove-Item $tempZip -Force }

$mirrors = @(
    "https://orime.osteup.io.vn/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/releases/download/v1.0/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/releases/latest/download/Orime_v1.0_Portable_x64.zip"
)

if (-not [string]::IsNullOrWhiteSpace($DownloadUrl)) {
    $mirrors = @($DownloadUrl) + $mirrors
}

$downloadSuccess = $false
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

foreach ($url in $mirrors) {
    try {
        Write-Host "  -> Connecting to source: $url" -ForegroundColor DarkGray
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "Orime-Installer")
        $webClient.DownloadFile($url, $tempZip)
        if ((Test-Path $tempZip) -and ((Get-Item $tempZip).Length -gt 1000000)) {
            $downloadSuccess = $true
            Write-Host "  [OK] Downloaded successfully!" -ForegroundColor Green
            break
        }
    } catch {
        try {
            Invoke-WebRequest -Uri $url -OutFile $tempZip -UseBasicParsing -TimeoutSec 20
            if ((Test-Path $tempZip) -and ((Get-Item $tempZip).Length -gt 1000000)) {
                $downloadSuccess = $true
                Write-Host "  [OK] Downloaded successfully!" -ForegroundColor Green
                break
            }
        } catch { }
    }
}

if (-not $downloadSuccess) {
    Write-Host "[ERROR] Could not download Orime package from available mirrors." -ForegroundColor Red
    Write-Host "Please download manually from https://orime.osteup.io.vn or https://github.com/Nahvine/Orime-Release" -ForegroundColor Yellow
    exit 1
}

Write-Host "[2/3] Extracting to $InstallPath..." -ForegroundColor Yellow
if (-not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
}

Expand-Archive -Path $tempZip -DestinationPath $InstallPath -Force
Remove-Item $tempZip -Force -ErrorAction SilentlyContinue

Write-Host "[3/3] Configuring shortcut..." -ForegroundColor Yellow
$targetExe = Join-Path $InstallPath "Orime.exe"
if (Test-Path $targetExe) {
    $wsShell = New-Object -ComObject WScript.Shell
    
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $desktopShortcut = $wsShell.CreateShortcut((Join-Path $desktopPath "Orime Optimizer.lnk"))
    $desktopShortcut.TargetPath = $targetExe
    $desktopShortcut.WorkingDirectory = $InstallPath
    $desktopShortcut.IconLocation = "$targetExe,0"
    $desktopShortcut.Description = "Orime Game Optimizer"
    $desktopShortcut.Save()

    $programsPath = [Environment]::GetFolderPath("Programs")
    $startShortcut = $wsShell.CreateShortcut((Join-Path $programsPath "Orime Optimizer.lnk"))
    $startShortcut.TargetPath = $targetExe
    $startShortcut.WorkingDirectory = $InstallPath
    $startShortcut.IconLocation = "$targetExe,0"
    $startShortcut.Description = "Orime Game Optimizer"
    $startShortcut.Save()
}

Write-Host ""
Write-Host "[OK] Setup completed successfully!" -ForegroundColor Green
Write-Host "Target: $targetExe" -ForegroundColor Gray
Write-Host ""

if ($LaunchAfterInstall -and (Test-Path $targetExe)) {
    Start-Process $targetExe
}

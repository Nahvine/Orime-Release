# ============================================================================
#  ORIME - 1-CLICK WEB INSTALLER / UPDATER
# ============================================================================
$ErrorActionPreference = "Stop"

if (-not (Get-Variable -Name "DownloadUrl" -ErrorAction SilentlyContinue)) {
    $DownloadUrl = ""
}
if (-not (Get-Variable -Name "InstallPath" -ErrorAction SilentlyContinue)) {
    $InstallPath = "$env:ProgramFiles\Orime"
}
if (-not (Get-Variable -Name "LaunchAfterInstall" -ErrorAction SilentlyContinue)) {
    $LaunchAfterInstall = $true
}

Clear-Host
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "             ORIME - 1-CLICK SETUP / UPDATER                " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Check Admin rights & pick fallback user directory if not elevated
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin -and $InstallPath.StartsWith($env:ProgramFiles)) {
    $InstallPath = "$env:LOCALAPPDATA\Programs\Orime"
}

# 1. Gracefully & Forcefully terminate any existing Orime instances
Write-Host "[1/3] Preparing environment..." -ForegroundColor Yellow
$runningOrime = Get-Process -Name "Orime*" -ErrorAction SilentlyContinue
if ($runningOrime) {
    Write-Host "  -> Closing running Orime instances..." -ForegroundColor DarkGray
    $runningOrime | Stop-Process -Force -ErrorAction SilentlyContinue
    $maxWait = 10
    while ((Get-Process -Name "Orime*" -ErrorAction SilentlyContinue) -and ($maxWait -gt 0)) {
        Start-Sleep -Milliseconds 300
        $maxWait--
    }
}

# 2. Download package
Write-Host "[2/3] Fetching Orime package..." -ForegroundColor Yellow
$tempZip = Join-Path $env:TEMP "Orime_Release_v1.0.zip"
if (Test-Path $tempZip) { Remove-Item $tempZip -Force -ErrorAction SilentlyContinue }

$mirrors = @(
    "https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/raw/main/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/releases/latest/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/releases/download/v1.0/Orime_v1.0_Portable_x64.zip",
    "https://orime.osteup.io.vn/download/Orime_v1.0_Portable_x64.zip"
)

if (-not [string]::IsNullOrWhiteSpace($DownloadUrl)) {
    $mirrors = @($DownloadUrl) + $mirrors
}

$downloadSuccess = $false
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

foreach ($url in $mirrors) {
    try {
        Write-Host "  -> Downloading from: $url" -ForegroundColor DarkGray
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Orime-Setup")
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        
        $wc.DownloadFile($url, $tempZip)
        
        if ((Test-Path $tempZip) -and ((Get-Item $tempZip).Length -gt 50000000)) {
            $downloadSuccess = $true
            $sizeMb = [Math]::Round((Get-Item $tempZip).Length / 1MB, 2)
            $sec = [Math]::Max(0.1, [Math]::Round($stopwatch.Elapsed.TotalSeconds, 1))
            $speed = [Math]::Round($sizeMb / $sec, 1)
            Write-Host "  [OK] Downloaded $sizeMb MB in ${sec}s (${speed} MB/s)!" -ForegroundColor Green
            break
        }
    } catch {
        # Fallback to next mirror
    }
}

if (-not $downloadSuccess) {
    Write-Host "[ERROR] Could not download Orime package from available mirrors." -ForegroundColor Red
    Write-Host "Please download manually from https://github.com/Nahvine/Orime-Release" -ForegroundColor Yellow
    exit 1
}

# 3. Extract & Clean Overwrite
Write-Host "[3/3] Installing / Updating Orime to: $InstallPath" -ForegroundColor Yellow

$tempExtract = Join-Path $env:TEMP "Orime_Extract"
if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue }

Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

# Locate root directory containing Orime.exe
$sourceDir = $tempExtract
$rootExe = Join-Path $tempExtract "Orime.exe"
if (-not (Test-Path $rootExe)) {
    $subDirWithExe = Get-ChildItem -Path $tempExtract -Recurse -Filter "Orime.exe" | Select-Object -First 1
    if ($subDirWithExe) {
        $sourceDir = $subDirWithExe.DirectoryName
    }
}

if (-not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
} else {
    Write-Host "  -> Existing version detected. Overwriting and updating files..." -ForegroundColor DarkGray
    Get-ChildItem -Path $InstallPath -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

Copy-Item -Path "$sourceDir\*" -Destination $InstallPath -Recurse -Force

Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue

# 4. Shortcuts Creation / Refresh
$exePath = Join-Path $InstallPath "Orime.exe"
if (Test-Path $exePath) {
    try {
        $WshShell = New-Object -ComObject WScript.Shell
        
        $desktopTargets = @(
            [Environment]::GetFolderPath("Desktop"),
            [Environment]::GetFolderPath("CommonDesktopDirectory"),
            "$env:USERPROFILE\Desktop",
            "$env:USERPROFILE\OneDrive\Desktop"
        ) | Where-Object { [string]::IsNullOrWhiteSpace($_) -eq $false -and (Test-Path $_) } | Select-Object -Unique
        
        foreach ($dPath in $desktopTargets) {
            try {
                $shortcutDesktop = $WshShell.CreateShortcut((Join-Path $dPath "Orime.lnk"))
                $shortcutDesktop.TargetPath = $exePath
                $shortcutDesktop.WorkingDirectory = $InstallPath
                $shortcutDesktop.Description = "Orime Gaming Mode Optimizer"
                $shortcutDesktop.IconLocation = "$exePath,0"
                $shortcutDesktop.Save()
            } catch { }
        }

        $startMenuTargets = @(
            [Environment]::GetFolderPath("Programs"),
            [Environment]::GetFolderPath("CommonPrograms"),
            "$env:APPDATA\Microsoft\Windows\Start Menu\Programs",
            "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
        ) | Where-Object { [string]::IsNullOrWhiteSpace($_) -eq $false -and (Test-Path $_) } | Select-Object -Unique

        foreach ($sPath in $startMenuTargets) {
            try {
                $shortcutStart = $WshShell.CreateShortcut((Join-Path $sPath "Orime.lnk"))
                $shortcutStart.TargetPath = $exePath
                $shortcutStart.WorkingDirectory = $InstallPath
                $shortcutStart.Description = "Orime Gaming Mode Optimizer"
                $shortcutStart.IconLocation = "$exePath,0"
                $shortcutStart.Save()
            } catch { }
        }
        
        Write-Host "  [OK] Shortcuts updated on Desktop & Start Menu!" -ForegroundColor Green
    } catch {
        Write-Host "  [!] Shortcut notice: $($_.Exception.Message)" -ForegroundColor Yellow
    }
} else {
    Write-Host "  [!] Warning: Orime.exe not found at $exePath" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "       ORIME INSTALLED / UPDATED SUCCESSFULLY!              " -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""

if ($LaunchAfterInstall -and (Test-Path $exePath)) {
    Write-Host "Launching Orime..." -ForegroundColor Cyan
    Start-Process -FilePath $exePath
}

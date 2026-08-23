# ============================================================================
#  ORIME - 1-CLICK UNINSTALLER
# ============================================================================
$ErrorActionPreference = "SilentlyContinue"

if (-not (Get-Variable -Name "InstallPath" -ErrorAction SilentlyContinue)) {
    $InstallPath = ""
}
if (-not (Get-Variable -Name "KeepUserData" -ErrorAction SilentlyContinue)) {
    $KeepUserData = $false
}

Clear-Host
Write-Host "============================================================" -ForegroundColor Red
Write-Host "                 ORIME - UNINSTALLER                        " -ForegroundColor Red
Write-Host "============================================================" -ForegroundColor Red
Write-Host ""

# 1. Terminate running processes
Write-Host "[1/4] Stopping running Orime processes..." -ForegroundColor Yellow
$processes = Get-Process -Name "Orime*" -ErrorAction SilentlyContinue
if ($processes) {
    $processes | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Milliseconds 800
}
Write-Host "  [OK] Processes terminated." -ForegroundColor Green

# 2. Remove Shortcuts
Write-Host "[2/4] Removing Desktop & Start Menu shortcuts..." -ForegroundColor Yellow
$shortcutNames = @("Orime.lnk", "Orime Optimizer.lnk", "Orime*.lnk")

$shortcutDirs = @(
    [Environment]::GetFolderPath("Desktop"),
    [Environment]::GetFolderPath("CommonDesktopDirectory"),
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\OneDrive\Desktop",
    "C:\Users\Public\Desktop",
    [Environment]::GetFolderPath("Programs"),
    [Environment]::GetFolderPath("CommonPrograms"),
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
) | Where-Object { [string]::IsNullOrWhiteSpace($_) -eq $false -and (Test-Path $_) } | Select-Object -Unique

foreach ($dir in $shortcutDirs) {
    foreach ($sName in $shortcutNames) {
        $found = Get-ChildItem -Path $dir -Filter $sName -File -ErrorAction SilentlyContinue
        foreach ($f in $found) {
            try {
                Remove-Item -Path $f.FullName -Force -ErrorAction SilentlyContinue
                Write-Host "  -> Removed shortcut: $($f.FullName)" -ForegroundColor DarkGray
            } catch { }
        }
    }
}
Write-Host "  [OK] Shortcuts cleaned." -ForegroundColor Green

# 3. Remove App Directories & MSIX packages
Write-Host "[3/4] Removing Orime application files..." -ForegroundColor Yellow
$knownInstallDirs = @(
    "$env:ProgramFiles\Orime",
    "$env:LOCALAPPDATA\Programs\Orime"
)
if (-not [string]::IsNullOrWhiteSpace($InstallPath)) {
    $knownInstallDirs = @($InstallPath) + $knownInstallDirs
}

foreach ($iDir in ($knownInstallDirs | Select-Object -Unique)) {
    if (Test-Path $iDir) {
        try {
            Remove-Item -Path $iDir -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "  -> Removed directory: $iDir" -ForegroundColor DarkGray
        } catch {
            Write-Host "  [!] Could not fully remove ${iDir}: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
}

# Remove MSIX Package if installed
Get-AppxPackage *31A9A6AA* -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Orime* -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue

Write-Host "  [OK] Application files removed." -ForegroundColor Green

# 4. Clean AppData / User Configuration
Write-Host "[4/4] Cleaning cache & user data..." -ForegroundColor Yellow
if (-not $KeepUserData) {
    $userConfigDir = "$env:LOCALAPPDATA\Orime"
    if (Test-Path $userConfigDir) {
        Remove-Item -Path $userConfigDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  -> Removed user config & cache: $userConfigDir" -ForegroundColor DarkGray
    }
} else {
    Write-Host "  -> User data preserved at: $env:LOCALAPPDATA\Orime" -ForegroundColor DarkGray
}

# Clean Temp files
$tempFiles = Get-ChildItem -Path $env:TEMP -Filter "Orime_*" -Recurse -ErrorAction SilentlyContinue
foreach ($tf in $tempFiles) {
    Remove-Item -Path $tf.FullName -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "        ORIME HAS BEEN UNINSTALLED SUCCESSFULLY!            " -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""

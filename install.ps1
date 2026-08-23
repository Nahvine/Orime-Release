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
    "https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/raw/main/download/Orime_v1.0_Portable_x64.zip",
    "https://cdn.jsdelivr.net/gh/Nahvine/Orime-Release@main/download/Orime_v1.0_Portable_x64.zip",
    "https://orime.osteup.io.vn/download/Orime_v1.0_Portable_x64.zip",
    "https://github.com/Nahvine/Orime-Release/releases/download/v1.0/Orime_v1.0_Portable_x64.zip"
)

if (-not [string]::IsNullOrWhiteSpace($DownloadUrl)) {
    $mirrors = @($DownloadUrl) + $mirrors
}

$downloadSuccess = $false
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

foreach ($url in $mirrors) {
    $fileStream = $null
    $responseStream = $null
    $response = $null
    try {
        Write-Host "  -> Connecting to source: $url" -ForegroundColor DarkGray
        
        $request = [System.Net.HttpWebRequest]::Create($url)
        $request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Orime-Setup"
        $request.Timeout = 600000
        $request.ReadWriteTimeout = 600000
        $request.AllowAutoRedirect = $true
        $request.Method = "GET"
        
        $response = $request.GetResponse()
        $totalBytes = $response.ContentLength
        if ($totalBytes -le 0) { $totalBytes = 88435180 }
        $totalMb = [Math]::Round($totalBytes / 1MB, 1)
        
        $responseStream = $response.GetResponseStream()
        $fileStream = [System.IO.File]::Create($tempZip)
        $buffer = New-Object byte[] 65536
        $downloadedBytes = 0
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $lastUpdate = [System.DateTime]::MinValue
        
        while (($read = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
            $fileStream.Write($buffer, 0, $read)
            $downloadedBytes += $read
            
            $now = [System.DateTime]::Now
            if (($now - $lastUpdate).TotalMilliseconds -ge 100 -or $downloadedBytes -ge $totalBytes) {
                $lastUpdate = $now
                $elapsedSec = [Math]::Max(0.01, $stopwatch.Elapsed.TotalSeconds)
                $speedMbSec = [Math]::Round(($downloadedBytes / 1MB) / $elapsedSec, 1)
                $currMb = [Math]::Round($downloadedBytes / 1MB, 1)
                
                $percent = [Math]::Min(100, [int](($downloadedBytes / $totalBytes) * 100))
                $barWidth = 24
                $completed = [int](($percent / 100) * $barWidth)
                $remaining = [Math]::Max(0, $barWidth - $completed)
                $bar = ("=" * [Math]::Max(0, $completed - 1)) + (if ($completed -gt 0) { ">" } else { "" }) + (" " * $remaining)
                Write-Host -NoNewline "`r  [$bar] $percent% ($currMb MB / $totalMb MB) @ $speedMbSec MB/s    "
            }
        }
        
        $fileStream.Flush()
        $fileStream.Close()
        $responseStream.Close()
        $response.Close()
        Write-Host ""
        
        if ((Test-Path $tempZip) -and ((Get-Item $tempZip).Length -gt 1000000)) {
            $downloadSuccess = $true
            Write-Host "  [OK] Download completed successfully! ($([Math]::Round((Get-Item $tempZip).Length / 1MB, 2)) MB in $([Math]::Round($stopwatch.Elapsed.TotalSeconds, 1))s)" -ForegroundColor Green
            break
        }
    } catch {
        if ($fileStream) { $fileStream.Close() }
        if ($responseStream) { $responseStream.Close() }
        if ($response) { $response.Close() }
    }
}

if (-not $downloadSuccess) {
    Write-Host "[ERROR] Could not download Orime package from available mirrors." -ForegroundColor Red
    Write-Host "Please download manually from https://github.com/Nahvine/Orime-Release" -ForegroundColor Yellow
    exit 1
}

Write-Host "[2/3] Installing Orime to: $InstallPath" -ForegroundColor Yellow
if (-not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
}

$tempExtract = Join-Path $env:TEMP "Orime_Extract"
if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue }

Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

# Extract handling: copy all files cleanly ensuring Orime.exe is at the root of $InstallPath
$rootExe = Join-Path $tempExtract "Orime.exe"
if (Test-Path $rootExe) {
    Copy-Item -Path "$tempExtract\*" -Destination $InstallPath -Recurse -Force
} else {
    $subDirWithExe = Get-ChildItem -Path $tempExtract -Recurse -Filter "Orime.exe" | Select-Object -First 1
    if ($subDirWithExe) {
        $parent = $subDirWithExe.DirectoryName
        Copy-Item -Path "$parent\*" -Destination $InstallPath -Recurse -Force
    } else {
        Copy-Item -Path "$tempExtract\*" -Destination $InstallPath -Recurse -Force
    }
}

Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "[3/3] Creating shortcuts..." -ForegroundColor Yellow
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
                Write-Host "  -> Desktop shortcut: $dPath\Orime.lnk" -ForegroundColor DarkGray
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
        
        Write-Host "  [OK] Shortcuts created on Desktop & Start Menu!" -ForegroundColor Green
    } catch {
        Write-Host "  [!] Shortcut notice: $($_.Exception.Message)" -ForegroundColor Yellow
    }
} else {
    Write-Host "  [!] Warning: Orime.exe not found at $exePath" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "            ORIME INSTALLED SUCCESSFULLY!                   " -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""

if ($LaunchAfterInstall -and (Test-Path $exePath)) {
    Write-Host "Launching Orime..." -ForegroundColor Cyan
    Start-Process -FilePath $exePath
}

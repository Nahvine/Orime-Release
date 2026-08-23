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
        $request.UserAgent = "Orime-Setup"
        $request.Timeout = 20000
        $request.Method = "GET"
        
        $response = $request.GetResponse()
        $totalBytes = $response.ContentLength
        $totalMb = [Math]::Round($totalBytes / 1MB, 2)
        
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
            if (($now - $lastUpdate).TotalMilliseconds -ge 120 -or $downloadedBytes -ge $totalBytes) {
                $lastUpdate = $now
                $elapsedSec = [Math]::Max(0.01, $stopwatch.Elapsed.TotalSeconds)
                $speedMbSec = [Math]::Round(($downloadedBytes / 1MB) / $elapsedSec, 2)
                $currMb = [Math]::Round($downloadedBytes / 1MB, 2)
                
                if ($totalBytes -gt 0) {
                    $percent = [Math]::Min(100, [int](($downloadedBytes / $totalBytes) * 100))
                    $barWidth = 24
                    $completed = [int](($percent / 100) * $barWidth)
                    $remaining = $barWidth - $completed
                    $bar = ("=" * [Math]::Max(0, $completed - 1)) + (if ($completed -gt 0) { ">" } else { "" }) + (" " * $remaining)
                    Write-Host -NoNewline "`r  [$bar] $percent% ($currMb MB / $totalMb MB) @ $speedMbSec MB/s    "
                } else {
                    Write-Host -NoNewline "`r  [Downloading...] $currMb MB @ $speedMbSec MB/s    "
                }
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
if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force }
Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

$extractedDir = Get-ChildItem -Path $tempExtract -Directory | Select-Object -First 1
if ($extractedDir) {
    Copy-Item -Path "$($extractedDir.FullName)\*" -Destination $InstallPath -Recurse -Force
} else {
    Copy-Item -Path "$tempExtract\*" -Destination $InstallPath -Recurse -Force
}

Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "[3/3] Creating shortcuts..." -ForegroundColor Yellow
$exePath = Join-Path $InstallPath "Orime.exe"
if (Test-Path $exePath) {
    $WshShell = New-Object -ComObject WScript.Shell
    
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $shortcutDesktop = $WshShell.CreateShortcut((Join-Path $desktopPath "Orime.lnk"))
    $shortcutDesktop.TargetPath = $exePath
    $shortcutDesktop.WorkingDirectory = $InstallPath
    $shortcutDesktop.Description = "Orime Gaming Mode Optimizer"
    $shortcutDesktop.Save()

    $startMenuPath = [Environment]::GetFolderPath("Programs")
    $shortcutStart = $WshShell.CreateShortcut((Join-Path $startMenuPath "Orime.lnk"))
    $shortcutStart.TargetPath = $exePath
    $shortcutStart.WorkingDirectory = $InstallPath
    $shortcutStart.Description = "Orime Gaming Mode Optimizer"
    $shortcutStart.Save()
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

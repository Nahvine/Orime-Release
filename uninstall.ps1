# ============================================================================
#  ORIME - 1-CLICK UNINSTALLER
# ============================================================================
[CmdletBinding()]
param(
    [string] = ",
 [switch] = False
)

Continue = SilentlyContinue

Clear-Host
Write-Host ============================================================ -ForegroundColor Red
Write-Host                  ORIME - UNINSTALLER                         -ForegroundColor Red
Write-Host ============================================================ -ForegroundColor Red
Write-Host 

# 1. Terminate running processes
Write-Host [1/4] Stopping running Orime processes... -ForegroundColor Yellow
 = Get-Process -Name Orime* -ErrorAction SilentlyContinue
if () {
 | Stop-Process -Force -ErrorAction SilentlyContinue
 Start-Sleep -Milliseconds 800
}
Write-Host   [OK] Processes terminated. -ForegroundColor Green

# 2. Remove Shortcuts
Write-Host [2/4] Removing Desktop & Start Menu shortcuts... -ForegroundColor Yellow
 = @(Orime.lnk, Orime Optimizer.lnk, Orime*.lnk)

 = @(
 [Environment]::GetFolderPath(Desktop),
 [Environment]::GetFolderPath(CommonDesktopDirectory),
 C:\Users\ender\Desktop,
 C:\Users\ender\OneDrive\Desktop,
 C:\Users\Public\Desktop,
 [Environment]::GetFolderPath(Programs),
 [Environment]::GetFolderPath(CommonPrograms),
 C:\Users\ender\AppData\Roaming\Microsoft\Windows\Start Menu\Programs,
 C:\ProgramData\Microsoft\Windows\Start Menu\Programs
) | Where-Object { [string]::IsNullOrWhiteSpace() -eq False -and (Test-Path ) } | Select-Object -Unique

foreach ( in ) {
 foreach ( in ) {
 = Get-ChildItem -Path -Filter -File -ErrorAction SilentlyContinue
 foreach ( in ) {
 try {
 Remove-Item -Path .FullName -Force -ErrorAction SilentlyContinue
 Write-Host   -> Removed shortcut:  -ForegroundColor DarkGray
 } catch { }
 }
 }
}
Write-Host   [OK] Shortcuts cleaned. -ForegroundColor Green

# 3. Remove App Directories & MSIX packages
Write-Host [3/4] Removing Orime application files... -ForegroundColor Yellow
 = @(
 C:\Program Files\Orime,
 C:\Users\ender\AppData\Local\Programs\Orime
)
if (-not [string]::IsNullOrWhiteSpace()) {
 = @() + 
}

foreach ( in ( | Select-Object -Unique)) {
 if (Test-Path ) {
 try {
 Remove-Item -Path -Recurse -Force -ErrorAction SilentlyContinue
 Write-Host   -> Removed directory:  -ForegroundColor DarkGray
 } catch {
 Write-Host   [!] Could not fully remove  (might require Admin):  -ForegroundColor Yellow
 }
 }
}

# Remove MSIX Package if installed
Get-AppxPackage *31A9A6AA* -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Orime* -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue

Write-Host   [OK] Application files removed. -ForegroundColor Green

# 4. Clean AppData / User Configuration
Write-Host [4/4] Cleaning cache & user data... -ForegroundColor Yellow
if (-not ) {
 = C:\Users\ender\AppData\Local\Orime
 if (Test-Path ) {
 Remove-Item -Path -Recurse -Force -ErrorAction SilentlyContinue
 Write-Host   -> Removed user config & license cache:  -ForegroundColor DarkGray
 }
} else {
 Write-Host   -> User data preserved at: C:\Users\ender\AppData\Local\Orime -ForegroundColor DarkGray
}

# Clean Temp files
 = Get-ChildItem -Path C:\Users\ender\AppData\Local\Temp -Filter Orime_* -Recurse -ErrorAction SilentlyContinue
foreach ( in ) {
 Remove-Item -Path .FullName -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host 
Write-Host ============================================================ -ForegroundColor Green
Write-Host         ORIME HAS BEEN UNINSTALLED SUCCESSFULLY!             -ForegroundColor Green
Write-Host ============================================================ -ForegroundColor Green
Write-Host 
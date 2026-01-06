# Flutter Build Progress Checker
# Run this script to check build progress

Write-Host "=== Flutter Build Progress Checker ===" -ForegroundColor Cyan
Write-Host ""

# Check if build directory exists
if (Test-Path "build\app") {
    Write-Host "✅ Build directory exists" -ForegroundColor Green
    
    # Count build files
    $fileCount = (Get-ChildItem "build\app" -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "   Build files: $fileCount" -ForegroundColor Yellow
    
    # Check for APK
    if (Test-Path "build\app\outputs\flutter-apk\app-debug.apk") {
        $apkSize = [math]::Round((Get-Item "build\app\outputs\flutter-apk\app-debug.apk").Length / 1MB, 2)
        Write-Host "✅ APK built successfully! Size: $apkSize MB" -ForegroundColor Green
    } else {
        Write-Host "⏳ APK not ready yet - build in progress..." -ForegroundColor Yellow
    }
    
    # Check for Gradle build
    if (Test-Path "build\app\intermediates") {
        Write-Host "✅ Gradle build in progress" -ForegroundColor Green
    }
} else {
    Write-Host "⏳ Build not started yet" -ForegroundColor Yellow
}

# Check running processes
Write-Host ""
Write-Host "=== Running Processes ===" -ForegroundColor Cyan
$flutterProcesses = Get-Process | Where-Object {$_.ProcessName -like "*flutter*" -or $_.ProcessName -like "*dart*" -or $_.ProcessName -like "*gradle*"} -ErrorAction SilentlyContinue
if ($flutterProcesses) {
    $flutterProcesses | ForEach-Object {
        Write-Host "  $($_.ProcessName) (PID: $($_.Id))" -ForegroundColor Green
    }
} else {
    Write-Host "  No Flutter/Gradle processes running" -ForegroundColor Yellow
}

# Check emulator status
Write-Host ""
Write-Host "=== Emulator Status ===" -ForegroundColor Cyan
flutter devices 2>&1 | Select-String "emulator"

Write-Host ""
Write-Host "=== To see real-time build output, run: ===" -ForegroundColor Cyan
Write-Host "flutter run -d emulator-5554" -ForegroundColor Yellow


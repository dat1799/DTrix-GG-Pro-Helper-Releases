$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12 -bor [System.Net.SecurityProtocolType]::Tls13
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "DTrix - Google AI Pro (5 TB) Auto 24 Months"

Write-Host ""
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host "   DTRIX - GOOGLE AI PRO (5 TB) - TỰ ĐỘNG NHẬN 24 THÁNG TRỌN GÓI ($0.00)" -ForegroundColor Green
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host ""

$AppDir = Join-Path $env:TEMP "DTrix-GG-Pro-Helper"
if (-not (Test-Path $AppDir)) {
    New-Item -ItemType Directory -Path $AppDir -Force | Out-Null
}

$ExePath = Join-Path $AppDir "DTrix-Helper.exe"

# Đường dẫn tải DTrix-Helper.exe chính thức từ kho Public Releases
$RawUrl = "https://raw.githubusercontent.com/dat1799/DTrix-GG-Pro-Helper-Releases/main/DTrix-Helper.exe"
$ReleaseUrl = "https://github.com/dat1799/DTrix-GG-Pro-Helper-Releases/releases/download/v1.0.0/DTrix-Helper.exe"

Write-Host "▶ Đang khởi động hệ thống, vui lòng chờ trong giây lát..." -ForegroundColor Yellow

$downloaded = $false
try {
    Invoke-WebRequest -Uri $RawUrl -OutFile $ExePath -UseBasicParsing
    $downloaded = $true
} catch {
    try {
        Invoke-WebRequest -Uri $ReleaseUrl -OutFile $ExePath -UseBasicParsing
        $downloaded = $true
    } catch {
        Write-Host "❌ Không thể kết nối đến máy chủ. Vui lòng kiểm tra lại kết nối mạng!" -ForegroundColor Red
        return
    }
}

if (-not (Test-Path $ExePath) -or (Get-Item $ExePath).Length -lt 10MB) {
    Write-Host "❌ Quá trình chuẩn bị thất bại. Vui lòng thử lại!" -ForegroundColor Red
    return
}

try {
    & $ExePath
} finally {
    Write-Host "`n🧹 Đang tự động dọn dẹp hệ thống..." -ForegroundColor Gray
    Start-Sleep -Milliseconds 800
    if (Test-Path $AppDir) {
        Remove-Item -Recurse -Force $AppDir -ErrorAction SilentlyContinue
    }
    Write-Host "✨ Hoàn tất! Đã tự động dọn dẹp sạch sẽ toàn bộ file trên máy." -ForegroundColor Green
}

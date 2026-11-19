# ================================================================================
#  GOOGLE AI PRO (5 TB) - ALL-IN-ONE ONE-LINER LAUNCHER (irm | iex)
#  Usage: irm https://raw.githubusercontent.com/dat1799/DTrix-GG-Pro-Helper-Releases/main/run.ps1 | iex
# ================================================================================

$ErrorActionPreference = "Stop"
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

Write-Host "▶ Đang tải trình kích hoạt tự động (DTrix-Helper.exe)..." -ForegroundColor Yellow
Write-Host "   (Dung lượng ~48 MB, mã hóa nhị phân C native, không cần cài Python/Node.js)" -ForegroundColor Gray

$downloaded = $false
try {
    Write-Host "   Đang tải từ GitHub..." -ForegroundColor Gray
    Invoke-WebRequest -Uri $RawUrl -OutFile $ExePath -UseBasicParsing
    $downloaded = $true
} catch {
    try {
        Write-Host "   Thử tải từ Release fallback..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $ReleaseUrl -OutFile $ExePath -UseBasicParsing
        $downloaded = $true
    } catch {
        Write-Host "❌ Không thể tải file từ GitHub. Lỗi: $_" -ForegroundColor Red
        return
    }
}

if (-not (Test-Path $ExePath) -or (Get-Item $ExePath).Length -lt 10MB) {
    Write-Host "❌ File tải về không hợp lệ. Vui lòng kiểm tra lại kết nối mạng hoặc thử lại!" -ForegroundColor Red
    return
}
Write-Host "✅ Tải thành công!" -ForegroundColor Green

Write-Host "`n🚀 Đang khởi chạy DTrix-Helper..." -ForegroundColor Cyan

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

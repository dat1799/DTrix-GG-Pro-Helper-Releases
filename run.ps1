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

$AppDir = "$env:LOCALAPPDATA\DTrix-GG-Pro-Helper"
if (-not (Test-Path $AppDir)) {
    New-Item -ItemType Directory -Path $AppDir -Force | Out-Null
}

$ExePath = Join-Path $AppDir "DTrix-Helper.exe"

# Đường dẫn tải DTrix-Helper.exe chính thức từ kho Public Releases
$RawUrl = "https://raw.githubusercontent.com/dat1799/DTrix-GG-Pro-Helper-Releases/main/DTrix-Helper.exe"
$ReleaseUrl = "https://github.com/dat1799/DTrix-GG-Pro-Helper-Releases/releases/download/v1.0.0/DTrix-Helper.exe"

$NeedDownload = $true
if (Test-Path $ExePath) {
    $item = Get-Item $ExePath
    if ($item.Length -gt 40MB) {
        $NeedDownload = $false
        Write-Host "✅ Đã tìm thấy DTrix-Helper sẵn sàng trong máy." -ForegroundColor Green
    }
}

if ($NeedDownload) {
    Write-Host "▶ Đang tải trình kích hoạt tự động (DTrix-Helper.exe)..." -ForegroundColor Yellow
    Write-Host "   (Dung lượng ~48 MB, mã hóa nhị phân C native, không cần cài Python/Node.js)" -ForegroundColor Gray
    
    $downloaded = $false
    try {
        Write-Host "   Đang tải từ GitHub Releases..." -ForegroundColor Gray
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
}

Write-Host "`n🚀 Đang khởi chạy DTrix-Helper..." -ForegroundColor Cyan
& $ExePath

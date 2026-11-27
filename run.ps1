$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12 -bor [System.Net.SecurityProtocolType]::Tls13
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "DTrix - Google AI Pro / Ultra Helper"

Write-Host ""
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host "   DTRIX - GOOGLE AI PRO (5 TB) / ULTRA (20/30 TB) - TỰ ĐỘNG ($0.00)" -ForegroundColor Green
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host ""

$AppDir = Join-Path $env:TEMP "DTrix-GG-Pro-Helper"
if (-not (Test-Path $AppDir)) {
    New-Item -ItemType Directory -Path $AppDir -Force | Out-Null
}

$ExePath = Join-Path $AppDir "DTrix-Helper.exe"

$CacheBuster = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$RawUrl = "https://raw.githubusercontent.com/dat1799/DTrix-GG-Pro-Helper-Releases/main/DTrix-Helper.exe?t=$CacheBuster"
$ReleaseUrl = "https://github.com/dat1799/DTrix-GG-Pro-Helper-Releases/releases/download/v1.0.0/DTrix-Helper.exe"

function Download-HelperFile {
    param([string]$Url, [string]$OutPath)
    $req = [System.Net.HttpWebRequest]::Create($Url)
    $req.Timeout = 180000
    $req.ReadWriteTimeout = 30000
    $req.UserAgent = "DTrix-Helper-Launcher"
    $resp = $req.GetResponse()
    try {
        $total = $resp.ContentLength
        $inStream = $resp.GetResponseStream()
        $outStream = [System.IO.File]::Create($OutPath)
        try {
            $buf = New-Object byte[] 65536
            $readTotal = 0L
            $lastPct = -1
            while (($n = $inStream.Read($buf, 0, $buf.Length)) -gt 0) {
                $outStream.Write($buf, 0, $n)
                $readTotal += $n
                if ($total -gt 0) {
                    $pct = [int][Math]::Floor(($readTotal * 100.0) / $total)
                    if ($pct -ne $lastPct) {
                        $lastPct = $pct
                        Write-Host -NoNewline ("`r▶ Đang khởi động hệ thống, vui lòng chờ trong giây lát... {0,3}%   " -f $pct) -ForegroundColor Yellow
                    }
                }
            }
            Write-Host ""
        } finally {
            $outStream.Dispose()
            $inStream.Dispose()
        }
    } finally {
        $resp.Dispose()
    }
}

Write-Host -NoNewline "▶ Đang khởi động hệ thống, vui lòng chờ trong giây lát..." -ForegroundColor Yellow

$downloaded = $false
try {
    Download-HelperFile -Url $RawUrl -OutPath $ExePath
    $downloaded = $true
} catch {
    Write-Host "`n⚠️  Kết nối chính chậm hoặc gián đoạn, đang thử đường truyền dự phòng..." -ForegroundColor Yellow
    try {
        Download-HelperFile -Url $ReleaseUrl -OutPath $ExePath
        $downloaded = $true
    } catch {
        Write-Host "❌ Không thể kết nối hoặc tải xuống bị quá thời gian: $($_.Exception.Message)" -ForegroundColor Red
        return
    }
}

if (-not (Test-Path $ExePath) -or (Get-Item $ExePath).Length -lt 10MB) {
    Write-Host "❌ Quá trình chuẩn bị thất bại. Vui lòng thử lại!" -ForegroundColor Red
    return
}

Write-Host "▶ Đang khởi chạy..." -ForegroundColor Green
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

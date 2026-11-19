@echo off
setlocal
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONIOENCODING=utf-8

echo.
echo =========================================================================
echo   GOOGLE AI PRO (5 TB) - TỰ ĐỘNG CHẠY TRỌN GÓI 24 THÁNG (ALL-IN-ONE)
echo =========================================================================
echo.

if exist "DTrix-Helper.exe" (
    echo [*] Đang khởi chạy DTrix-Helper đã mã hóa nhị phân...
    DTrix-Helper.exe
    set "STATUS=%ERRORLEVEL%"
    goto :done
)

if exist "dist\DTrix-Helper.exe" (
    echo [*] Đang khởi chạy dist\DTrix-Helper.exe...
    dist\DTrix-Helper.exe
    set "STATUS=%ERRORLEVEL%"
    goto :done
)

where py >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PYTHON_EXE=py"
) else (
    where python >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        set "PYTHON_EXE=python"
    ) else (
        echo [ERROR] Không tìm thấy Python trong hệ thống. Vui lòng cài đặt Python 3.10 trở lên!
        pause
        exit /b 1
    )
)

if not exist "emulator\.venv\Scripts\python.exe" (
    echo [*] Môi trường chưa khởi tạo, đang tự động thiết lập Frida và công cụ...
    cd emulator
    %PYTHON_EXE% setup_env.py
    cd ..
)

echo [*] Khởi động trình tự động xếp chồng gói 24 tháng...
cd emulator
.venv\Scripts\python.exe auto_stack.py
set "STATUS=%ERRORLEVEL%"
cd ..

:done
echo.
pause
exit /b %STATUS%

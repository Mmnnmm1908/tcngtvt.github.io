@echo off
setlocal enabledelayedexpansion
echo =======================================================
echo    CONG TAC DIEU KHIEN CAP NHAT PHAN XA TUC THI 100%%
echo =======================================================
echo.

set "status_file=status.json"

if not exist !status_file! (
    echo {"status": "ON"} > !status_file!
)

findstr /C:"\"status\": \"OFF\"" !status_file! >nul
if !errorlevel! equ 0 (
    echo [!] TRANG WEB DANG BI KHOA TRA CUU.
    echo [+] PHAN XA TUC THI: KICH HOAT MO TRA CUU LAI...
    echo {"status": "ON"} > !status_file!
    set "msg=DA MO CANG TRA CUU LAI TRON TRU"
) else (
    echo [!] TRANG WEB DANG MO TRA CUU.
    echo [+] PHAN XA TUC THI: TINH NANG TRA CUU SE BI KHOA CHAT LAP TUC...
    echo {"status": "OFF"} > !status_file!
    set "msg=DA KHOA CANG TRA CUU"
)
echo.

echo [+] Dang dong goi va ep day len internet trong 3 giay...
rmdir /s /q .git >nul 2>&1
git init >nul 2>&1
git add --all >nul 2>&1
git commit -m "Cap nhat trang thai bat tat he thong" >nul 2>&1
git branch -M main >nul 2>&1
git push -f https://github.com/tracuuqr/tcngtvt.github.io main >nul 2>&1

echo =======================================================
echo    HOAN THANH! %msg% AN TOAN 100%%.
echo =======================================================
echo.
pause

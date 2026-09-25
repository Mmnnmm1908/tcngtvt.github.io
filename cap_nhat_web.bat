@echo off
echo =======================================================
echo    HE THONG CAP NHAT WEB TU DONG TOAN DIEN (1-CLICK)
echo =======================================================
echo.

echo STEP 1: Dang chay Python trich xuat anh Excel thang moi...
python create_json.py
echo.

echo STEP 2: Tu dong pha xoa cau hinh ket cu de lam sach he thong...
rmdir /s /q .git
echo.

echo STEP 3: Khoi tao lai kho luu tru Git moi tinh...
git init
echo.

echo STEP 4: Gom bat buoc toan bo code va anh moi tinh...
git add --all
echo.

echo STEP 5: Dong goi phien ban hoan hao...
git commit -m "Tu dong cap nhat dong bo toan dien chu va anh"
echo.

echo STEP 6: Doi ten nhanh mac dinh thanh main...
git branch -M main
echo.

echo STEP 7: Ep day du lieu len dung dia chi tai khoan tracuuqr...
git push -f https://github.com/tracuuqr/tcngtvt.github.io main
echo.

echo =======================================================
echo    HOAN THANH! TRANG WEB DA ONLINE BAN MOI CO NHAC NHO.
echo =======================================================
echo.
pause

import os
import zipfile
import openpyxl

excel_file = 'qr.20.08.xlsx'
output_dir = 'anh-qr'

if not os.path.exists(excel_file):
    print(f"Loi: Khong tim thay file '{excel_file}' trong thu muc!")
else:
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # 1. Đọc số CCCD để làm tên file tương ứng với từng hàng
    wb = openpyxl.load_workbook(excel_file, data_only=True)
    sheet = wb.active

    # Tự động dò cột chứa CCCD
    cccd_col_idx = 4 # Mặc định cột D
    for col in range(1, sheet.max_column + 1):
        header_val = str(sheet.cell(row=1, column=col).value or '').lower()
        if 'căn cước' in header_val or 'cccd' in header_val:
            cccd_col_idx = col
            break

    cccd_list = []
    for row in range(2, sheet.max_row + 1):
        cell_val = sheet.cell(row=row, column=cccd_col_idx).value
        if cell_val is not None:
            cccd_list.append(str(cell_val).strip())

    print("-> Dang giai nen va trich xuat anh QR tu loi file Excel...")
    
    # 2. Mở file Excel như một file Zip để lấy toàn bộ ảnh gốc ra ngoài
    img_index = 0
    with zipfile.ZipFile(excel_file, 'r') as z:
        # Tìm tất cả file ảnh nằm trong file Excel
        image_files = [f for f in z.namelist() if f.startswith('xl/media/')]
        # Sắp xếp theo thứ tự xuất hiện từ trên xuống dưới
        image_files.sort()

        for img_file in image_files:
            if img_index < len(cccd_list):
                cccd_name = cccd_list[img_index]
                # Đọc dữ liệu ảnh thô
                img_data = z.read(img_file)
                
                # Lưu ảnh ra thư mục anh-qr lấy số CCCD tương ứng làm tên
                output_path = os.path.join(output_dir, f"{cccd_name}.png")
                with open(output_path, 'wb') as f:
                    f.write(img_data)
                
                print(f"-> Da trich xuat anh cho CCCD: {cccd_name}.png")
                img_index += 1

    print(f"\n==> HOAN THANH! Da lay xong {img_index} anh QR vao thu muc '{output_dir}'.")

-- =========================================================================
-- สคริปต์ตั้งค่าตารางบนฐานข้อมูล Supabase สำหรับระบบขอบาร์โค้ด
-- คำแนะนำ: นำโค้ดทั้งหมดนี้ไปรันในเมนู "SQL Editor" ของแผงควบคุม Supabase
-- =========================================================================

-- 1. สร้างตารางเก็บรายการสินค้า (Products Table)
create table public.products (
  no text not null primary key,
  no2 text,
  description text not null,
  brand text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. ใส่คำอธิบายคอลัมน์ (Comments)
comment on table public.products is 'ตารางเก็บข้อมูลสินค้าสำหรับระบบขอบาร์โค้ด';
comment on column public.products.no is 'รหัสบาร์โค้ดหลัก';
comment on column public.products.no2 is 'รหัสบาร์โค้ดเก่า (เก่า)';
comment on column public.products.description is 'ชื่อรุ่น หรือ รายละเอียดสินค้า';
comment on column public.products.brand is 'ยี่ห้อ/แบรนด์สินค้า';

-- 3. เปิดการรักษาความปลอดภัยระดับแถวข้อมูล (Enable Row Level Security)
alter table public.products enable row level security;

-- 4. สร้างนโยบายการเข้าถึงข้อมูล (Security Policies)
-- กำหนดให้ผู้เข้าใช้งานหน้าเว็บ (สิทธิ์ anon) สามารถ "อ่าน/ค้นหา" ข้อมูลสินค้าได้เท่านั้น (Read-Only)
create policy "Allow public read access to products" on public.products
  for select
  to anon
  using (true);

-- 5. เพิ่มข้อมูลตัวอย่างเพื่อการทดสอบ (Optional Sample Data)
insert into public.products (no, no2, description, brand) values
('P001', '10023', 'สินค้าตัวอย่างชิ้นที่ 1', 'Brand A'),
('P002', '10024', 'สินค้าตัวอย่างชิ้นที่ 2 ขนาดใหญ่', 'Brand B'),
('P003', '20015', 'สายชาร์จ Type-C ความยาว 1 เมตร', 'Brand C'),
('P004', '20016', 'หัวชาร์จ USB-C Fast Charge 30W', 'Brand C')
on conflict (no) do nothing;

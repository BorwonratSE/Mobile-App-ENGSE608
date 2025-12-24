<img width="450" height="500" alt="image" src="https://github.com/user-attachments/assets/fd5e11f7-46e0-49a7-9395-0ae3d0c19ec9" />



โครงสร้างคลาส

1️⃣ คลาสแม่: Product

คลาส Product ใช้เป็นโครงสร้างพื้นฐานของสินค้า ประกอบด้วย

คุณสมบัติ (Properties)

_id : รหัสสินค้า (private)

name : ชื่อสินค้า

_price : ราคาสินค้า (private)

stock : จำนวนสินค้าในสต็อก (nullable)

Constructor

ใช้สำหรับสร้างสินค้าใหม่

แสดงข้อความเมื่อมีการสร้างสินค้า

Getter / Setter

id : อ่านค่า id ได้อย่างเดียว

price : อ่านราคาได้

price= : ตั้งค่าราคาใหม่ (ป้องกันค่าที่ ≤ 0)

Methods

applyDiscount(percent) : ลดราคาตามเปอร์เซ็นต์

restock(amount) : เพิ่มจำนวนสินค้าในสต็อก

showInfo() : แสดงข้อมูลสินค้าพื้นฐาน

2️⃣ คลาสลูก: DigitalProduct

สืบทอดจาก Product ใช้สำหรับสินค้าแบบดิจิทัล

คุณสมบัติเพิ่มเติม

fileSizeMB : ขนาดไฟล์ (MB)

การ Override

showInfo() : แสดงข้อมูลสินค้าพื้นฐาน + ข้อมูลไฟล์ดิจิทัล

3️⃣ คลาสลูก: FoodProduct

สืบทอดจาก Product ใช้สำหรับสินค้าอาหาร

คุณสมบัติเพิ่มเติม

expireDate : วันหมดอายุ

การ Override

showInfo() : แสดงข้อมูลสินค้าพื้นฐาน + วันหมดอายุ

▶️ การทำงานใน main()

สร้างสินค้า 3 ประเภท

สินค้าทั่วไป (Product)

สินค้าดิจิทัล (DigitalProduct)

สินค้าอาหาร (FoodProduct)

ทดลองเรียกใช้งาน Method

ลดราคา

เพิ่มสต็อก

ทดลองตั้งราคาที่ไม่ถูกต้อง (ระบบจะป้องกัน)

ใช้ Polymorphism

เก็บวัตถุทุกชนิดใน List<Product>

เรียก showInfo() โดยไม่ต้องสนใจชนิดจริงของสินค้า

ระบบจะเรียก method ที่เหมาะสมของแต่ละคลาสอัตโนมัติ

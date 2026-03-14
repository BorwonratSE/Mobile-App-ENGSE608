# Community Market App

## ชื่อโครงงาน

Community Market Application

## ผู้จัดทำ

Borwonrat Sirimueang

---

# บทนำ

Community Market App เป็นแอปพลิเคชันที่พัฒนาด้วย **Flutter** สำหรับจัดการรายการสินค้าในตลาดชุมชน โดยผู้ใช้สามารถเพิ่ม ลบ และแสดงรายการสินค้าได้ภายในแอป พร้อมทั้งสามารถเลือกรูปภาพของสินค้าและบันทึกข้อมูลลงในฐานข้อมูล **SQLite**

แอปนี้ถูกออกแบบเพื่อฝึกการพัฒนา Mobile Application ด้วย Flutter และการจัดการฐานข้อมูลภายในเครื่อง

---

# วัตถุประสงค์ของโครงงาน

1. เพื่อศึกษาและพัฒนา Mobile Application ด้วย Flutter
2. เพื่อเรียนรู้การใช้ฐานข้อมูล SQLite ภายในแอปพลิเคชัน
3. เพื่อฝึกการใช้ State Management ด้วย Provider
4. เพื่อพัฒนาระบบเพิ่ม ลบ และแสดงรายการสินค้า

---

# เครื่องมือและเทคโนโลยีที่ใช้

* Flutter
* Dart
* SQLite (sqflite)
* Provider (State Management)
* Image Picker

---

# โครงสร้างโปรเจค

```
lib/
│
├── database/
│   └── database_helper.dart
│
├── models/
│   └── product.dart
│
├── providers/
│   └── product_provider.dart
│
├── screens/
│   └── home_page.dart
│
├── widgets/
│   └── product_tile.dart
│
└── main.dart
```

---

# ฟังก์ชันการทำงานของระบบ

### 1. เพิ่มสินค้า (Add Product)

ผู้ใช้สามารถเพิ่มสินค้าโดยกรอก

* ชื่อสินค้า
* ราคา
* รูปภาพสินค้า

ข้อมูลจะถูกบันทึกลงในฐานข้อมูล SQLite

---

### 2. แสดงรายการสินค้า (View Products)

เมื่อเพิ่มสินค้าแล้ว ระบบจะแสดงรายการสินค้าในรูปแบบ List โดยประกอบด้วย

* รูปสินค้า
* ชื่อสินค้า
* ราคา

---

### 3. ลบสินค้า (Delete Product)

ผู้ใช้สามารถลบสินค้าได้โดยกดปุ่ม **Delete** ในรายการสินค้า

---

# ตัวอย่างการทำงานของแอป

1. เปิดแอป Community Market
2. กดปุ่ม **+** เพื่อเพิ่มสินค้า
3. ใส่ชื่อสินค้า ราคา และเลือกรูปภาพ
4. กด **Save**
5. สินค้าจะปรากฏในรายการทันที

---

# ฐานข้อมูลที่ใช้

ระบบใช้ฐานข้อมูล **SQLite** โดยมีตารางชื่อ `products`

```
products
-------------------------
id      INTEGER
name    TEXT
price   REAL
image   TEXT
```

---

# ผลลัพธ์ที่ได้



แอปพลิเคชันสามารถ

* เพิ่มสินค้า
* แสดงรายการสินค้า
* ลบสินค้า
* เก็บข้อมูลใน SQLite
* แสดงรูปสินค้า

---

# สรุป

Community Market App เป็นตัวอย่างของการพัฒนา Mobile Application ด้วย Flutter ที่สามารถจัดการข้อมูลสินค้าในตลาดชุมชนได้อย่างง่ายดาย โดยใช้ SQLite เป็นฐานข้อมูลและ Provider สำหรับจัดการ State ของแอปพลิเคชัน

---

# แหล่งอ้างอิง

* https://flutter.dev
* https://pub.dev
* https://docs.flutter.dev

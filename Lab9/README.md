# 🌦 Weather Application ด้วย Flutter

## 📌 รายละเอียดโครงงาน

แอปพลิเคชันพยากรณ์อากาศ (Weather Application) พัฒนาด้วย **Flutter Framework** โดยใช้ Weather API สำหรับดึงข้อมูลสภาพอากาศจากอินเทอร์เน็ต ผู้ใช้สามารถค้นหาสภาพอากาศของเมืองต่าง ๆ ได้ และแอปจะแสดงข้อมูลสภาพอากาศปัจจุบัน พร้อมรายละเอียดเพิ่มเติม เช่น อุณหภูมิ ความชื้น และความเร็วลม

แอปพลิเคชันนี้ถูกพัฒนาขึ้นเพื่อศึกษาและฝึกการพัฒนา Mobile Application ด้วย Flutter รวมถึงการเชื่อมต่อกับ API ภายนอก

---

# 🎯 วัตถุประสงค์ของโครงงาน

1. เพื่อศึกษาการพัฒนา Mobile Application ด้วย Flutter
2. เพื่อเรียนรู้การเชื่อมต่อและดึงข้อมูลจาก API
3. เพื่อออกแบบส่วนติดต่อผู้ใช้ (User Interface) ให้ใช้งานง่าย
4. เพื่อฝึกการจัดโครงสร้างโปรเจค Flutter

---

# ⚙ เทคโนโลยีที่ใช้

* **Flutter Framework**
* **Dart Programming Language**
* **HTTP Package**
* Weather API จาก OpenWeather

---

# 📱 ฟีเจอร์ของแอปพลิเคชัน

## 1️⃣ Current Weather

แสดงข้อมูลสภาพอากาศปัจจุบัน เช่น

* อุณหภูมิ (Temperature)
* สภาพอากาศ (Weather Condition)

---

## 2️⃣ Location Search

ผู้ใช้สามารถค้นหาสภาพอากาศตามชื่อเมือง (ภาษาอังกฤษ) ได้ เช่น

* Bangkok
* Tokyo
* London

---

## 3️⃣ Weather Details

แสดงข้อมูลเพิ่มเติมของสภาพอากาศ เช่น

* ความชื้นในอากาศ (Humidity)
* ความเร็วลม (Wind Speed)

---

## 4️⃣ Dynamic Background

พื้นหลังของแอปจะเปลี่ยนสีตามอุณหภูมิ

| อุณหภูมิ     | สีพื้นหลัง |
| ------------ | ---------- |
| มากกว่า 30°C | สีส้ม      |
| 20 – 30°C    | สีฟ้า      |
| ต่ำกว่า 20°C | สีเทา      |

---

# 📂 โครงสร้างโปรเจค

```text
lib
│
├── main.dart
│
├── screens
│   └── weather_screen.dart
│
└── services
    └── weather_service.dart
```

คำอธิบาย

* **main.dart**
  ไฟล์หลักสำหรับเริ่มต้นแอปพลิเคชัน

* **weather_screen.dart**
  จัดการหน้าจอแสดงผลของแอป เช่น UI และการค้นหาเมือง

* **weather_service.dart**
  ใช้สำหรับเรียกข้อมูลจาก Weather API

---

# 🔑 การตั้งค่า API

โครงงานนี้ใช้ API จาก OpenWeather โดยต้องใส่ API Key ในไฟล์

```text
lib/services/weather_service.dart
```

ตัวอย่าง

```dart
final String apiKey = "YOUR_API_KEY";
```

---

# ▶ วิธีการรันโปรเจค

1. เปิดโปรเจคด้วย VS Code หรือ Android Studio

2. ติดตั้ง dependencies

```bash
flutter pub get
```

3. รันแอปพลิเคชัน

```bash
flutter run
```



---

# 🚀 แนวทางพัฒนาต่อในอนาคต

* เพิ่มการพยากรณ์อากาศล่วงหน้า 10 วัน (10-Day Forecast)
* เพิ่มการพยากรณ์อากาศรายชั่วโมง
* เพิ่มการใช้ GPS เพื่อตรวจสอบตำแหน่งปัจจุบันของผู้ใช้
* เพิ่มไอคอนสภาพอากาศจาก API
* ปรับปรุง UI ให้สวยงามมากขึ้น

---

# 👨‍💻 ผู้พัฒนา

โครงงานนี้พัฒนาขึ้นเพื่อใช้ในการศึกษาและการเรียนรู้เกี่ยวกับการพัฒนา Mobile Application ด้วย Flutter และการใช้งาน API

# Activity Tracker (Flutter)

Activity Tracker เป็นแอปพลิเคชันสำหรับจัดการกิจกรรม (Events) และติดตามงานต่าง ๆ โดยผู้ใช้สามารถเพิ่ม แก้ไข ลบ และจัดหมวดหมู่กิจกรรมได้ พร้อมระบบค้นหาและจัดการข้อมูลผ่าน SQLite

---

## Features

* เพิ่ม / แก้ไข / ลบ Event
* จัดหมวดหมู่กิจกรรม (Category)
* แสดงสีของ Category ในรายการกิจกรรม
* ค้นหา Event
* ใช้ SQLite สำหรับจัดเก็บข้อมูล
* ใช้ Provider สำหรับ State Management

---

## Technologies Used

* Flutter
* Dart
* SQLite (sqflite)
* Provider (State Management)

---

## Database Structure

ฐานข้อมูลใช้ SQLite ผ่าน `sqflite`

### Tables

#### categories

| field | type         |
| ----- | ------------ |
| id    | INTEGER (PK) |
| name  | TEXT         |
| color | INTEGER      |

#### events

| field       | type         |
| ----------- | ------------ |
| id          | INTEGER (PK) |
| title       | TEXT         |
| description | TEXT         |
| startTime   | TEXT         |
| endTime     | TEXT         |
| categoryId  | INTEGER      |
| status      | TEXT         |
| updatedAt   | TEXT         |

#### reminders

| field    | type         |
| -------- | ------------ |
| id       | INTEGER (PK) |
| eventId  | INTEGER      |
| remindAt | TEXT         |
| enabled  | INTEGER      |

Foreign Key:

* `events.categoryId → categories.id`
* `reminders.eventId → events.id`

---

## Default Categories

เมื่อสร้างฐานข้อมูลครั้งแรก ระบบจะเพิ่ม Category เริ่มต้น 4 ประเภท

* Meeting
* Training
* External Task
* Document Work

---

## Project Structure

```
lib/
│
├── database
│   └── app_database.dart
│
├── models
│   ├── event_model.dart
│   ├── category_model.dart
│   └── reminder_model.dart
│
├── repositories
│   ├── event_repository.dart
│   ├── category_repository.dart
│   └── reminder_repository.dart
│
├── providers
│   ├── event_provider.dart
│   └── category_provider.dart
│
├── screens
│   ├── activity_list_screen.dart
│   ├── add_edit_event_screen.dart
│   └── manage_categories_screen.dart
│
└── main.dart
```

---

## State Management

ใช้ Provider เพื่อจัดการ State ของข้อมูล

### CategoryProvider

* โหลด Category จาก Database
* Refresh หลังจากมีการ CRUD

### EventProvider

* จัดการ Event ทั้งหมด
* ค้นหา (Search)
* Filter
* Sort

---

## Screens

### Activity List Screen

แสดงรายการ Event ทั้งหมด พร้อม

* Category Color Indicator
* Search Bar
* Edit / Delete Menu

### Add / Edit Event Screen

ใช้สำหรับ

* เพิ่ม Event
* แก้ไข Event
* เลือก Category

### Manage Categories Screen

ใช้สำหรับ

* เพิ่ม Category
* แก้ไข Category
* ลบ Category

---

## Installation

1. Clone repository

```
git clone https://github.com/yourusername/activity-tracker.git
```

2. เข้าโฟลเดอร์โปรเจกต์

```
cd activity-tracker
```

3. ติดตั้ง dependencies

```
flutter pub get
```

4. รันแอป

```
flutter run
```



---

## Author

Borwonrat Sirimueang

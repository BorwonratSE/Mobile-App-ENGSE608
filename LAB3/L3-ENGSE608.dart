// =======================
// Class แม่: Product
// =======================
class Product {
  // private property
  final String _id;

  // public properties
  String name;
  double _price;
  int? stock;

  // constructor
  Product({
    required String id,
    required this.name,
    required double price,
    this.stock,
  })  : _id = id,
        _price = price {
    print('New Product created: $id ($name)');
  }

  // getter
  String get id => _id;

  double get price => _price;

  // setter
  set price(double value) {
    if (value > 0) {
      _price = value;
    } else {
      print('ราคาไม่ถูกต้อง (ต้อง > 0) -> ไม่เปลี่ยนค่า');
    }
  }

  // ลดราคา
  void applyDiscount(double percent) {
    if (percent >= 0 && percent <= 100) {
      _price = _price * (1 - percent / 100);
    } else {
      print('เปอร์เซ็นต์ส่วนลดไม่ถูกต้อง');
    }
  }

  // เพิ่มสต็อก
  void restock(int amount) {
    stock ??= 0;
    stock = stock! + amount;
  }

  // แสดงข้อมูล
  void showInfo() {
    print('----------------');
    print('ID: $_id');
    print('Name: $name');
    print('Price: $_price');
    print('Stock: ${stock ?? "ยังไม่ระบุสต็อก"}');
  }
}

// =======================
// Class ลูก: DigitalProduct
// =======================
class DigitalProduct extends Product {
  double fileSizeMB;

  DigitalProduct({
    required String id,
    required String name,
    required double price,
    required this.fileSizeMB,
    int? stock,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    super.showInfo();
    print('Type: Digital');
    print('File Size: $fileSizeMB MB');
  }
}

// =======================
// Class ลูก: FoodProduct
// =======================
class FoodProduct extends Product {
  String expireDate;

  FoodProduct({
    required String id,
    required String name,
    required double price,
    required this.expireDate,
    int? stock,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    super.showInfo();
    print('Type: Food');
    print('Expire Date: $expireDate');
  }
}

// =======================
// main()
// =======================
void main() {
  // สร้างสินค้า
  Product p1 = Product(
    id: 'P001',
    name: 'Notebook',
    price: 50,
  );

  Product p2 = DigitalProduct(
    id: 'D001',
    name: 'E-Book Flutter',
    price: 199,
    fileSizeMB: 120.5,
  );

  Product p3 = FoodProduct(
    id: 'F001',
    name: 'Milk',
    price: 25,
    expireDate: '2026-01-10',
    stock: 15,
  );

  // ทดลองการทำงาน
  p1.applyDiscount(10);
  p1.restock(50);
  p1.price = -100; // ต้องถูกป้องกัน

  // Polymorphism
  List<Product> products = [p1, p2, p3];

  for (var product in products) {
    product.showInfo();
  }
}

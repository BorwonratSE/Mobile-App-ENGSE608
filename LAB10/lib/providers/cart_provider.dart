import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(ProductModel product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void increaseQty(int id) {
    _items.firstWhere((i) => i.product.id == id).quantity++;
    notifyListeners();
  }

  void decreaseQty(int id) {
    final item = _items.firstWhere((i) => i.product.id == id);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.removeWhere((i) => i.product.id == id);
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.removeWhere((i) => i.product.id == id);
    notifyListeners();
  }

  double get grandTotal => _items.fold(0, (sum, item) => sum + item.total);
}

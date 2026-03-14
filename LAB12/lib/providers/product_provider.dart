import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];

  Future loadProducts() async {
    products = await DatabaseHelper.instance.getProducts();

    notifyListeners();
  }

  Future addProduct(String name, double price, String image) async {
    final product = Product(name: name, price: price, image: image);

    await DatabaseHelper.instance.insertProduct(product);

    await loadProducts();
  }

  Future deleteProduct(int id) async {
    await DatabaseHelper.instance.deleteProduct(id);

    await loadProducts();
  }
}

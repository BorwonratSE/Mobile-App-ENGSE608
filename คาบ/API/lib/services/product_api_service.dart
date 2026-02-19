import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductApiService {
  static const _url = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final res = await http.get(Uri.parse(_url));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load products');
  }
}

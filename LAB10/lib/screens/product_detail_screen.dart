import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Added to cart"),
                  ),
                );
              },
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}

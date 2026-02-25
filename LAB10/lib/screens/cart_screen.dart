import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, i) {
                final item = cart.items[i];

                return ListTile(
                  title: Text(item.product.title),
                  subtitle: Text(
                    "\$${item.product.price} x ${item.quantity} = \$${item.total.toStringAsFixed(2)}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => cart.decreaseQty(item.product.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => cart.increaseQty(item.product.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cart.removeItem(item.product.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total: \$${cart.grandTotal.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

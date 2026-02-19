import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: p.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: p.products.length,
              itemBuilder: (_, i) {
                final item = p.products[i];
                return ListTile(
                  leading: Image.network(
                    item.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item.title),
                  subtitle: Text('\$${item.price}'),
                );
              },
            ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: product.image.isNotEmpty
            ? Image.file(
                File(product.image),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.shopping_bag),

        title: Text(product.name),

        subtitle: Text("${product.price} บาท"),

        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),

          onPressed: () {
            Provider.of<ProductProvider>(
              context,
              listen: false,
            ).deleteProduct(product.id!);
          },
        ),
      ),
    );
  }
}

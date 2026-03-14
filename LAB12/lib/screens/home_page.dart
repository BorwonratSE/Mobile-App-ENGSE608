import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  String imagePath = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().loadProducts();
    });
  }

  Future pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Add Product"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imagePath.isNotEmpty)
                  Image.file(File(imagePath), height: 100),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text("Select Image"),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Product Name"),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  return;
                }

                double price = double.tryParse(priceController.text) ?? 0;

                await context.read<ProductProvider>().addProduct(
                  nameController.text,
                  price,
                  imagePath,
                );

                if (!mounted) return;

                Navigator.pop(dialogContext);

                nameController.clear();
                priceController.clear();

                setState(() {
                  imagePath = "";
                });
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Community Market")),

      body: provider.products.isEmpty
          ? const Center(child: Text("No products"))
          : ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                return ProductTile(product: provider.products[index]);
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

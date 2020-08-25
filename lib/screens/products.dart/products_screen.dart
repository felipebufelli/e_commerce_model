import 'package:e_commerce_model/common/custom_drawer/custom_drawer.dart';
import 'package:e_commerce_model/models/products_manager.dart';
import 'package:e_commerce_model/screens/products.dart/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
        return ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: productManager.allProducts.length,
          itemBuilder: (_, index) {
            return ProductListTile(productManager.allProducts[index]);
          }
        );
      }),
    );
  }
}

import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/screens/edit_product/components/images_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {

  const EditProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ImagesForm(product),
        ],
      ),
    );
  }
}
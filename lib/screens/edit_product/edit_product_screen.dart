import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/screens/edit_product/components/images_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            RaisedButton(
              onPressed: (){
                if(formKey.currentState.validate()){

                } else {

                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

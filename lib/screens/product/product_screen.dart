import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:e_commerce_model/screens/product/components/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled){
                  return IconButton(
                    icon: const Icon(Icons.edit), 
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                        arguments: product,
                      );
                    }
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
                dotSpacing: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Text(
                    'R\$19,99',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList()
                  ),
                  const SizedBox(height: 20,),
                  // ignore: prefer_if_elements_to_conditional_expressions
                  product.hasStock
                    ? Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: product.selectedSize != null ? () {
                              if(userManager.isLoggedIn) {
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              } else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            } : null,
                            color: primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              userManager.isLoggedIn
                                ? 'Adicionar ao Carrinho'
                                : 'Entre para Comprar',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }
                    )
                    : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

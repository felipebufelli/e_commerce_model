import 'package:e_commerce_model/common/empty_card.dart';
import 'package:e_commerce_model/common/login_card.dart';
import 'package:e_commerce_model/common/price_card.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/screens/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
        ),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        return cartManager.user == null
        ? LoginCard()
        : cartManager.items.isEmpty
          ? const EmptyCard(
            iconData: Icons.remove_shopping_cart, 
            title: 'Nenhum produto no carrinho!',
          )
          : ListView(
          children: <Widget>[
            Column(
                children: cartManager.items.map((cartProduct) {
              return CartTile(cartProduct);
            }).toList()),
            PriceCard(
              buttonText: 'Continuar para Entrega',
              onPressed: cartManager.isCartValid ? (){
                Navigator.of(context).pushNamed('/address');
              } : null,
            ),
          ],
        );
      }),
    );
  }
}

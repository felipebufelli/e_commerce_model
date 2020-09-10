import 'package:e_commerce_model/common/price_card.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/models/checkout_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManagar) =>
          checkoutManagar..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __) {
          return ListView(
            children: <Widget>[
              PriceCard(
                buttonText: 'Finalizar pedido', 
                onPressed: () {
                  checkoutManager.checkout();
                }
              )
            ],
          );
          }
        )
      ),
    );
  }
}

import 'package:e_commerce_model/models/address.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/screens/address/components/address_input_field.dart';
import 'package:e_commerce_model/screens/address/components/cep_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Consumer<CartManager>(builder: (_, cartManager, __) {

            final address = cartManager.address ?? Address();

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Endereço de Entrega',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  CepInputField(),
                  // ignore: prefer_if_elements_to_conditional_expressions
                  address.zipCode != null ? AddressInputField(address) : Container(),
                ],
              ),
            );
          })),
    );
  }
}

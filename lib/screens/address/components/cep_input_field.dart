import 'package:brasil_fields/brasil_fields.dart';
import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/common/custom_icon_button.dart';
import 'package:e_commerce_model/models/address.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {

  const CepInputField(this.address);

  final Address address;

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final cartManager = context.watch<CartManager>();

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !cartManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CEP', hintText: '12.345-678'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo obrigatório';
              } else if (cep.length != 10) {
                return 'CEP Inválido';
              } else {
                return null;
              }
            },
          ),
          // ignore: prefer_if_elements_to_conditional_expressions
          cartManager.loading 
            ? LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(CustomColors.primaryColor),
              backgroundColor: Colors.transparent
            )
            : Container(),
          RaisedButton(
            onPressed: !cartManager.loading ? () async {
              if (Form.of(context).validate()) {
                try {
                  await context.read<CartManager>().getAddress(cepController.text);
                } catch (e) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            } : null,
            textColor: Colors.white,
            color: CustomColors.primaryColor,
            disabledColor: CustomColors.primaryColor.withAlpha(100),
            child: const Text('Buscar CEP'),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'CEP: ${widget.address.zipCode}',
                style: TextStyle(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              size: 20,
              color: CustomColors.primaryColor,
              onTap: () {
                context.read<CartManager>().removeAddress();
              }
            )
          ],
        ),
      );
    }
  }
}

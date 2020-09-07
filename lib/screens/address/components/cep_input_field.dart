import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '12.345-678'
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly
          ],
        ),
        RaisedButton(
          onPressed: (){

          },
          textColor: Colors.white,
          color: CustomColors.primaryColor,
          disabledColor: CustomColors.primaryColor.withAlpha(100),
          child: const Text('Buscar CEP'),
        ),
      ],
    );
  }
}
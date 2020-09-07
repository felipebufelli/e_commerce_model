import 'package:brasil_fields/brasil_fields.dart';
import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class CepInputField extends StatelessWidget {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: cepController,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '12.345-678'
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          validator: (cep) {
            if(cep.isEmpty) {
              return 'Campo obrigatório';
            } else if(cep.length != 10){
              return 'CEP Inválido';
            } else {
              return null;
            }
          },
        ),
        RaisedButton(
          onPressed: (){
            if(Form.of(context).validate()) {
              context.read<CartManager>().getAddress(cepController.text);
            }
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
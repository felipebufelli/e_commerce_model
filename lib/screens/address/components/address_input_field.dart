import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/models/address.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    String emptyValidator(String text) {
      return text.isEmpty ? 'Campo obrigatório' : null;
    }

    if (address.zipCode == null) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Brasil',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123',
                ),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => address.number = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                ),
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Guanabara',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.district = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: address.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Cidade',
                  hintText: 'Campinas',
                ),
                validator: emptyValidator,
                onSaved: (t) => address.city = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: 'SP',
                  counterText: '',
                ),
                maxLength: 2,
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8,),
        RaisedButton(
          onPressed: () async {
            if(Form.of(context).validate()) {
              Form.of(context).save();
              try {
                await context.read<CartManager>().setAddress(address);
              } catch (e) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('$e'), backgroundColor: Colors.red,),
                );
              }
            }
          },
          color: CustomColors.primaryColor,
          disabledColor: CustomColors.primaryColor.withAlpha(100),
          textColor: Colors.white,
          child: const Text('Calcular Frete'),
        )
      ],
    );
    } else {
      return Container();
    }
  }
}

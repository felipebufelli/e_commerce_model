import 'package:e_commerce_model/common/custom_icon_button.dart';
import 'package:e_commerce_model/models/item_size.dart';
import 'package:flutter/material.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({
    Key key,
    @required this.size,
    @required this.onRemove,
    @required this.onMoveUp,
    @required this.onMoveDown,
  }): super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if(name.isEmpty) {
                return 'Inválido';
              } else {
                return null;
              }
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if(int.tryParse(stock) == null) {
                return 'Inválido';
              } else {
                return null;
              }
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$'
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              //TODO Validar se possui apenas duas casas decimais e permitir numero com virgula
              if(num.tryParse(price) == null) {
                return 'Inválido';
              } else {
                return null;
              }
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove, 
          color: Colors.red, 
          onTap: onRemove,
        ),
        const CustomIconButton(
          iconData: Icons.arrow_drop_up, 
          color: Colors.black, 
          onTap: null
        ),
        const CustomIconButton(
          iconData: Icons.arrow_drop_down, 
          color: Colors.black, 
          onTap: null
        ),
      ],
    );
  }
}

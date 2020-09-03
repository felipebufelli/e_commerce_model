import 'package:e_commerce_model/models/home_manager.dart';
import 'package:e_commerce_model/models/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            }, 
            textColor: Colors.white,
            child: const Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            }, 
            textColor: Colors.white,
            child: const Text('Adicionar Grade'),
          ),
        ),
      ],
    );
  }
}
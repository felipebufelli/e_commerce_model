import 'package:e_commerce_model/common/custom_icon_button.dart';
import 'package:e_commerce_model/models/home_manager.dart';
import 'package:e_commerce_model/models/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();
    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    hintStyle: TextStyle(color: Colors.white),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIconButton(
                  iconData: Icons.remove_circle_outline,
                  color: Colors.white,
                  onTap: () {
                    homeManager.removeSection(section);
                  }),
            ],
          ),
          // ignore: prefer_if_elements_to_conditional_expressions
          section.error != null 
            ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                section.error, 
                style: const TextStyle(color: Colors.red),
              ),
            )
            : Container(),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? '',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      );
    }
  }
}

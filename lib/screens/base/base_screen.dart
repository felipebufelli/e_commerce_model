import 'package:e_commerce_model/common/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
    Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
    ),
        ],
      );
  }
}
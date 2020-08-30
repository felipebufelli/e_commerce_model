import 'package:e_commerce_model/common/custom_drawer/custom_drawer.dart';
import 'package:e_commerce_model/models/page_manager.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:e_commerce_model/screens/home/home_screen.dart';
import 'package:e_commerce_model/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(_pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home3'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home4'),
                ),
              ),
              // ignore: prefer_if_elements_to_conditional_expressions
              userManager.adminEnabled
                ? Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Usuários'),
                    ),
                  )
                : Container(),
              // ignore: prefer_if_elements_to_conditional_expressions
              userManager.adminEnabled
                ? Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                    ),
                  )
                : Container(),
            ],
          );
        },
      ),
    );
  }
}

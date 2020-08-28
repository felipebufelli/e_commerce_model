import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/models/home_manager.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/models/products_manager.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:e_commerce_model/screens/base/base_screen.dart';
import 'package:e_commerce_model/screens/cart/cart_screen.dart';
import 'package:e_commerce_model/screens/login/login_screen.dart';
import 'package:e_commerce_model/screens/product/product_screen.dart';
import 'package:e_commerce_model/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, carManager) => carManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'E-commerce Model',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/product':
              return MaterialPageRoute(builder: (_) => ProductScreen(settings.arguments as Product));
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}

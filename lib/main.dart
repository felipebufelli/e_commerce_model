import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/models/admin_users_manager.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:e_commerce_model/models/home_manager.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/models/products_manager.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:e_commerce_model/screens/base/base_screen.dart';
import 'package:e_commerce_model/screens/cart/cart_screen.dart';
import 'package:e_commerce_model/screens/edit_product/edit_product_screen.dart';
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
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false, 
          update: (_, userManager, adminUsersManager) => adminUsersManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'E-commerce Model',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: CustomColors.primaryColor,
            scaffoldBackgroundColor: CustomColors.primaryColor,
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
            case '/edit_product':
              return MaterialPageRoute(builder: (_) => EditProductScreen(settings.arguments as Product));
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}

import 'package:e_commerce_model/models/cart_product.dart';
import 'package:e_commerce_model/models/product.dart';

class CartManager  {

  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
  }

}
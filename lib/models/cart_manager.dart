import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/cart_product.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/models/user.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:flutter/foundation.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];

  User user;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();

    if(user != null){
      _loadCartItems();
    }

  }

  Future<void>_loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    
    items = cartSnap.documents.map(
      (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch(e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap())
        .then((doc) => cartProduct.id = doc.documentID);
    }
    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere(
      (p) => p.id == cartProduct.id
    );
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    for(final cartProduct in items) {
      if(cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
      } else {
        _updateCartProduct(cartProduct);
      }
    }
  }

  void _updateCartProduct(CartProduct cartProduct){
    user.cartReference.document(cartProduct.id)
      .updateData(cartProduct.toCartItemMap());
  }

}
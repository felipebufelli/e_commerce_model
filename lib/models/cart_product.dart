import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/item_size.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:flutter/foundation.dart';

class CartProduct extends ChangeNotifier {

  CartProduct.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get().then(
      (doc) => product = Product.fromDocument(doc)
    );
  }

  final Firestore firestore = Firestore.instance;

  String id;
  String productId;
  int quantity;
  String size;

  Product product;

  ItemSize get itemSize {
    if(product == null) {
      return null;
    } else {
      return product.findSize(size);
    }
  }

  num get unitPrice {
    if(product == null) {
      return 0;
    } else {
      return itemSize?.price ?? 0;
    }
  }

  num get totalPrice => unitPrice*quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }
  
  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if(size == null){
      return false;
    } else {
      return size.stock >= quantity;
    }
  }

}
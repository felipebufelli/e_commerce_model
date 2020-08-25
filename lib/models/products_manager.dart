import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductManager extends ChangeNotifier {

  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();

    allProducts = snapProducts.documents.map(
      (d) => Product.fromDocument(d)
    ).toList();

    notifyListeners();
  }


}
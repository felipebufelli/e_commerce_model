import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/cart_manager.dart';
import 'package:flutter/cupertino.dart';

class CheckoutManager extends ChangeNotifier {

  CartManager cartManager;

  final Firestore firestore = Firestore.instance;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }

  void checkout() {
    _decrementStock();
    _getOrderId();
  }

  Future<int> _getOrderId() async {

    final ref = firestore.document('aux/ordercounter');

    try {
      final result = await firestore.runTransaction(
        (transaction) async {
          final doc = await transaction.get(ref);
          final orderId = doc.data['current'] as int;
          await transaction.update(ref, {'current' : orderId +1} );
          return {'orderId': orderId};
        }
      );
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  void _decrementStock() {
    //*Verificar o stoque se está disponivel
        //* Sim? - Continua
        //* Não? - Retorna pro carrinho

    //* Adicionar produtos do carrinho para Products to upadate

    //* Decrementar produtos do estoque

    //* Escrever no firebase 
  }

}
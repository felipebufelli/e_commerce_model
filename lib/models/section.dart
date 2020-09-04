import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/section_item.dart';
import 'package:flutter/foundation.dart';

class Section extends ChangeNotifier {

  Section({
    this.id,
    this.name,
    this.type,
    this.items,
  }){
    items = items ?? [];
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List)
      .map(
        (i) => SectionItem.fromMap(i as Map<String,dynamic>)
      ).toList();
  }

  String id;
  String name;
  String type;
  List<SectionItem> items;

  final Firestore firestore = Firestore.instance; 
  DocumentReference get firestoreRef => firestore.document('home/$id');
  
  String _error;
  String get error => _error;
  set error(String value) {
    _error = value;
    notifyListeners();
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  bool valid() {
    if( name == null || name.isEmpty ) {
      error = 'Título inválido';
    } else if(items.isEmpty) {
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }
    return error == null;
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
    };

    if(id == null) {
      final doc = await firestore.collection('home').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

  }

  Section clone() {
    return Section(
      id: id,
      name: name, 
      type: type, 
      items: items.map((e) => e.clone()).toList()
    );
  }

}
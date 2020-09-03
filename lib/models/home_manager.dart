import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_model/models/section.dart';
import 'package:flutter/foundation.dart';

class HomeManager extends ChangeNotifier {

  HomeManager(){
    _loadSections();
  }

  final List<Section> _sections = [];
  List<Section> _editingSections = [];

  bool editing = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home')
    .snapshots()
    .listen(
      (snapshot) {
        _sections.clear();
        for(final DocumentSnapshot document in snapshot.documents){
          _sections.add(Section.fromDocument(document));
        }
        notifyListeners();
      }
    );
  }

  List<Section> get sections {
    if(editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  void saveEditing() {
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }


}
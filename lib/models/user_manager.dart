import 'package:e_commerce_model/helpers/firebase_errors.dart';
import 'package:e_commerce_model/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  bool _loading = false; 
  bool get loading => _loading;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    
    loading = true;

    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      this.user = result.user;
      onSuccess();
    } on PlatformException catch(error) {
      onFail(getErrorString(error.code));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if(currentUser != null) {
      user = currentUser;
    }
    notifyListeners();
  }

}

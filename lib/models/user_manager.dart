import 'package:e_commerce_model/helpers/firebase_errors.dart';
import 'package:e_commerce_model/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {

    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      onSuccess();
    } on PlatformException catch(error) {
      onFail(getErrorString(error.code));
    }

  }
}

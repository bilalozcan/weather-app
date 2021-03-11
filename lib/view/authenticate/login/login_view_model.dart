import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/service/firebase_auth_service.dart';

class LoginViewModel with ChangeNotifier {
  IconData _obscureIconData;
  bool _obscureText;
  TextEditingController email;
  TextEditingController password;
  FirebaseAuthService _firebaseAuthService;

  LoginViewModel() {
    _obscureIconData = Icons.visibility_off;
    _obscureText = true;
    email = TextEditingController();
    password = TextEditingController();
    _firebaseAuthService = FirebaseAuthService();
  }

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  IconData get obscureIconData => _obscureIconData;

  set obscureIconData(IconData value) {
    _obscureIconData = value;
    notifyListeners();
  }

  void change() {
    if (obscureText) {
      obscureIconData = Icons.visibility;
      obscureText = false;
    } else {
      obscureIconData = Icons.visibility_off;
      obscureText = true;
    }
  }
  Future<bool> signIn()async{
    if(email.text != '' && password.text != ''){
      var result = await _firebaseAuthService.signInWithEmailAndPassword(
          email: email.text,
          password: password.text);
      if(result != null){
        return true;
      }else {
        return false;
      }
    }else{
      Fluttertoast.showToast(msg: 'Boş Bırakamazsınız');
      return false;
    }


  }
}

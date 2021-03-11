import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/service/firebase_auth_service.dart';
import 'package:weather_app/service/firebase_firestore_service.dart';
import 'package:weather_app/service/location_service.dart';

class RegisterViewModel with ChangeNotifier {
  IconData _obscureIconData;
  bool _obscureText;
  TextEditingController fullName;
  TextEditingController email;
  TextEditingController password;
  TextEditingController passwordAgain;
  FirebaseAuthService firebaseAuthService;
  FirebaseFirestoreService firebaseFirestoreService;
  LocationService _locationService;
  bool _isLoading;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  RegisterViewModel() {
    _obscureIconData = Icons.visibility_off;
    _obscureText = true;
    _isLoading = false;
    fullName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordAgain = TextEditingController();
    firebaseAuthService = FirebaseAuthService();
    firebaseFirestoreService = FirebaseFirestoreService();
    _locationService = LocationService();
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

  Future<bool> registerUser() async {
    try {
      if (fullName.text != '' &&
          email.text != '' &&
          password.text != '' &&
          passwordAgain.text != '') {
        if (password.text.length < 6) {
          Fluttertoast.showToast(msg: 'Şifre en az 6 karakter olmalıdır');
          return false;
        } else {
          if (password.text == passwordAgain.text) {
            isLoading = true;
            Position location = await _locationService.getLocation();
            if (location != null) {
              var result =
                  await firebaseAuthService.createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                      fullName: fullName.text,
                      location: location);
              if (result != null) {
                return await firebaseFirestoreService.saveUser(result);
              } else {
                return false;
              }
            }
          } else {
            Fluttertoast.showToast(msg: 'Şifreler eşleşmiyor');
            return false;
          }
        }
      } else {
        Fluttertoast.showToast(msg: 'Tüm alanları doldurun');
        return false;
      }
    } catch (e) {
      print('register Error: $e');
      return e;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> checkInternet() async {
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }

  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/model/user_model.dart' as usr;
import 'package:weather_app/service/firebase_auth_service.dart';
import 'package:weather_app/service/firebase_firestore_service.dart';
import 'package:weather_app/service/location_service.dart';

class SplashViewModel with ChangeNotifier{
  usr.User _currentUser;
  FirebaseAuthService _firebaseAuthService;
  FirebaseFirestoreService _firebaseFirestoreService;
  LocationService _locationService;
  bool isLoading;
  SharedPreferences prefs;
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  SplashViewModel(){
    init();
    _firebaseAuthService = FirebaseAuthService();
    _firebaseFirestoreService = FirebaseFirestoreService();
    _locationService = LocationService();
    isLoading = false;
  }


  usr.User get currentUser => _currentUser;

  set currentUser(usr.User value) {
    _currentUser = value;
    notifyListeners();
  }

  Timer timer(BuildContext context){
    return Timer(
        Duration(seconds: 2),
            () => Navigator.pushNamed(context, NavigationConstants.LOGIN_VIEW));
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

  Future<bool> getCurrentUser() async{
    if(await checkInternet()){
      var result = await _firebaseAuthService.currentUser();
      if(result != null){
        _currentUser = await _firebaseFirestoreService.readUser(result.uid);
        await getLocation();
        return true;
      }else{
        return false;
      }
    }else{
      bool aa = prefs.getBool('currentUser');
      if(aa){
        return true;
      }else{
        return false;
      }
    }

  }

  Future<void> getLocation() async {
    try {
      isLoading = true;
      var location = await _locationService.getLocation();
      if (location != null) {
        await _firebaseFirestoreService.setUserLocation(_currentUser, location);
      } else {
        throw Error();
      }
    } catch (e) {
      print('getLocation Error: $e');
    } finally {
      isLoading = false;
    }
  }
}
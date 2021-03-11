import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/user_model.dart' as usr;

class FirebaseAuthService {
  SharedPreferences prefs;
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  FirebaseAuthService(){
    init();
  }

  Future<dynamic> createUserWithEmailAndPassword(
      {String email, String password, String fullName, Position location}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        prefs.setBool('currentUser', true);
        return usr.User(
            id: userCredential.user.uid,
            fullName: fullName,
            email: email,
            location: GeoPoint(location.latitude, location.longitude));
      } else {
        return null;
      }
    } catch (e) {
      print('AuthService-createUserWithEmailAndPassword Error: $e');
      return e;
    }
  }

  Future<User> currentUser() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('AuthService-currentUser Error: $e');
      return e;
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        prefs.setBool('currentUser', true);
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      print('AuthService-signInWithEmailAndPassword Error: $e');
      return e;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      prefs.setBool('currentUser', false);
      return true;
    } catch (e) {
      print('AuthService-signOut Error: $e');
      return e;
    }
  }
}

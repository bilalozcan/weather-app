import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/user_model.dart' as usr;

class FirebaseFirestoreService {
  Future<bool> saveUser(dynamic user) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .get();
      if (result != null) {
        await result.reference.set(user.toMap());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('FirestoreService-saveUser Error: $e');
      return e;
    }
  }

  Future<bool> setUserLocation(usr.User user, Position position) async {
    try {
      user.location = GeoPoint(position.latitude, position.longitude);
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .get();
      if (result != null) {
        await result.reference.set(user.toMap());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('FirestoreService-setUserLocation Error: $e');
      return e;
    }
  }

  Future<usr.User> readUser(String uid) async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (result != null) {
        usr.User user = usr.User.fromMap(result.data());
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('FirestoreService-readUser Error: $e');
      return e;
    }
  }
}

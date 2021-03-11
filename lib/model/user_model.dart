import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    this.id,
    this.fullName,
    this.email,
    this.location,
  });

  String id;
  String fullName;
  String email;
  GeoPoint location;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    location: json["location"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "location": location,
  };

}
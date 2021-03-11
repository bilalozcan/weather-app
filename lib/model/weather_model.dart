// To parse this JSON data, do
//
//     final weather = weatherFromMap(jsonString);

import 'dart:convert';

class Weather {
  Weather({
    this.id,
    this.city,
    this.date,
    this.minTemp,
    this.maxTemp,
    this.dayIcon,
    this.dayIconPhrase,
    this.nightIcon,
    this.nightIconPhrase,
  });

  int id;
  String city;
  String date;
  double minTemp;
  double maxTemp;
  int dayIcon;
  String dayIconPhrase;
  int nightIcon;
  String nightIconPhrase;

  factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
    id: json["id"],
    city: json["city"],
    date: json["date"],
    minTemp: json["minTemp"].toDouble(),
    maxTemp: json["maxTemp"].toDouble(),
    dayIcon: json["dayIcon"],
    dayIconPhrase: json["dayIconPhrase"],
    nightIcon: json["nightIcon"],
    nightIconPhrase: json["nightIconPhrase"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "city": city,
    "date": date,
    "minTemp": minTemp,
    "maxTemp": maxTemp,
    "dayIcon": dayIcon,
    "dayIconPhrase": dayIconPhrase,
    "nightIcon": nightIcon,
    "nightIconPhrase": nightIconPhrase,
  };
}

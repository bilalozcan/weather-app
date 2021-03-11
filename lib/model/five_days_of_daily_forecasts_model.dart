// To parse this JSON data, do
//
//     final fiveDaysofDailyForecasts = fiveDaysofDailyForecastsFromMap(jsonString);

import 'dart:convert';

class FiveDaysOfDailyForecasts {
  FiveDaysOfDailyForecasts({
    this.headline,
    this.dailyForecasts,
  });

  Headline headline;
  List<DailyForecast> dailyForecasts;

  factory FiveDaysOfDailyForecasts.fromJson(String str) => FiveDaysOfDailyForecasts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FiveDaysOfDailyForecasts.fromMap(Map<String, dynamic> json) => FiveDaysOfDailyForecasts(
    headline: Headline.fromMap(json["Headline"]),
    dailyForecasts: List<DailyForecast>.from(json["DailyForecasts"].map((x) => DailyForecast.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Headline": headline.toMap(),
    "DailyForecasts": List<dynamic>.from(dailyForecasts.map((x) => x.toMap())),
  };
}

class DailyForecast {
  DailyForecast({
    this.date,
    this.epochDate,
    this.temperature,
    this.day,
    this.night,
    this.sources,
    this.mobileLink,
    this.link,
  });

  DateTime date;
  int epochDate;
  Temperature temperature;
  Day day;
  Day night;
  List<String> sources;
  String mobileLink;
  String link;

  factory DailyForecast.fromJson(String str) => DailyForecast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyForecast.fromMap(Map<String, dynamic> json) => DailyForecast(
    date: DateTime.parse(json["Date"]),
    epochDate: json["EpochDate"],
    temperature: Temperature.fromMap(json["Temperature"]),
    day: Day.fromMap(json["Day"]),
    night: Day.fromMap(json["Night"]),
    sources: List<String>.from(json["Sources"].map((x) => x)),
    mobileLink: json["MobileLink"],
    link: json["Link"],
  );

  Map<String, dynamic> toMap() => {
    "Date": date.toIso8601String(),
    "EpochDate": epochDate,
    "Temperature": temperature.toMap(),
    "Day": day.toMap(),
    "Night": night.toMap(),
    "Sources": List<dynamic>.from(sources.map((x) => x)),
    "MobileLink": mobileLink,
    "Link": link,
  };
}

class Day {
  Day({
    this.icon,
    this.iconPhrase,
    this.hasPrecipitation,
    this.precipitationType,
    this.precipitationIntensity,
  });

  int icon;
  String iconPhrase;
  bool hasPrecipitation;
  String precipitationType;
  String precipitationIntensity;

  factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Day.fromMap(Map<String, dynamic> json) => Day(
    icon: json["Icon"],
    iconPhrase: json["IconPhrase"],
    hasPrecipitation: json["HasPrecipitation"],
    precipitationType: json["PrecipitationType"] == null ? null : json["PrecipitationType"],
    precipitationIntensity: json["PrecipitationIntensity"] == null ? null : json["PrecipitationIntensity"],
  );

  Map<String, dynamic> toMap() => {
    "Icon": icon,
    "IconPhrase": iconPhrase,
    "HasPrecipitation": hasPrecipitation,
    "PrecipitationType": precipitationType == null ? null : precipitationType,
    "PrecipitationIntensity": precipitationIntensity == null ? null : precipitationIntensity,
  };
}

class Temperature {
  Temperature({
    this.minimum,
    this.maximum,
  });

  Imum minimum;
  Imum maximum;

  factory Temperature.fromJson(String str) => Temperature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Temperature.fromMap(Map<String, dynamic> json) => Temperature(
    minimum: Imum.fromMap(json["Minimum"]),
    maximum: Imum.fromMap(json["Maximum"]),
  );

  Map<String, dynamic> toMap() => {
    "Minimum": minimum.toMap(),
    "Maximum": maximum.toMap(),
  };
}

class Imum {
  Imum({
    this.value,
    this.unit,
    this.unitType,
  });

  double value;
  Unit unit;
  int unitType;

  factory Imum.fromJson(String str) => Imum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Imum.fromMap(Map<String, dynamic> json) => Imum(
    value: json["Value"].toDouble(),
    unit: unitValues.map[json["Unit"]],
    unitType: json["UnitType"],
  );

  Map<String, dynamic> toMap() => {
    "Value": value,
    "Unit": unitValues.reverse[unit],
    "UnitType": unitType,
  };
}

enum Unit { C }

final unitValues = EnumValues({
  "C": Unit.C
});

class Headline {
  Headline({
    this.effectiveDate,
    this.effectiveEpochDate,
    this.severity,
    this.text,
    this.category,
    this.endDate,
    this.endEpochDate,
    this.mobileLink,
    this.link,
  });

  DateTime effectiveDate;
  int effectiveEpochDate;
  int severity;
  String text;
  String category;
  DateTime endDate;
  int endEpochDate;
  String mobileLink;
  String link;

  factory Headline.fromJson(String str) => Headline.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Headline.fromMap(Map<String, dynamic> json) => Headline(
    effectiveDate: DateTime.parse(json["EffectiveDate"]),
    effectiveEpochDate: json["EffectiveEpochDate"],
    severity: json["Severity"],
    text: json["Text"],
    category: json["Category"],
    endDate: DateTime.parse(json["EndDate"]),
    endEpochDate: json["EndEpochDate"],
    mobileLink: json["MobileLink"],
    link: json["Link"],
  );

  Map<String, dynamic> toMap() => {
    "EffectiveDate": effectiveDate.toIso8601String(),
    "EffectiveEpochDate": effectiveEpochDate,
    "Severity": severity,
    "Text": text,
    "Category": category,
    "EndDate": endDate.toIso8601String(),
    "EndEpochDate": endEpochDate,
    "MobileLink": mobileLink,
    "Link": link,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/five_days_of_daily_forecasts_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/locale_database_service.dart';

class WeatherService {
  String APIKey = 'P9WhAzaQcfj2mLGihGTIRFhH6GgrOzBA';
  LocaleDatabaseService databaseHelper = LocaleDatabaseService();
  String cityName;
  String cityKey;

  void geopositionSearch(Position location) async {
    var queryParam = {'apikey': APIKey, 'q': '${location.latitude},${location.longitude}'};
    var uri = Uri.https('dataservice.accuweather.com',
        '/locations/v1/cities/geoposition/search', queryParam);
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      var map = jsonDecode(result.body);
      cityName = map['AdministrativeArea']['LocalizedName'];
      cityKey = map['Key'];
    }
  }

  Future<List> getWeather() async {
    var queryParam = <String, dynamic>{
      'apikey': APIKey,
      'language': 'tr-TR',
      'metric': true.toString()
    };
    var uri = Uri.https('dataservice.accuweather.com',
        '/forecasts/v1/daily/5day/$cityKey', queryParam);
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      FiveDaysOfDailyForecasts fiveDaysOfDailyForecasts =
          FiveDaysOfDailyForecasts.fromJson(result.body);
      databaseHelper.deleteAllWeather();
      fiveDaysOfDailyForecasts.dailyForecasts.map((e){
        databaseHelper.addWeather(Weather(
            id: e.epochDate,
            city: cityName,
            date: e.date.toString(),
            minTemp: e.temperature.minimum.value,
            maxTemp: e.temperature.maximum.value,
            dayIcon: e.day.icon,
            dayIconPhrase: e.day.iconPhrase,
            nightIcon: e.night.icon,
            nightIconPhrase: e.night.iconPhrase));
      }).toList();
      return await databaseHelper.allWeather();
    } else {
      return null;
    }
  }
  Future<List> getWeatherNoConnected() async{
    return await databaseHelper.allWeather();
  }
}

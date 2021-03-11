import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/five_days_of_daily_forecasts_model.dart';
import 'package:weather_app/service/firebase_auth_service.dart';
import 'package:weather_app/service/location_service.dart';
import 'package:weather_app/service/weather_service.dart';

class MainViewModel with ChangeNotifier {
  WeatherService _weatherService;
  FiveDaysOfDailyForecasts fiveDaysOfDailyForecasts;
  List<Map<String, dynamic>> weatherList;
  FirebaseAuthService firebaseAuthService;
  LocationService locationService;
  bool _isLoading;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }



  MainViewModel(){
    _weatherService = WeatherService();
    firebaseAuthService = FirebaseAuthService();
    locationService = LocationService();
    isLoading = false;
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

  void request()async{
    isLoading = true;
    if(await checkInternet()){
      Position location = await locationService.getLocation();
      await _weatherService.geopositionSearch(location);
      weatherList = await _weatherService.getWeather();
    }else{
      weatherList = await _weatherService.getWeatherNoConnected();
    }

    isLoading = false;
  }

  Future<bool> signOut() async {
    return await firebaseAuthService.signOut();
  }
}
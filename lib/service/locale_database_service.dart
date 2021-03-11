import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:weather_app/model/weather_model.dart';

class LocaleDatabaseService {
  static LocaleDatabaseService _databaseHelper;
  static Database _database;
  String _documentTable = 'weathers';

  String columnID = 'id';
  String columnCity = 'city';
  String columnDate = 'date';
  String columnMinTemp = 'minTemp';
  String columnMaxTemp = 'maxTemp';
  String columnDayIcon = 'dayIcon';
  String columnDayIconPhrase = 'dayIconPhrase';
  String columnNightIcon = 'nightIcon';
  String columnNightIconPhrase = 'nightIconPhrase';

  factory LocaleDatabaseService() {
    if (_databaseHelper == null) {
      _databaseHelper = LocaleDatabaseService._internal();
      return _databaseHelper;
    } else
      return _databaseHelper;
  }

  LocaleDatabaseService._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, "weather_createDB");
    var documentDB = openDatabase(dbPath, version: 1, onCreate: _createDB);
    return documentDB;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_documentTable ($columnID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $columnCity TEXT,"
        " $columnDate TEXT,"
        " $columnMinTemp REAL,"
        " $columnMaxTemp REAL,"
        " $columnDayIcon INTEGER,"
        " $columnDayIconPhrase TEXT,"
        " $columnNightIcon INTEGER,"
        " $columnNightIconPhrase TEXT )");
  }

  Future<int> addWeather(Weather weather) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_documentTable, weather.toMap(),
        nullColumnHack: "$columnID");
    return sonuc;
  }


  Future<int> deleteAllWeather() async {
    var db = await _getDatabase();
    var sonuc = await db.delete(_documentTable);
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> allWeather() async {
    var db = await _getDatabase();
    var sonuc = await db.query(_documentTable, orderBy: '$columnID ASC');
    return sonuc;
  }
}

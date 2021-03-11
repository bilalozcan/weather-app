import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/authenticate/login/login_view.dart';
import 'package:weather_app/view/authenticate/login/login_view_model.dart';
import 'package:weather_app/view/authenticate/register/register_view.dart';
import 'package:weather_app/view/authenticate/register/register_view_model.dart';
import 'package:weather_app/view/authenticate/splash/splash_view.dart';
import 'package:weather_app/view/authenticate/splash/splash_view_model.dart';
import 'package:weather_app/view/home/main/main_view.dart';
import 'package:weather_app/view/home/main/main_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => MainViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashView(),
          '/login': (context) => LoginView(),
          '/register': (context) => RegisterView(),
          '/main': (context) => MainView(),
        },
        theme: ThemeData(
            primaryColor: Color(0xff046C95),
            colorScheme: ColorScheme.light(
              primary: Color(0xff046C95),
            )),
        title: 'Weather App',
      ),
    );
  }
}

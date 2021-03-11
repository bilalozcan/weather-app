import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/model/user_model.dart';
import 'package:weather_app/view/authenticate/login/login_view.dart';
import 'package:weather_app/view/authenticate/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home/main/main_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: context.watch<SplashViewModel>().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data)
            return MainView();
          else
            return LoginView();
        } else {
          return buildContainer;
        }
      },
    ));
  }

  Container get buildContainer => Container(
        width: dynamicWidth(1),
        height: dynamicHeight(1),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff48B5D6),
          Color(0xffB3E0EE),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/cloud.png', scale: 2,),
            LoadingBouncingGrid.circle(backgroundColor: Color(0xff046C95),)
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home/main/main_view_model.dart';
import 'package:loading_animations/loading_animations.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  var weekdayMap = {
    1: 'Pazartesi',
    2: 'Salı',
    3: 'Çarşamba',
    4: 'Perşembe',
    5: 'Cuma',
    6: 'Cumartesi',
    7: 'Pazar'
  };

  @override
  void initState() {
    super.initState();
    context.read<MainViewModel>().request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                child: Icon(
                  Icons.exit_to_app_outlined,
                  size: 32,
                ),
                onTap: () async {
                  bool result = await context.read<MainViewModel>().signOut();
                  if (result) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        NavigationConstants.LOGIN_VIEW, (route) => false);
                  }
                }),
          )
        ],
      ),
      body: Container(
          width: dynamicWidth(1),
          height: dynamicHeight(1),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff48B5D6), Color(0xff046C95)])),
          child: context.watch<MainViewModel>().isLoading
              ? Center(
                  child: LoadingBouncingGrid.circle(
                    backgroundColor: Color(0xff046C95),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      height: dynamicHeight(0.15),
                      child: Column(
                        children: [
                          Text(
                            context
                                .watch<MainViewModel>()
                                .weatherList
                                .first['city'],
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/day.svg',
                                  ),
                                  Text(
                                    'Gündüz',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/night.svg',
                                  ),
                                  Text(
                                    'Gece',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                          children: context
                              .watch<MainViewModel>()
                              .weatherList
                              .map((weather) {
                        return buildContainer(weather);
                      }).toList()),
                    )
                  ],
                )),
    );
  }

  Container buildContainer(Map<String, dynamic> weather) {
    return Container(
      width: dynamicWidth(1),
      height: dynamicHeight(0.20),
      child: Column(
        children: [
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DateTime.now().weekday == DateTime.parse(weather['date']).weekday
                  ? Text(
                      'Bugün',
                      style: TextStyle(color: Colors.white),
                    )
                  : DateTime.now().weekday - 1 ==
                          DateTime.parse(weather['date']).weekday
                      ? Text(
                          'Dün',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          weekdayMap[DateTime.parse(weather['date']).weekday],
                          style: TextStyle(color: Colors.white),
                        ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${DateTime.parse(weather['date']).day}/${DateTime.parse(weather['date']).month}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            '${weather['maxTemp'].toInt()}°/${weather['minTemp'].toInt()}°',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset('assets/icons/icon-${weather['dayIcon']}.png'),
                  Container(
                    width: 120,
                    child: Center(
                      child: Text(
                        weather['dayIconPhrase'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/icons/icon-${weather['nightIcon']}.png'),
                  Container(
                    width: 120,
                    child: Center(
                      child: Text(
                        weather['nightIconPhrase'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/components/input_box.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/service/firebase_auth_service.dart';
import 'package:weather_app/view/authenticate/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  SingleChildScrollView buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: dynamicHeight(1),
        decoration: BoxDecoration(
            gradient:
            LinearGradient(colors: [Color(0xff48B5D6), Color(0xff046C95)])),
        child: Column(
          children: [
            buildIconBox,
            buildTitleBox,
            InputBox(
                controller: context
                    .read<LoginViewModel>()
                    .email,
                iconData: Icons.account_circle,
                hint: 'E-mail',
                isPassword: false),
            InputBox(
                controller: context
                    .read<LoginViewModel>()
                    .password,
                iconData: Icons.lock,
                hint: 'Password',
                isPassword: true,
                obscureText: context
                    .watch<LoginViewModel>()
                    .obscureText,
                obscureIconData:
                context
                    .watch<LoginViewModel>()
                    .obscureIconData,
                changeVisibility: context
                    .read<LoginViewModel>()
                    .change),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(dynamicWidth(0.5), 30),
                elevation: 7,
              ),
              onPressed: () async {
                bool result = await context.read<LoginViewModel>().signIn();
                if (result)
                  Navigator.pushNamedAndRemoveUntil(
                      context, NavigationConstants.MAIN_VIEW, (route) => false);
              },
              child: Text('Sign In'),
            ),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, NavigationConstants.REGISTER_VIEW),
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }

  Container get buildIconBox =>
      Container(
          padding: EdgeInsets.only(top: 5),
          height: dynamicHeight(0.3),
          child: Image.asset('assets/cloudy.png', scale: 2.5));

  Container get buildTitleBox =>
      Container(
          height: dynamicHeight(0.2),
          child: Text('Weather App',
              style: TextStyle(color: Colors.white, fontSize: 45)));
}

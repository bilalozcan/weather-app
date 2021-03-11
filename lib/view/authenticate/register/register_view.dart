import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/components/input_box.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/service/firebase_auth_service.dart';
import 'package:weather_app/view/authenticate/register/register_view_model.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterViewModel>().checkInternet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: dynamicHeight(1),
              width: dynamicWidth(1),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff48B5D6), Color(0xff046C95)],
              )),
              child: Column(
                children: [
                  Image.asset(
                    'assets/push.png',
                    scale: 3,
                  ),
                  Container(
                    //height: dynamicHeight(0.3),
                    child: Center(
                      child: Text('Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 36)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputBox(
                      controller: context.read<RegisterViewModel>().fullName,
                      iconData: Icons.account_box,
                      hint: 'Full Name',
                      isPassword: false),
                  InputBox(
                      controller: context.read<RegisterViewModel>().email,
                      iconData: Icons.email,
                      hint: 'E-mail',
                      isPassword: false),
                  InputBox(
                      controller: context.read<RegisterViewModel>().password,
                      iconData: Icons.lock,
                      hint: 'Password',
                      isPassword: true,
                      obscureText:
                          context.watch<RegisterViewModel>().obscureText,
                      obscureIconData:
                          context.watch<RegisterViewModel>().obscureIconData,
                      changeVisibility:
                          context.read<RegisterViewModel>().change),
                  InputBox(
                      controller:
                          context.read<RegisterViewModel>().passwordAgain,
                      iconData: Icons.lock,
                      hint: 'Password again',
                      isPassword: true,
                      obscureText:
                          context.watch<RegisterViewModel>().obscureText,
                      obscureIconData:
                          context.watch<RegisterViewModel>().obscureIconData,
                      changeVisibility:
                          context.read<RegisterViewModel>().change),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(dynamicWidth(0.5), 30),
                      elevation: 7,
                      primary: Color(0xff046C95),
                    ),
                    onPressed: () async {
                      bool result = await context
                          .read<RegisterViewModel>()
                          .registerUser();
                      if (result) {
                        Fluttertoast.showToast(msg: 'Kayıt Başarılı');
                        Navigator.pushNamedAndRemoveUntil(context,
                            NavigationConstants.MAIN_VIEW, (route) => false);
                      } else {
                        Fluttertoast.showToast(msg: 'Kayıt Başarısız');
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                    //width: dynamicWidth(0.1),
                    //height: dynamicHeight(0.1),
                    child: context.watch<RegisterViewModel>().isLoading
                        ? LoadingBouncingGrid.circle(
                            backgroundColor: Color(0xff046C95),
                          )
                        : SizedBox(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: dynamicHeight(0.05),
              left: dynamicWidth(0.05),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ))
        ],
      ),
    );
  }
}

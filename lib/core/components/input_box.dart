import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hint;
  final bool isPassword;
  final bool obscureText;
  final IconData obscureIconData;
  final Function changeVisibility;

  InputBox(
      {@required this.controller,
      @required this.iconData,
      @required this.hint,
      @required this.isPassword,
      this.obscureText,
      this.obscureIconData,
      this.changeVisibility});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(iconData),
          hintText: hint,
          suffixIcon: isPassword
              ? InkWell(onTap: changeVisibility, child: Icon(obscureIconData))
              : null,
        ),
      ),
    );
  }
}

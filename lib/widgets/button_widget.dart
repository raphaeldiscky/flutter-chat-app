import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/color.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;
  ButtonWidget({this.btnText, this.onClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            )),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

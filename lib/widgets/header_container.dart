import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/color.dart';

class HeaderContainer extends StatelessWidget {
  var text = "";
  HeaderContainer(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [orangeColors, orangeLightColors],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: [
          Positioned(
              bottom: 20,
              right: 10,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Image.asset("assets/images/logo.png", height: 100),
          ),
        ],
      ),
    );
  }
}

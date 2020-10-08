import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/helper.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/utils/color.dart';
import 'package:flutter_chat/views/chatrooms.dart';
import 'package:flutter_chat/widgets/button_widget.dart';
import 'package:flutter_chat/widgets/header_container.dart';
import 'package:flutter_chat/widgets/widget.dart';
import 'package:flutter_chat/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(
              emailTextEditingController.text, passwordTextEditingController.text)
          .then((val) {
        //print("${val.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    HeaderContainer("Register"),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  _textInput(
                                      obscureText: false,
                                      validator: (val) {
                                        return val.isEmpty || val.length < 4
                                            ? "Please provide a valid username"
                                            : null;
                                      },
                                      controller: userNameTextEditingController,
                                      hint: "Username",
                                      icon: Icons.person),
                                  _textInput(
                                      obscureText: false,
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val)
                                            ? null
                                            : "Please provide a valid email address";
                                      },
                                      controller: emailTextEditingController,
                                      hint: "Email",
                                      icon: Icons.email),
                                  _textInput(
                                      obscureText: true,
                                      validator: (val) {
                                        return val.length > 6
                                            ? null
                                            : 'Please enter a password minimum 6 characters';
                                      },
                                      controller: passwordTextEditingController,
                                      hint: "Password",
                                      icon: Icons.vpn_key),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Expanded(
                              child: Center(
                                child: ButtonWidget(
                                  btnText: "SIGN UP",
                                  onClick: signUp,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account ? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(color: orangeColors),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

Widget _textInput({obscureText, validator, controller, hint, icon}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat/helper/helper.dart';
import 'package:flutter_chat/views/chatrooms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

bool isUserLoggedIn = false;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val) {
      setState(() {
        isUserLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145c9e),
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}

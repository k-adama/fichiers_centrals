import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_requetes/admin/home_page_admin.dart';
import 'package:ts_requetes/agent_recouvreur/home_page_agent_recouvreur.dart';
import 'package:ts_requetes/check_user_type.dart';
import 'package:ts_requetes/locataire/home_page_locataire.dart';
import 'package:ts_requetes/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _active = false;
  bool isAuth = false;

  void initState() {
    _checkIfLoggedIn();
    super.initState();
    // _scrollViewController = new ScrollController();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('userType');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/main': (context) => MyApp(),
        '/login': (context) => Login(),
        '/check_user_type': (context) => CheckUserType(),
        '/home_page_admin': (context) => HomePageAdmin(),
        '/home_page_locataire': (context) => HomePageLocataire(),
        '/home_page_agent_recouvreur': (context) => HomePageAgentRecouvreur(),
      },
      title: 'TS REQUÊTES',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isAuth ? CheckUserType() : Login(),
    );
  }
}

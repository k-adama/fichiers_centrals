import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class CheckUserType extends StatefulWidget {
  CheckUserType({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CheckUserTypeState createState() => _CheckUserTypeState();
}

class _CheckUserTypeState extends State<CheckUserType> {
  bool isAuth = false;

  void initState() {
    _checkUserType();
    super.initState();
  }

  void _checkUserType() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userType = localStorage.getString('userType');

    if (userType != null && userType == "agent_recouvreur") {
      Navigator.pushNamed(context, '/home_page_agent_recouvreur');
    } else if (userType != null && userType == "admin") {
      Navigator.pushNamed(context, '/home_page_admin');
    } else if (userType != null && userType == "locataire") {
      Navigator.pushNamed(context, '/home_page_locataire');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
      child: Loading(
          indicator: BallPulseIndicator(), size: 100.0, color: Colors.green),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

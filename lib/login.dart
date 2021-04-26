import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController identifiant = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool invalidUser = false;
  // ignore: missing_return
  Future<List> sendata() async {
    final response = await http
        .post("https://groupetasnim.com/ts_requetes/verif.php", body: {
      "login": "true",
      "identifiant": identifiant.text,
      "password": password.text,
    });
    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      var userType = datauser[2];
      var nomUser = datauser[3];
      var prenomUser = datauser[4];

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('userType', "$userType");

      SharedPreferences localStorage1 = await SharedPreferences.getInstance();
      localStorage1.setString('nomUser', "$nomUser");

      SharedPreferences localStorage2 = await SharedPreferences.getInstance();
      localStorage2.setString('prenomUser', "$prenomUser");

      log('User type : $userType');
      log('User last name : $nomUser');
      log('User first name : $prenomUser');

      Navigator.pushNamed(context, '/check_user_type');
    } else {
      log("Empty data user");
      setState(() {
        invalidUser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('images/logoGroupeTasnim.png')),
              const SizedBox(height: 60),
              TextField(
                controller: identifiant,
                decoration: new InputDecoration(
                    // icon: FaIcon(FontAwesomeIcons.user),
                    // prefixIcon: FaIcon(FontAwesomeIcons.user),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Identifiant",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: password,
                decoration: new InputDecoration(
                    // icon: FaIcon(FontAwesomeIcons.lock),
                    // prefixIcon: FaIcon(FontAwesomeIcons.lock),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Mot de passe ",
                    fillColor: Colors.white70),
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // ignore: deprecated_member_use
              FlatButton(
                onPressed: sendata,
                color: Colors.green,
                child: Text("Connexion",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.green)),
              ),
              invalidUser
                  ? Text(
                      "Aucun compte trouvé",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  : SizedBox(height: 5),
              // RaisedButton(
              //   color: Colors.white,
              //   textColor: Colors.green,
              //   onPressed: () {},
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       side: BorderSide(color: Colors.green)),
              //   child: const Text('Connexion', style: TextStyle(fontSize: 20)),
              // ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

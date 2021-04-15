import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              // Image(
              //   image: AssetImage('images/logo.jpeg'),
              //   width: 100,
              // ),
              const SizedBox(height: 60),
              TextField(
                //controller: identifiant,
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
                //controller: password,
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
              FlatButton(
                onPressed: (){},
                color: Colors.green,
                child: Text("Connexion",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.green)),
              ),
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
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_requetes/agent_recouvreur/detais_locataire.dart';
import 'package:ts_requetes/agent_recouvreur/requetes.dart';

class HomePageAgentRecouvreur extends StatefulWidget {
  HomePageAgentRecouvreur({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageAgentRecouvreurState createState() =>
      _HomePageAgentRecouvreurState();
}

class _HomePageAgentRecouvreurState extends State<HomePageAgentRecouvreur> {
  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushNamed(context, '/main');
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('This is a demo alert dialog.'),
                Text('Voulez vous vraiment vous déconnecter ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oui'),
              onPressed: () {
                logout();
              },
            ),
            TextButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future listeLocataires() async {
    var url = "https://groupetasnim.com/ts_requetes/liste_locataires.php";
    var reponse = await http.get(url);
    return json.decode(reponse.body);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Encadreur réligieux'),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.userPlus),
                title: Text('Liste des locataires'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.users),
                title: Text('Requêtes'),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (builderContext) => new Requetes()));
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                title: Text('Déconnexion'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  _showMyDialog();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Liste des locataires"),
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              child: FutureBuilder(
                future: listeLocataires(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            return Card(
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                    list[index]['Prenoms'] +
                                        " " +
                                        list[index]['Nom'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  trailing: Icon(Icons.arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsLocataire(
                                                  id: list[index]
                                                      ['CodeParticulier'])),
                                    );
                                  },
                                ),
                              ),
                            );
                          })
                      : Center();
                },
              ),
            )
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

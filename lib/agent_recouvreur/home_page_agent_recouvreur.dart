import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts_requetes/agent_recouvreur/detais_locataire.dart';
import 'package:ts_requetes/agent_recouvreur/requetes.dart';

class HomePageAgentRecouvreur extends StatefulWidget {
  HomePageAgentRecouvreur({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageAgentRecouvreurState createState() =>
      _HomePageAgentRecouvreurState();
}

class _HomePageAgentRecouvreurState extends State<HomePageAgentRecouvreur> {
  bool issearch = false;

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

  showSearchBar() {
    setState(() {
      issearch = true;
    });
  }

  hideSearchBar() {
    setState(() {
      issearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Agent recouvreur'),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.userPlus),
                title: Text('Liste des locataires'),
                onTap: () {},
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
                  _showMyDialog();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          brightness: Brightness.dark,
          title: issearch
              ? TextFormField(
                  decoration: InputDecoration(
                    hintText: "Recherche...",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  onFieldSubmitted: (val) {
                    print(val);
                  },
                )
              : Text("Liste des locataires"),
          actions: [
            issearch
                ? IconButton(icon: Icon(Icons.close), onPressed: hideSearchBar)
                : IconButton(icon: Icon(Icons.search), onPressed: showSearchBar)
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 670,
              child: FutureBuilder(
                future: listeLocataires(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
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

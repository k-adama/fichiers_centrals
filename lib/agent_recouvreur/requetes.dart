import 'package:flutter/material.dart';

class Requetes extends StatefulWidget {
  final String id;
  Requetes({Key key, this.id}) : super(key: key);
  @override
  _RequetesState createState() => _RequetesState();
}

class _RequetesState extends State<Requetes> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Center(child: Text("Détails infos locataire")),
    );
  }
}

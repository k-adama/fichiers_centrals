import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsLocataire extends StatefulWidget {
  final String id;
  final String title;
  DetailsLocataire({this.id, this.title});

  @override
  _DetailsLocataireState createState() => _DetailsLocataireState();
}

class _DetailsLocataireState extends State<DetailsLocataire> {
  // ignore: missing_return
  Future<List> getDetailsLocataires() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    final res = await http.get(
        'https://groupetasnim.com/ts_requetes/details_locataire.php?CodeParticulier=${widget.id}',
        headers: headers);

    print(res.body);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Détails Locataire"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDetailsLocataires(),
                builder: (ctx, ss) {
                  if (ss.hasError) {
                    print('Erreur de connexion aux données');
                  }
                  if (ss.hasData) {
                    final datas = ss.data;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Date'),
                                trailing: datas[i]['date'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['date']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Libellé'),
                                subtitle: datas[i]['libelle'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['libelle']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Nom'),
                                subtitle: datas[i]['nom'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['nom']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Numéro facture'),
                                subtitle: datas[i]['montant'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['montant']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Précision'),
                                subtitle: datas[i]['charges_precision'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['charges_precision']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Montant'),
                                subtitle: datas[i]['montant'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['montant']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Règlement'),
                                subtitle: datas[i]['reglement'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['reglement']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text('Reste à régler'),
                                subtitle: datas[i]['rap'] == null
                                    ? Text(
                                        'Non renseigné',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        '${datas[i]['rap']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        itemCount: datas.length,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

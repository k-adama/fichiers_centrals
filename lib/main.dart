import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      initialRoute: '/',
      
      title: 'Fichier central',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: Test(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ), 
      body: Center(
        
        
      ),
     
    );
  }
}

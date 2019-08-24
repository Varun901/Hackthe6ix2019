import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackthe6ix/home.dart';
import 'package:hackthe6ix/in_need.dart';
import 'package:hackthe6ix/not_found.dart';
import 'package:hackthe6ix/sponsor.dart';

class App extends StatelessWidget {
  static const kPurpleNavy = Color(0xFF4C6085);
  static const kBrilliantAzure = Color(0xFF39A0ED);
  static const kTurquoise = Color(0xFF36F1CD);
  static const kAmazonite = Color(0xFF13C4A3);
  static const kJet = Color(0xFF32322C);
  static DocumentReference session;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      onGenerateRoute: (routeSettings) {
        final name = routeSettings.name;
        if (name == '/home')
          return MaterialPageRoute(builder: (context) => Home());
        if (name == '/in_need')
          return MaterialPageRoute(builder: (context) => InNeed());
        if (name == '/sponsor')
          return MaterialPageRoute(builder: (context) => Sponsor());
        return MaterialPageRoute(builder: (context) => NotFound());
      },
      theme: ThemeData(
        accentColor: kBrilliantAzure,
        backgroundColor: kPurpleNavy,
        canvasColor: Colors.transparent,
        primaryColor: kAmazonite,
        scaffoldBackgroundColor: kPurpleNavy,
        textTheme: TextTheme(
          body1: TextStyle(
            color: kTurquoise,
            fontFamily: 'SourceSansPro',
          ),
          display1: TextStyle(
            color: kTurquoise,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w300,
          ),
          display2: TextStyle(
            color: kTurquoise,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w300,
          ),
          display3: TextStyle(
            color: kTurquoise,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w300,
          ),
          display4: TextStyle(
            color: kTurquoise,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
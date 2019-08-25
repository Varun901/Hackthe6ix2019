import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackthe6ix/home.dart';
import 'package:hackthe6ix/in_need.dart';
import 'package:hackthe6ix/not_found.dart';
import 'package:hackthe6ix/sign_up_in_need_success.dart';
import 'package:hackthe6ix/sponsor.dart';

class App extends StatelessWidget {
  static const kPurpleNavy = Color(0xFF4C6085);
  static const kBrilliantAzure = Color(0xFF39A0ED);
  static const kTurquoise = Color(0xFF36F1CD);
  static const kAmazonite = Color(0xFF13C4A3);
  static const kJet = Color(0xFF32322C);
  static Future<DocumentReference> session;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        final name = routeSettings.name;
        if (session == null)
          session =
              Firestore.instance.collection('session').add({'route': name});
        else
          session
              .then((session) => session.setData({'route': name}, merge: true));
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: App.kPurpleNavy));
        if (name == '/') return MaterialPageRoute(builder: (context) => Home());
        if (name == '/in_need')
          return MaterialPageRoute(builder: (context) => InNeed());
        if (name == '/sponsor')
          return MaterialPageRoute(builder: (context) => Sponsor());
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: App.kAmazonite));
        if (name == '/sign_up_in_need_success')
          return MaterialPageRoute(builder: (context) => SignUpInNeedSuccess());
        return MaterialPageRoute(builder: (context) => NotFound());
      },
      theme: ThemeData(
        accentColor: kBrilliantAzure,
        backgroundColor: kPurpleNavy,
        canvasColor: Colors.transparent,
        iconTheme: IconThemeData(color: kTurquoise),
        primaryColor: kAmazonite,
        scaffoldBackgroundColor: kPurpleNavy,
        textTheme: TextTheme(
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

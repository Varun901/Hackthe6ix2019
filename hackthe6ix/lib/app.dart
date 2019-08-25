import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackthe6ix/home.dart';
import 'package:hackthe6ix/in_need.dart';
import 'package:hackthe6ix/in_need_barcode.dart';
import 'package:hackthe6ix/in_need_barcode_failure.dart';
import 'package:hackthe6ix/in_need_barcode_success.dart';
import 'package:hackthe6ix/not_found.dart';
import 'package:hackthe6ix/sign_up_in_need_success.dart';
import 'package:hackthe6ix/sponsor.dart';

class App extends StatelessWidget {
  static const kPurpleNavy = Color(0xFF4C6085);
  static const kBrilliantAzure = Color(0xFF39A0ED);
  static const kTurquoise = Color(0xFF36F1CD);
  static const kAmazonite = Color(0xFF13C4A3);
  static const kJet = Color(0xFF32322C);
  static DocumentReference session;
  static GoogleSignInAccount account;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        final name = routeSettings.name;
        if (session == null)
          Firestore.instance
              .collection('session')
              .add({'route': name, 'launch_ts': DateTime.now()}).then(
                  (session) => App.session = session);
        else
          session.setData({'route': name}, merge: true);
        if (name == '/') return MaterialPageRoute(builder: (context) => Home());
        if (name == '/in_need')
          return MaterialPageRoute(builder: (context) => InNeed());
        if (name == '/in_need_barcode')
          return MaterialPageRoute(builder: (context) => InNeedBarcode());
        if (name == '/in_need_barcode_failure')
          return MaterialPageRoute(
              builder: (context) => InNeedBarcodeFailure());
        if (name == '/in_need_barcode_success')
          return MaterialPageRoute(
              builder: (context) => InNeedBarcodeSuccess());
        if (name == '/sign_up_in_need_success')
          return MaterialPageRoute(builder: (context) => SignUpInNeedSuccess());
        if (name == '/sponsor')
          return MaterialPageRoute(builder: (context) => Sponsor());
        return MaterialPageRoute(builder: (context) => NotFound());
      },
      theme: ThemeData(
        accentColor: kBrilliantAzure,
        backgroundColor: kPurpleNavy,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: kPurpleNavy,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
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

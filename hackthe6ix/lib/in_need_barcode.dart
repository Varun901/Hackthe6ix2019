import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackthe6ix/app.dart';

class InNeedBarcode extends StatefulWidget {
  @override
  _InNeedBarcodeState createState() => _InNeedBarcodeState();
}

class _InNeedBarcodeState extends State<InNeedBarcode> {
  bool found;

  @override
  void initState() {
    super.initState();
    found = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<DocumentSnapshot>(
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor)));
            return ListTile(
              leading: GoogleUserCircleAvatar(identity: App.account),
              title: Text(
                snapshot.data['username'],
                style: Theme.of(context).textTheme.display2,
                textScaleFactor: .5,
              ),
              subtitle: Text(
                '\$${snapshot.data['total'].toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.display1,
                textScaleFactor: .5,
              ),
            );
          },
          stream: App.session.snapshots(),
        ),
        Text(
          'Please scan your barcode.',
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white),
          textScaleFactor: .5,
        ),
        Container(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FittedBox(
            child: Container(
              child: CameraMlVision<List<Barcode>>(
                detector:
                    FirebaseVision.instance.barcodeDetector().detectInImage,
                onResult: (barcodes) {
                  if (found || barcodes.isEmpty) return;
                  found = true;
                  final barcode = barcodes
                      .map((barcode) => barcode.displayValue)
                      .toList()
                      .first;
                  App.session.setData({'barcode': barcode}, merge: true);
                  Dio()
                      .post('https://hack6.azurewebsites.net/scan/',
                          data: {'uuid': barcode})
                      .then((response) => Navigator.of(context)
                          .pushNamed('/in_need_barcode_success'))
                      .catchError((error) => Navigator.of(context)
                          .pushNamed('/in_need_barcode_failure'));
                },
              ),
              width: MediaQuery.of(context).size.width,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}

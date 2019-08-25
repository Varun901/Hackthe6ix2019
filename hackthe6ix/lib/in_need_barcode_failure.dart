import 'package:flutter/material.dart';
import 'package:hackthe6ix/app.dart';

class InNeedBarcodeFailure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
          body: InkWell(
        child: Center(
            child: Padding(
          child: Text(
            'Barcode failed to scan.',
            style: Theme.of(context).textTheme.display3.copyWith(
                  color: App.kPurpleNavy,
                  fontWeight: FontWeight.w600,
                ),
            textScaleFactor: .5,
          ),
          padding: EdgeInsets.all(24),
        )),
        highlightColor: Theme.of(context).canvasColor,
        onTap: () => Navigator.of(context).pushNamed('/'),
        splashColor: Theme.of(context).accentColor,
      )),
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: App.kAmazonite),
    );
  }
}

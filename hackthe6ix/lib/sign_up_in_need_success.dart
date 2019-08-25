import 'package:flutter/material.dart';
import 'package:hackthe6ix/app.dart';

class SignUpInNeedSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
          body: FutureBuilder<bool>(
        builder: (context, snapshot) {
          String string;
          if (!snapshot.hasData)
            string = 'Please wait while we authenticate your statement...';
          else
            string = snapshot.data
                ? 'You were successful in your application.'
                : 'An error occurred, please try again later.';
          return InkWell(
            child: Center(
                child: Padding(
              child: Text(
                string,
                style: Theme.of(context).textTheme.display3,
                textScaleFactor: .5,
              ),
              padding: EdgeInsets.all(24),
            )),
            highlightColor: Theme.of(context).canvasColor,
            onTap: !snapshot.hasData
                ? null
                : () => Navigator.of(context).pushNamed('/'),
            splashColor: Theme.of(context).accentColor,
          );
        },
        future: Future.delayed(Duration(seconds: 3), () => true),
      )),
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: App.kAmazonite,
        textTheme: Theme.of(context).textTheme.copyWith(
            display3: Theme.of(context).textTheme.display3.copyWith(
                  color: App.kPurpleNavy,
                  fontWeight: FontWeight.w600,
                )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackthe6ix/sign_up_in_need_camera.dart';

class SignUpInNeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Text(
            'Please take a photo of your tax assessment. It should look like this.',
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white),
            textScaleFactor: .5,
          ),
          Container(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              child: SingleChildScrollView(
                  child: Image.asset('assets/tax_assessment.jpg')),
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Container(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SignUpInNeedCamera(),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackthe6ix/app.dart';

class InNeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool>(
          builder: (context, snapshot) {
            return Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'c.',
                  style: Theme.of(context)
                      .textTheme
                      .display4
                      .copyWith(fontWeight: FontWeight.bold),
                  textScaleFactor: .5,
                ),
                padding: EdgeInsets.only(left: 24),
              ),
              Expanded(
                  child: Padding(
                child: Hero(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'in need',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        padding: EdgeInsets.all(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).textTheme.display3.color,
                        ),
                      ),
                    ),
                  ),
                  tag: 'in need',
                ),
                padding: EdgeInsets.all(12),
              )),
            ]);
          },
          future: Future.sync(() async {
            await GoogleSignIn().signOut();
            final googleUser = await GoogleSignIn().signIn();
            final auth = await googleUser.authentication;
            final credential = GoogleAuthProvider.getCredential(
              accessToken: auth.accessToken,
              idToken: auth.idToken,
            );
            final user =
                (await FirebaseAuth.instance.signInWithCredential(credential))
                    .user;
            (await App.session).setData({'uid': user.uid}, merge: true);
            return true;
          }),
        ),
      ),
    );
  }
}
